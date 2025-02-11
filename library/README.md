# @hons/utils (纯TS工具函数)

## 下载安装与使用说明

`ohpm i @hons/utils`

| 方法          | 介绍    |
|:------------|:------|
| countDown   | 倒计时   |
| formatPrice | 价格格式化 |

# Usage

`

    import { honsUtils } from '@hons/utils'

    const stop = honsUtils.countDown(remainSeconds, obj => {
        console.log(JSON.stringify(obj))
    })

    // 停止倒计时
    stop()

`