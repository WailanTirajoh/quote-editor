import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    // Register an observer for Turbo Drive events
    document.addEventListener(
      "turbo:before-fetch-request",
      this.handleBeforeFetchRequest.bind(this)
    );
  }

  disconnect() {
    document.removeEventListener(
      "turbo:before-fetch-request",
      this.handleBeforeFetchRequest.bind(this)
    );
  }

  handleBeforeFetchRequest(event) {
    // Retrieve the value from local storage
    const tokenValue = localStorage.getItem("test123");

    // Add the value to the XHR request headers
    event.detail.fetchOptions.headers["Authorization"] = tokenValue;
  }
}
