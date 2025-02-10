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

    countdown(seconds: number, callback: Callback) {
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
}

export const honsUtils = new HonsUtils()