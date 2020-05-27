
function life() {

    // let lifeSpan = String(Math.random(0, 100)).split('.')
    // let totalHealth = String(Math.random(0, 100)).split('.')

    // console.log(lifeSpan)
    // console.log(totalHealth)

    // console.log(`lifeSpan = ${lifeSpan}`)
    // console.log(`totalHealth = ${totalHealth}`)

    // for(let d = 0; d < lifeSpan; d++) {
        
    //     ((d) => {
    //         setTimeout(() => {
    //             console.log(`Happy birthday. You're ${lifeSpan} old. You're about to die in ${totalHealth} days.`)
    //         }, 1000)
    //     })()
        
    // }

    setTimeout(() => {

        var date = Date(Date.now()); 
        var now = date.toString()

        console.log(`click - ${now}`)

        life()
    }, 1000)    
}

life()