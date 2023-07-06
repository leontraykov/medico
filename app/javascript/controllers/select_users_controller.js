export default class extends Controller {
  static targets = [ "select", "chosen" ]

  connect() {
    this.updateChosen()
  }

  updateChosen() {
    const chosen = Array.from(this.selectTarget.selectedOptions)
      .map(option => `<span class="badge bg-secondary me-1">${option.text}<button data-action="dblclick->select-users#removeUser" data-user-id="${option.value}" class="btn-close btn-close-white ms-2" aria-label="Close"></button></span>`)
      .join(", ")
    this.chosenTarget.innerHTML = chosen
  }

  removeUser(event) {
    const userId = event.currentTarget.getAttribute('data-user-id')
    const option = Array.from(this.selectTarget.options).find(option => option.value === userId)
    if (option) {
      option.selected = false
      this.updateChosen()
    }
  }
}
