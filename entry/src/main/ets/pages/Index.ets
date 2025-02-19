import { TabLineItemType, TabLine } from '@hons/utils';

@Entry
@Component
struct Index {
    @State message: string = 'Hello World';
    @State curTab: number = 1
    private tabList: TabLineItemType[] = [
        { title: '车型', key: '1' },
        { title: '备胎', key: '2' },
        { title: '外观', key: '3' },
        { title: '车轮', key: '4' },
        { title: '内饰', key: '5' },
        { title: '选装', key: '6' },
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

    build() {
        Column() {
            Text(this.curTab.toString())
            TabLine({
                gutter: 16,
                itemHeight: 'auto',
                enableScroll: true,
                forceInView: true,
                index: this.curTab,
                lineTrack: { strokeWidth: 1, color: 'rgba(0,0,0,0.12)' },
                lineStyle: { strokeWidth: 1, color: '#AA000000' },
                onChange: (idx) => {
                    this.curTab = idx
                },
                tabList: this.tabList,
                itemGenerator: (item: TabLineItemType, index: number) => {
                    this.tabItem(item, index)
                },
                keyGenerator: (item: TabLineItemType, index) => item.key!,
            })
        }.width('100%').padding({ left: 16, right: 16 })
    }
}

@Component
struct TabItem {
    build() {
    }
}