const puppeteer = require('puppeteer')

const BASE_URL = 'https://www.deezer.com/pl'

const deezer = {

    browser: null,
    page: null,

    initialize: async () => {

        deezer.browser = await puppeteer.launch({
            headless: false,
            defaultViewport: null,
            args: [
                '--no-sandbox',
                '--disable-setuid-sandbox',
            ]
        })

        deezer.page = await deezer.browser.newPage()

        await deezer.page.goto(BASE_URL, {waitUntil: 'networkidle2'})

    }
}

module.exports = deezer