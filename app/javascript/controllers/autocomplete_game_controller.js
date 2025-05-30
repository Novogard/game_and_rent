import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="autocomplete-game"
export default class extends Controller {
 static values = {
    url: String
  }
static targets = ["input", "results"]


  connect() {
    console.log("connect");
  }

  search(event) {

    const query = this.inputTarget.value
    console.log(this.inputTarget.value)
    this.resultsTarget.innerHTML = ''

fetch(`${this.urlValue}?query=${encodeURIComponent(query)}`)
    .then(response => response.text())
    .then((html) => {
  console.log(html)
  this.resultsTarget.innerHTML = html
})

  // fetch(`${this.urlValue}?query=${encodeURIComponent(query)}`)
  //     .then(response => response.json())
  //     .then((data) => {
  //     console.log(data)

  //     this.resultsTarget.innerHTML = data
  //   })
  }





}
