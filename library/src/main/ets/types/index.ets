export interface CallbackParameters {
    hour: string
    minute: string
    second: string
}

export type Callback = (params: CallbackParameters, remainAllSeconds: number) => void

export interface TabLineItemType {
    title: string
    key?: string
}

export interface LineStyleType {
    strokeWidth?: number | string
    color?: ResourceColor
}