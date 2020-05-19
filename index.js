// const { exec } = require("child_process")

// exec("touch new.js; rm -rf new.js;")

// exec("ls -la", (error, stdout, stderr) => {
//     if (error) {
//         console.log(`error: ${error.message}`);
//         return;
//     }
//     if (stderr) {
//         console.log(`stderr: ${stderr}`);
//         return;
//     }
//     console.log(stdout);
// })


function timeout() {
    setTimeout(function () {
        
        console.log('yolo')

        timeout();
    }, 500)
}

timeout()