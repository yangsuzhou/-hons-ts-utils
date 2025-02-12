# 版本记录

## 1.0.1
1. 优化 countDown 倒计时函数，其第二个参数的回调函数中添加了第二个参数，用于获取剩余所有秒数，目的: 用于 判断 倒计时结束时 是否需要添加额外逻辑
```
 import { honsUtils } from '@hons/utils'

    const stop = honsUtils.countDown(remainSeconds, (obj, remainSeconds) => {
        console.log(JSON.stringify(obj))
        if (remainSeconds === 0) {
            // 写入倒计时结束时的逻辑处理
        }
    })

    // 停止倒计时
    stop()
```

## 1.0.0
1. 发布1.0.0初版.