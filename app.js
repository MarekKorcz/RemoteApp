// init environment variables
const {
    APP_PORT
} = process.env

// init express
const express = require('express')
const app = express()

// get static routings with views files
const path = require('path')
app.use(express.static(path.join(__dirname, 'public')))

app.get('/', (req, res) => {
    res.send('<h1>Home</h1>')
})

app.listen(APP_PORT, () => console.log(`Server running on port ${APP_PORT}`))