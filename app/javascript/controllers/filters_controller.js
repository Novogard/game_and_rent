import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filters"
export default class extends Controller {
  connect() {
    console.log("coucou")
  }

  filter(event) {
    const genreCheckBoxes = document.querySelectorAll('.genre-checkbox');
    const selectedGenres = [];
    const platformCheckBoxes = document.querySelectorAll('.platform-checkbox')
    const selectedPlatforms = [];

    genreCheckBoxes.forEach(checkbox => {
      if(checkbox.checked) {
        selectedGenres.push(checkbox.value)
      }
    })

    platformCheckBoxes.forEach(checkbox => {
      if(checkbox.checked) {
        selectedPlatforms.push(checkbox.value)
      }
    })

    const genreQuery = []
    selectedGenres.forEach(genre => {
      genreQuery.push('genre[]=' + `${genre}`)
    })
    const genreQueryString = genreQuery.join('&')

    const platformQuery = []
    selectedPlatforms.forEach(platform => {
      platformQuery.push('platform[]=' + `${platform}`)
    })
    const platformQueryString = platformQuery.join('&')

    const query = genreQueryString + '&' + platformQueryString

    const url = `/games/filter?${query}`
    fetch(url)
      .then(response => response.text())
      .then(html => {
        document.querySelector("#results").innerHTML = html;
    });
  }
}
