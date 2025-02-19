# 版本记录

## 1.0.2
1. 添加 TabLine 组件，用于构建 可配置下划线、是否可滚动的Tab组件
```
import { TabLineItemType, TabLine } from '@hons/utils';

@State curTab: number = 1
private tabList: TabLineItemType[] = [
    { title: '新闻', key: '1' },
    { title: '娱乐', key: '2' },
    { title: '军事', key: '3' },
]

@Builder
tabItem(item: TabLineItemType, index: number) {
    Text(item.title)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.curTab === index ? Color.Red : Color.Black)
        .onClick(() => {
            this.curTab = index
        })
}

TabLine({
    gutter: 160,
    enableScroll: true,
    forceInView: true,
    index: this.curTab,
    lineTrack: { strokeWidth: 1, color: 'rgba(0,0,0,0.12)' },
    lineStyle: { strokeWidth: 1, color: '#AA000000' },
    onChange: (idx) => {
        this.curTab = idx
    },
    tabList: this.tabList,
    itemGenerator: (item: TabLineItemType, index: number) => { // 注意: 此处推荐这样写，否则this指向会出问题；你也可以使用bind 改变this指向
        this.tabItem(item, index)
    },
    keyGenerator: (item: TabLineItemType, index) => item.key!,
})
    
```

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