import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["message", "progress"]
  static values = { 
    duration: { type: Number, default: 5000 },
    remaining: { type: Number, default: 5000 }
  }

  connect() {
    this.startTimer()
    this.setupAnimation()
  }

  startTimer() {
    this.remainingValue = this.durationValue
    this.timer = setInterval(() => {
      this.remainingValue -= 100
      if (this.remainingValue <= 0) this.dismiss()
    }, 100)
  }

  setupAnimation() {
    this.progressTarget.style.transition = `width ${this.durationValue}ms linear`
    setTimeout(() => {
      this.progressTarget.style.width = '0%'
    }, 50)
  }

  dismiss() {
    clearInterval(this.timer)
    this.element.classList.add('opacity-0', 'transition-opacity', 'duration-300')
    setTimeout(() => {
      this.element.remove()
    }, 300)
  }

  pauseTimer() {
    clearInterval(this.timer)
  }

  resumeTimer() {
    this.startTimer()
  }
}