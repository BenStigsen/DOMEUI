import "dome" for Window
import "graphics" for Canvas, Font, Color
import "../ui" for Label, CheckBox

var WIDTH = 280
var HEIGHT = 100

class Main {
  construct new() {}

  init() {
    // Window
    Window.resize(WIDTH, HEIGHT)
    Canvas.resize(WIDTH, HEIGHT)

    // Settings
    Font.load("monogram", "../monogram.ttf", 36)
    Canvas.font = "monogram"

    // Widgets
    var radio = _radio = CheckBox.new(30, 30)
    var label = _label = Label.new("Checked: %(radio.value)", 70, 38)

    radio.onMouseClick {
      radio.value = !radio.value
      label.value = "Checked: %(radio.value)"
    }
  }

  update() {
    _radio.update()
  }

  draw(dt) {
    Canvas.cls()
    _label.draw()
    _radio.draw()
  }
}

var Game = Main.new()

