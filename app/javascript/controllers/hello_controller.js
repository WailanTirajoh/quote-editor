import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["test"];

  connect() {
    console.log("masuk");
  }

  handleClick() {
    this.testTarget.textContent = "Hello, Stimulus!";
  }
}
