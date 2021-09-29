//
// GoQuick.orgのテスト
//

// GoQuick.org/masui でジャンプするかテストするにはどうすれば?


const URL = 'http://GoQuick.org/' // デプロイ環境

describe('GoQuickのテスト', () => {
    it('GoQuickにアクセス', () => {
	cy.visit(URL) // GoQuick.comサイトに移動

	// ログイン画面になるはずなので適当に登録
	cy.get('#username')
	    .clear()
	    .type('masui')
	cy.get('#password')
	    .clear()
	    .type('masui')
	cy.get('#loginbutton').click()
	
	const testEntries = [
	    {url: 'https://scrapbox.io/masui', name: 'masui', desc: '増井のページ'},
	    {url: 'https://example.com/', name: 'example', desc: 'Exampleページ'}
	]
	testEntries.forEach((entry) => {
	    cy.get('#shortname')
		.clear()
		.type(entry.name)
	    cy.get('#longname')
		.clear()
		.type(entry.url)
	    cy.get('#description')
		.clear()
		.type(entry.desc)
	    cy.get('#registerbutton').click()
	
	    // 登録できてるかチェック
	    cy.visit(`http://GoQuick.org/${entry.name}!`)
	    cy.get('#shortname')
		.should('have.value', entry.name)
	    cy.get('#longname')
		.should('have.value', entry.url)
	    cy.get('#description')
		.should('have.value', entry.desc)

	    cy.request({
		url: `http://GoQuick.org/${entry.name}`,
		followRedirect: false, // GoQuickのリダイレクトを止める
	    }).then((res) => {
		expect(res.status).to.eq(302) // リダイレクトのステータスコード
		expect(res.redirectedToUrl).to.eq(entry.url) // 登録したアドレス?
	    })
	})
    })
})
