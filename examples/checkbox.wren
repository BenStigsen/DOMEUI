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
    var check = _check = CheckBox.new(30, 30)
    var label = _label = Label.new("Checked: %(check.value)", 70, 38)
  }

  update() {
    _check.update()
    _label.value = "Checked: %(_check.value)"
  }

  draw(dt) {
    Canvas.cls()
    _label.draw()
    _check.draw()
  }
}

var Game = Main.new()

