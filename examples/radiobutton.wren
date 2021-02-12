import "dome" for Window
import "graphics" for Canvas, Font, Color
import "../ui" for Label, RadioButton, RadioGroup

var WIDTH = 220
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
    var label = _label = Label.new("", 70, 45)
    var group = _group = RadioGroup.new()
    group.add(RadioButton.new(true, 30, 30))
    group.add(RadioButton.new(30, 70))
  }

  update() {
    _group.update()
    _label.value = "Selected %(_group.selected)"
  }

  draw(dt) {
    Canvas.cls()
    _group.draw()
    _label.draw()
  }
}

var Game = Main.new()

