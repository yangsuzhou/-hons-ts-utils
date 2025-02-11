import { Callback, CallbackParameters } from "../types"

class HonsUtils {
    private padStart(val: number | string) {
        return `0${val}`.slice(-2)
    }

    private formatTime(seconds: number): CallbackParameters {
        const hour = Math.floor(seconds / 3600)
        const minute = Math.floor((seconds % 3600) / 60)
        const second = seconds % 60
        return { hour: this.padStart(hour), minute: this.padStart(minute), second: this.padStart(second) }
    }

    /**
     * 倒计时
     * @param seconds 倒计时秒数
     * @param callback 回调函数
     * @returns 清除倒计时
     */
    countDown(seconds: number, callback: Callback): () => void {
        let ticker: number | null = 0
        let remainingSeconds = seconds
        let startTime = Date.now()
        let expectedTime = startTime + 1000

        const tick = () => {
            const currentTime = Date.now()
            const drift = currentTime - expectedTime
            if (remainingSeconds > 0) {
                callback(this.formatTime(remainingSeconds))
                remainingSeconds--
                expectedTime += 1000
                ticker = setTimeout(tick, Math.max(0, 1000 - drift))
            } else {
                callback(this.formatTime(0))
            }
        }
        tick()
        return () => {
            clearTimeout(ticker)
            ticker = null
        }
    }

    /**
     * 格式化价格
     * @param price 价格
     * @param syncDotLen 是否同步小数点长度
     */
    formatPrice(price: number | string, syncDotLen: boolean = true): string {
        const dotLen = price.toString().split('.')[1]?.length || 0
        let res = price.toString().replace(/\d+/, n => {
            return n.replace(/(\d)(?=(\d{3})+$)/g, ($1) => {
                return $1 + ','
            })
        })
        if (dotLen && syncDotLen) {
            res = res.replace(/\d+\.\d+/, (n) => {
                return n.replace(/(\d)(?=(\d{3})+\.)/g, ($1) => {
                    return $1 + ','
                })
            })
        }
        return res
    }
}

export const honsUtils = new HonsUtils()