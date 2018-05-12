#
# ローカルにSinatraを走らせる
# データベースはHerokuのMongoを使う
#
local:
	MONGODB_URI=`heroku config -a quickbm | grep MONGODB_URI | ruby -n -e 'puts $$_.split[1]'` ruby goquick.rb

clean:
	/bin/rm -f *~ */*~

push:
	git push git@github.com:masui/GoQuick.git

backup:
	cd backups; make

favicon:
	convert images/favicon.png -define icon:auto-resize=64,32,16 public/favicon.ico
