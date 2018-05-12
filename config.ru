require 'rubygems'
require 'sinatra'
  
require './goquick.rb'

Encoding.default_external = 'utf-8'

run Sinatra::Application
