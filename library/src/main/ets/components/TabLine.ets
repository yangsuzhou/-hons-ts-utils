import { LineStyleType, TabLineItemType } from "../types"

const defaultLineStyle: LineStyleType = { strokeWidth: 0.5, color: 'rgba(26, 23, 27, 1)' }
const defaultLineTrackStyle: LineStyleType = { strokeWidth: 0.5, color: 'rgba(26, 23, 27, 0.12)' }

@Component
export struct TabLine {
    private scroller: Scroller = new Scroller()
    @State private visibleRatio: number[] = []
    @State @Watch('changeOffset') @Watch('disableScrollGap') private widthItemList: Length[] = []
    @State @Watch('disableScrollGap') private widthBox: Length = 0
    @State @Watch('changeOffset') private disableGap: number = 0
    @State private offsetX: Length = 0
    onChange: (index: number) => void = () => null
    keyGenerator: (item: TabLineItemType, index: number) => string = (item, index) => index.toString()
    @Require @Prop @Watch('disableScrollGap') tabList: Array<TabLineItemType> = []
    @Require @BuilderParam itemGenerator: (item: TabLineItemType, index: number) => void
    @Prop @Watch('changeOffset') index: number = 0
    @Prop gutter: number = 16
    @Prop lineStyle: LineStyleType = defaultLineStyle
    @Prop lineTrack: LineStyleType = defaultLineTrackStyle
    @Prop itemHeight: Length = 44
    @Prop enableScroll: boolean = true
    @Prop duration: number = 100
    @Prop forceInView: boolean = true

    aboutToAppear(): void {
        this.changeOffset(true)
    }

    disableScrollGap() {
        const itemFullWidth = this.widthItemList.reduce((pre, cur) => ((pre || 0) as number) + ((cur || 0) as number), 0) as number
        this.disableGap = ((this.widthBox as number) - itemFullWidth) / (this.tabList.length - 1)
    }

    changeOffset(initial: boolean = false) {
        this.getUIContext().animateTo({ duration: initial === true ? 0 : this.duration }, () => {
            const tmp =
                this.widthItemList.slice(0, this.index).reduce((pre, cur) => ((pre || 0) as number) + ((cur || 0) as number), 0) as number
            if (this.enableScroll) {
                const gap = this.index * this.gutter as number
                this.offsetX = tmp + gap
            } else {
                this.offsetX = tmp + (this.disableGap * this.index)
            }
        })
    }

    changeScrollPosition(idx: number) {
        if (!this.visibleRatio[idx] || this.visibleRatio[idx] < 1) {
            const tmp =
                (this.widthItemList.slice(0, idx).reduce((pre, cur) => ((pre || 0) as number) + ((cur || 0) as number), 0) as number)
            const gap = idx * this.gutter as number
            this.scroller.scrollTo({ xOffset: tmp + gap, yOffset: 0, animation: { duration: this.duration } })
        }
    }

    @Builder
    itemBuilder(item: TabLineItemType, idx: number) {
        Row() {
            this.itemGenerator(item, idx)
        }
        .height('100%')
        .onTouch(() => {
            this.index = idx
            this.onChange?.(this.index)
            this.changeOffset()
            if (this.forceInView) {
                this.changeScrollPosition(idx)
            }
        })
        .onAreaChange((old, newV) => {
            this.widthItemList[idx] = newV.width
        })
        .onVisibleAreaChange([0.0, 1.0], (isVisible, currentRatio) => {
            this.visibleRatio[idx] = currentRatio
        })
    }

    @Builder
    LineBuilder() {
        Row() {
            Stack({ alignContent: Alignment.BottomStart }) {
                Divider()
                    .width('100%')
                    .strokeWidth(this.lineTrack.strokeWidth || defaultLineTrackStyle.strokeWidth)
                    .color(this.lineTrack.color || defaultLineTrackStyle.color)
                Divider()
                    .width(this.widthItemList[this.index])
                    .strokeWidth(this.lineStyle.strokeWidth || defaultLineStyle.strokeWidth)
                    .color(this.lineStyle.color || defaultLineStyle.color)
                    .offset({ x: this.offsetX })
            }.constraintSize({ minWidth: '100%' })
        }.constraintSize({ minWidth: '100%' }).width(this.widthBox)
    }

    build() {
        Scroll(this.scroller) {
            Stack({ alignContent: Alignment.BottomStart }) {
                Row({ space: this.enableScroll ? this.gutter : 0 }) {
                    ForEach(this.tabList, (item: TabLineItemType, idx: number) => {
                        this.itemBuilder(item, idx)
                    }, this.keyGenerator)
                }
                .width(this.enableScroll ? 'auto' : '100%')
                .height('100%')
                .justifyContent(this.enableScroll ? FlexAlign.Start : FlexAlign.SpaceBetween)
                .onAreaChange((old, newV) => {
                    this.widthBox = newV.width
                })

                this.LineBuilder()
            }.constraintSize({ minWidth: '100%' }).height('100%')
        }
        .width('100%')
        .height(this.itemHeight)
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.None)
        .enableScrollInteraction(this.enableScroll)
    }
}