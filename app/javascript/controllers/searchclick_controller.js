
import { Controller } from "@hotwired/stimulus"

// Connecte ce contrôleur aux éléments de résultats
export default class extends Controller {
  static values = {
    title: String,
    id: Number,
    artworkUrl: String
  }

  connect() {
    // Optionnel : console log pour tester
    console.log("Contrôleur SearchClick connecté")
  }

  select(event) {
    event.preventDefault()
    const selectedTitle = this.titleValue
    const gameId = this.idValue
    const imageUrl = this.artworkUrlValue
    console.log (gameId)

    //  remplir un champ texte avec le titre du jeu
    const input = document.querySelector("#selected-game")
    if (input) {
      input.value = selectedTitle
    }

    const gameInput = document.querySelector("#selected-game-id")
    if (gameInput) {
    gameInput.value = gameId
    }


        // Afficher l'image dans la colonne droite
    const preview = document.querySelector("#selected-game-preview")
    console.log("artworkUrlValue:", this.artworkUrlValue)

    if (preview && this.artworkUrlValue) {
      preview.innerHTML = `
        <img src="${this.artworkUrlValue}" alt="Image du jeu" class="w-full h-full object-contain rounded-lg border border-gray-500 shadow-lg animate-[spin_2s_ease-in-out] transform scale-90 transition-transform duration-500 ease-in-out">`
    }


  }
}
