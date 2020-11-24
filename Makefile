#
# データベースはAtlasののMongoを使う
# URIはHEROKUに登録している
#  user: masui
#  pass: http://www.pitecan.com/p/Atlas_tmasui@gmail.com
#  collectionはgoquick
#

backup:
	git pull
	mongoexport --uri=`heroku config -a quickbm | grep MONGODB_URI | ruby -n -e 'puts $$_.split[1].sub(/\?.*$$/,"")'` -c goquick -o backup.json
	-git commit -a -m backup	
	-git push git@github.com:masui/GoQuick.git

# ローカルにSinatraを走らせる
local:
	MONGODB_URI=`heroku config -a quickgo | grep MONGODB_URI | ruby -n -e 'puts $$_.split[1]'` ruby goquick.rb

clean:
	/bin/rm -f *~ */*~

# push:
# 	git add backups/*.json
# 	git commit -a -m backup	
# 	git push git@github.com:masui/GoQuick.git

push:
 	git push git@github.com:masui/GoQuick.git

favicon:
	convert images/favicon.png -define icon:auto-resize=64,32,16 public/favicon.ico
