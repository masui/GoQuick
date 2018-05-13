# coding: utf-8
#
# Mongoデータをバックアップ
#

require 'date'

config = `heroku config -a episopass`
config.split(/\n/).each { |line|
  if line =~ /^MONGODB_URI:\s+(.*)$/
    URI = $1
    URI =~ /mongodb:\/\/(.*):(.*)@(.*):(.*)\/(.*)/
    user = $1
    password = $2
    host = $3
    port = $4
    database = $5
    d = Date.today
    t = Time.now
    command = "mongoexport -u #{user} -p #{password} -d #{database} -h #{host} --port #{port} -c episopass --out backup#{t.strftime("%Y%m%d%H%M%S")}"
    puts command
    system command
  end
}

