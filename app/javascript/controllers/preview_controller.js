import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "container", "image"]

  showImage(event) {
    const input = event.target
    const container = this.containerTarget
    const image = this.imageTarget

    if (input.files && input.files[0]) {
      const reader = new FileReader()

      reader.onload = function (e) {
        image.src = e.target.result
        container.style.display = "block"
      }

      reader.readAsDataURL(input.files[0])
    } else {
      container.style.display = "none"
      image.src = ""
    }
  }
} 