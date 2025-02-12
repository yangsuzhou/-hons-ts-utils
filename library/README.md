# @hons/utils (纯TS工具函数)

## 下载安装与使用说明

`ohpm i @hons/utils`

| 方法          | 介绍    |
|:------------|:------|
| countDown   | 倒计时   |
| formatPrice | 价格格式化 |

# Usage

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