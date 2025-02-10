# 倒计时函数
`js

    import { honsUtils } from '@hons/ts-utils'

    const stop = honsUtils.countdown(remainSeconds, obj => {
        console.log(JSON.stringify(obj))
    })

    // 停止倒计时
    stop()
`