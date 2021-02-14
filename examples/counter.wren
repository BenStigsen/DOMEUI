import "dome" for Window
import "graphics" for Canvas, Font
import "../ui" for Label, Button

var WIDTH = 180
var HEIGHT = 60

class Main {
  construct new() {}

  init() {
    // Window
    Window.resize(WIDTH, HEIGHT)
    Canvas.resize(WIDTH, HEIGHT)

    // Settings
    Font.load("monogram", "../monogram.ttf", 36)
    Canvas.font = "monogram"

    var count = 0

    // Widgets
    var label  = _label  = Label.new(count, 20, 20)
    var button = _button = Button.new("Count", 60, 15)

    button.onMouseClick {
      count = count + 1
      label.value = count
    }
  }

  update() {
    _button.update()
  }

  draw(dt) {
    Canvas.cls()   // Clear the canvas
    _label.draw()  // Draw the label
    _button.draw() // Draw the button
  }
}

var Game = Main.new()

