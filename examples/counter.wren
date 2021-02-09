import "dome" for Window
import "graphics" for Canvas, Font
import "../ui" for Label, Button

var WIDTH = 180
var HEIGHT = 60

class Game {
  static init() {
    Window.title = ""
    Window.resize(WIDTH, HEIGHT)
    Canvas.resize(WIDTH, HEIGHT)
    Font.load("monogram", "../monogram.ttf", 36)
    Canvas.font = "monogram"

    var i = 0

    __label = Label.new(i, 20, 20)
    __button = Button.new("Count", 60, 15)
    __button.onMouseClick {
      __label.value = i
      i = i + 1
    }
  }

  static update() {
    __button.update()
  }

  static draw(dt) {
    Canvas.cls()
    __label.draw()
    __button.draw()
  }
}

