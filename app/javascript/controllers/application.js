import { Application } from "@hotwired/stimulus"

const application = Application.start()

application.debug = false
window.Stimulus   = application

export { application }

import ScrollController from "./scroll_controller"
import ResetController from "./reset_controller"

application.register("reset", ResetController)
application.register("scroll", ScrollController)
