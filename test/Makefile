#
# Cypressによるテスト
#
# npx cypress openするとcypressディレクトリにいろいろ作られるが
# これが無いと動かない。
# make cleanしたあと、make install; make open しないと
# make run が動かないようだ
# (cypress.jsonが無いとか言われる)
#


test:
	npx cypress run -s cypress/integration/goquick.js

# GUIの場合
open:
	npx cypress open

install:
	yarn add --dev cypress

clean:
	/bin/rm -r -f node_modules
	/bin/rm -f *~
	/bin/rm -f package.json
	/bin/rm -f cypress.json
	/bin/rm -f yarn.lock

