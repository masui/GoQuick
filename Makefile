#
# ローカルにSinatraを走らせる
# データベースはHerokuのMongoを使う
#
local:
	MONGODB_URI=`heroku config -a quickbm | grep MONGODB_URI | ruby -n -e 'puts $$_.split[1]'` ruby goquick.rb

backup:
	mongoexport --uri=`heroku config -a quickbm | grep MONGODB_URI | ruby -n -e 'puts $$_.split[1].sub(/\?.*$$/,"")'` -c goquick -o backups/`ruby -e 'puts Time.now.strftime("%Y%m%d%H%M%S")'`.json

clean:
	/bin/rm -f *~ */*~

push:
	git push git@github.com:masui/GoQuick.git

#backup:
#	cd backups; make

favicon:
	convert images/favicon.png -define icon:auto-resize=64,32,16 public/favicon.ico

