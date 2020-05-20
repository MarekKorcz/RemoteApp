var iterator = 0

function timeout() {
    setTimeout(function () {
        
        console.log(`yolo ${iterator}`)
        iterator++

        timeout();
    }, 500)
}

timeout()