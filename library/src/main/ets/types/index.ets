export interface CallbackParameters {
    hour: string
    minute: string
    second: string
}

export type Callback = (params: CallbackParameters, remainAllSeconds: number) => void