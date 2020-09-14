const puppeteer = require('puppeteer')
const { createCursor } = require('ghost-cursor')
const { randomWaitTimeBeforeReact } = require('./common/functions')

// const VIEWPORT_WIDTH = 375
// const VIEWPORT_HEIGHT = 667

const COUNTRY_CODE = 'pl'
// const BASE_URL = `https://www.deezer.com/${COUNTRY_CODE}`
const BASE_URL = 'http://localhost/login'

const deezer = {

    browser: null,
    page: null,

    initialize: async () => {

        deezer.browser = await puppeteer.launch({
            // headless: false,
            devtools: true,
            // pipe: true,?
            // defaultViewport: {
            //     width: VIEWPORT_WIDTH + 12, // wtf?,
            //     height: VIEWPORT_HEIGHT
            // },
            args: [
                // `--window-size=${VIEWPORT_WIDTH},${VIEWPORT_HEIGHT}`
                // '--user-agent=Mozilla/5.0 (iPhone; CPU iPhone OS 12_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148'
            ]
        })

        // console.log(await deezer.browser.userAgent())

        deezer.page = await deezer.browser.newPage()

        try {

            // use cursor
            const cursor = createCursor(deezer.page, {
                x: 100,
                y: 200
            })

            await deezer.page.goto(BASE_URL, {waitUntil: 'networkidle2'})
            await deezer.page.waitFor(randomWaitTimeBeforeReact())
            await cursor.move('a[name="submit"]')
            await cursor.click()



            // await deezer.cookieElementRemover()
            


            //////////////////////////////////////////////////////////////////////////////
            // let userAgent = await deezer.page.evaluate(() => {
            //     return document.querySelector('#detected_value > a').innerHTML
            // })
            // console.log(userAgent)
            //////////////////////////////////////////////////////////////////////////////
            // let navigator = await deezer.page.evaluate(() => {
            //     return navigator.userAgent
            // })
            // console.log(navigator)
            //////////////////////////////////////////////////////////////////////////////
            // let sizeArr = await deezer.page.evaluate(() => {
            //     return {
            //         width: document.documentElement.clientWidth,
            //         height: document.documentElement.clientHeight,
            //         deviceScaleFactor: window.devicePixelRatio
            //     }
            // })
            // console.log(sizeArr)
            //////////////////////////////////////////////////////////////////////////////
            // await deezer.page.screenshot({path: 'screenshots/google.png'});
            //////////////////////////////////////////////////////////////////////////////

        } catch (error) {

            console.log(`Error in initialize function: ${error}`)
        }
    },

    cookieElementRemover: async () => {

        const cookieElementButton = await deezer.page.$('button.cookie-btn')

        if (cookieElementButton)
            cookieElementButton.click()
    }
}

module.exports = deezer