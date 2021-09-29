# -*- coding: utf-8 -*-
# -*- ruby -*-

$:.unshift File.expand_path 'lib', File.dirname(__FILE__)

require 'sinatra'
require 'sinatra/cookies'
require 'sinatra/cross_origin'
require 'mongo'
require 'json'
require 'digest/md5'
require 'cgi'

$bmdb = Mongo::Client.new(ENV['MONGODB_URI'])[:goquick]

configure do
  set :root, File.dirname(__FILE__)
  set :public_folder, settings.root + '/public'
  set :cookie_options, :expires => Time.now + 24 * 60 * 60 * 1000
  enable :cross_origin
end

before do
  response.headers['Access-Control-Allow-Origin'] = '*'
end

def getcookie
  @username = cookies[:username].to_s
  @hash = cookies[:hash].to_s
  redirect "/_login" if @username == ''
end

get '/_login' do
  cookies[:username] = ''
  erb :login
end

#get '/dump' do
#  getcookie
#  data = []
#  $bmdb.find({username: username}).each { |e|
#    d = {}
#    d['shortname'] = e['shortname']
#    d['longname'] = e['longname']
#    d['description'] = e['description']
#    data.push(d)
#  }
#  data.to_json
#end
  
post '/_register' do
  getcookie
  shortname = params['shortname']
  $bmdb.delete_many({hash: @hash, shortname: shortname})
  d = {
    hash: @hash,
    shortname: shortname,
    longname: params['longname'],
    description: params['description']
  }
  $bmdb.insert_one(d)
  redirect '/'
end

get '/_edit' do
  getcookie
  @description = params['description']
  @longname = params['longname']
  erb :edit
end

# get '/:name!' do |shortname|

get '/*!' do
  shortname = params['splat'].join('/') # a/b みたいなのを許す
  getcookie
  if shortname =~ /^[a-zA-Z0-9_\-]+$/
    data = $bmdb.find({hash: @hash, shortname: shortname}).limit(1).first
    if data
      @shortname = shortname
      @description = data['description']
      @longname = data['longname']
    end
    erb :edit
  else 
    @data = $bmdb.find({hash: @hash})
    erb :list
  end
end

post '/' do # ログインフォームから
  cookies[:username] = params['username'].to_s
  cookies[:hash] = Digest::MD5.hexdigest(params['username'].to_s + params['password'].to_s)
  getcookie
  redirect '/'
end

get '/' do
  getcookie
  # リスト表示
  @data = {}
  if @hash.to_s != ''
    @data = $bmdb.find({hash: @hash})
  end
  erb :list
end

get '/*' do
  shortname = params['splat'].join('/') # a/b みたいなのを許す
  getcookie

  unless shortname =~ /^[a-zA-Z0-9_\-]+$/
    redirect "https://www.google.com/search?q=#{shortname}"
  end

  data = $bmdb.find({hash: @hash, shortname: shortname}).limit(1).first
  if request.env['HTTP_REFERER'].to_s.include?(request.env['HTTP_HOST'])
    if data
      @shortname = shortname
      @description = data['description']
      @longname = data['longname']
    end
    erb :edit
  else
    if data then
      redirect data['longname']
    else
      redirect "https://www.google.com/search?q=#{shortname}"
      # redirect "https://www.google.com/search?q=#{URI.encode{shortname}}"
    end
  end
end

