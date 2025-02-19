# @hons/utils (纯TS工具函数)

## 下载安装与使用说明

`ohpm i @hons/utils`

| 方法          | 介绍    |
|:------------|:------|
| countDown   | 倒计时   |
| formatPrice | 价格格式化 |

## 组件

| 组件      | 介绍                                                                      |
|:--------|:------------------------------------------------------------------------|
| TabLine | Tab, 可配置滚动与否、是否具备下划线并且下划线色值、高度, 可滚动状态下，如果被点击组件(元素)未全部在视口内，则可配置其是否滚动到视口内 |

## TabLineOption

| Parameter     | Type                                             | Default                                            | Description                                                                               |
|:--------------|:-------------------------------------------------|:---------------------------------------------------|:------------------------------------------------------------------------------------------|
| onChange      | (index: number) => void                          | -                                                  | 下标变化时的回调                                                                                  |
| keyGenerator  | (item: TabLineItemType, index: number) => string | -                                                  | 性能优化的key配置                                                                                |
| tabList       | Array<TabLineItemType>                           | []                                                 | Tab列表                                                                                     |
| itemGenerator | (item: TabLineItemType, index: number) => void   | -                                                  | 生成 TabItem内容                                                                              |
| index         | number                                           | 0                                                  | 选中的下标                                                                                     |
| gutter        | number                                           | 16                                                 | Item之间的间距 (*注*: 当禁止滚动.即 enableScroll 为 false 时，gutter配置无效，将会用 FlexAlign.SpaceBetween 布局 ) |
| lineStyle     | LineStyleType                                    | { strokeWidth: 0.5, color: 'rgba(26, 23, 27, 1)' } | 高亮线条 样式配置                                                                                 |
| lineTrack     | LineStyleType                                    | { strokeWidth: 0.5, color: 'rgba(26, 23, 27, 1)' } | 底部线条 样式配置 (位于高亮线条底部)                                                                      |
| itemHeight    | Length                                           | 44                                                 | Item高度 (如果Item文案并非居中，可设置最小的间距，并通过 itemGenerator 设置剩余的间距)                                  |
| enableScroll  | boolean                                          | true                                               | 是否允许滚动 (*注*: 为false时，gutter无效， Item 位置将由 FlexAlign.SpaceBetween 控制)                       |
| duration      | number                                           | 100                                                | 线条滚动时长、视口外Item被点击时，如果配置了forceInView 为true，则自动滚动进入视口范围的 滚动时长                               |
| forceInView   | boolean                                          | true                                               | 如果为true，当可滚动时， 点击视口外的Item，会自动将被点击的Item滚动到视口内                                              |
