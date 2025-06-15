import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "mobileMenu", "openIcon", "closeIcon"]

  // Toggle desktop dropdown menu
  toggle(event) {
    event.preventDefault()
    event.stopPropagation()
    this.menuTarget.classList.toggle("hidden")
    
    // Update aria-expanded attribute
    const button = event.currentTarget
    const expanded = button.getAttribute("aria-expanded") === "true"
    button.setAttribute("aria-expanded", !expanded)
  }

  // Toggle mobile menu
  toggleMobile(event) {
    event.preventDefault()
    event.stopPropagation()
    this.mobileMenuTarget.classList.toggle("hidden")
    this.openIconTarget.classList.toggle("hidden")
    this.closeIconTarget.classList.toggle("hidden")
    
    // Update aria-expanded attribute
    const button = event.currentTarget
    const expanded = button.getAttribute("aria-expanded") === "true"
    button.setAttribute("aria-expanded", !expanded)
  }

  // Hide both menus when clicking outside
  hide(event) {
    if (!this.element.contains(event.target)) {
      this.menuTarget.classList.add("hidden")
      this.mobileMenuTarget.classList.add("hidden")
      this.openIconTarget.classList.remove("hidden")
      this.closeIconTarget.classList.add("hidden")
      
      // Reset aria-expanded attributes
      document.querySelectorAll('[aria-expanded="true"]').forEach(el => {
        el.setAttribute("aria-expanded", "false")
      })
    }
  }
}