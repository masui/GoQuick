//
// GoQuick.orgのテスト
//

const GoQuick = 'http://GoQuick.org/' // デプロイ環境

describe('GoQuickのテスト', () => {
    beforeEach(() => {
	cy.visit(GoQuick) // GoQuick.orgサイトに移動
	// ログイン画面になるはずなので適当に登録してログイン
	cy.get('#username')
	    .clear()
	    .type('masui')
	cy.get('#password')
	    .clear()
	    .type('masui')
	cy.get('#loginbutton').click()
    })

    it('登録してないときGoogle検索', () => {
	const keywords = [
	    'abcdefg',
	    'VeryLongSearchString'
	]
	keywords.forEach((keyword) => {
	    cy.request({
		url: `http://GoQuick.org/${keyword}`,
		followRedirect: false, // GoQuickのリダイレクトを止める
	    }).then((res) => {
		expect(res.status).to.eq(302) // リダイレクトのステータスコード
		expect(res.redirectedToUrl).to.eq(`https://www.google.com/search?q=${keyword}`)
	    })
	})
    })
	
    it('アドレスの登録とリダイレクトのテスト', () => {
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

	    // https://docs.cypress.io/api/commands/request#Options
	    cy.request({
		url: `http://GoQuick.org/${entry.name}`,
		followRedirect: false, // GoQuickのリダイレクトを止める
	    }).then((res) => {
		expect(res.status).to.eq(302) // リダイレクトのステータスコード
		expect(res.redirectedToUrl).to.eq(entry.url) // 登録したアドレスかチェック
	    })
	})
    })
})
