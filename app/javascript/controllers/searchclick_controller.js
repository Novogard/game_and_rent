
import { Controller } from "@hotwired/stimulus"

// Connecte ce contrôleur aux éléments de résultats
export default class extends Controller {
  static values = {
    title: String,
    id: Number
  }

  connect() {
    // Optionnel : console log pour tester
    console.log("Contrôleur SearchClick connecté")
  }

  select(event) {
    event.preventDefault()
    const selectedTitle = this.titleValue
    const gameId = this.idValue
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



  }
}
