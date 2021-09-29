//
// GoQuick.orgのテスト
//

// GoQuick.org/masui でジャンプするかテストするにはどうすれば?


const URL = 'http://GoQuick.org/' // デプロイ環境

describe('GoQuickのテスト', () => {
    it('GoQuickにアクセス', () => {
	cy.visit(URL) // GoQuick.comサイトに移動
	cy.get('#username')
	    .clear()
	    .type('masui')
	cy.get('#password')
	    .clear()
	    .type('masui')
	cy.get('#loginbutton').click()
	
	cy.get('#shortname')
	    .clear()
	    .type('masui')
	cy.get('#longname')
	    .clear()
	    .type('https://Scrapbox.io/masui')
	cy.get('#description')
	    .clear()
	    .type('増井のScrapboxページ')
	cy.get('#registerbutton').click()

	// 登録できてるかチェック
	cy.visit('http://GoQuick.org/masui!')
	cy.get('#shortname')
	    .should('have.value', 'masui')
	cy.get('#longname')
	    .should('have.value', 'https://Scrapbox.io/masui')
	cy.get('#description')
	    .should('have.value', '増井のScrapboxページ')
    })

    //it('Scrapboxにアクセス', () => {
    // cy.visit('http://GoQuick.org/masui')
    //})
})
