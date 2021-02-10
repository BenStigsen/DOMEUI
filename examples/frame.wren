import "dome" for Window
import "graphics" for Canvas, Font
import "../ui" for Frame, Button, Slider

var WIDTH = 350
var HEIGHT = 100

class Main {
  construct new() {
    init()
  }

  init() {
    // Window
    Window.resize(WIDTH, HEIGHT)
    Canvas.resize(WIDTH, HEIGHT)

    // Settings
    Font.load("monogram", "../monogram.ttf", 36)
    Canvas.font = "monogram"

    // Widgets
    var frame = _frame = Frame.new()
    var slider = Slider.new(50, 0, 100, 20, 20, 300, 10)
    var button = Button.new("Hide", 140, 50, 60, 25)

    // Hide frame on button click
    button.onMouseClick {
      frame.isVisible = false
    }

    // Add slider and button to frame
    frame.add(slider)
    frame.add(button)
  }

  update() {
    _frame.update() // Update the frame (and its children)
  }

  draw(dt) {
    Canvas.cls()    // Clear the canvas
    _frame.draw()   // Draw the frame (and its children)
  }
}

var Game = Main.new()

