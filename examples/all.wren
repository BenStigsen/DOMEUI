import "dome" for Window
import "graphics" for Canvas, Font
import "../ui" for Label, Button, TextBox, Slider, CheckBox, RadioButton, RadioGroup, Frame

var WIDTH = 400
var HEIGHT = 400


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
    _button  = Button.new("Button", [10, 40, 87, 25])
    _label   = Label.new("Label",   [10, 10])
    _textbox = TextBox.new(         [10, 70, 300, 200])
    _slider  = Slider.new(          [10, 280, 300, 20])
    _check   = CheckBox.new(        [100, 40, 25, 25])
    _group   = RadioGroup.new()
    
    _group.children = [
      RadioButton.new([340, 82, 25, 25]),
      RadioButton.new([340, 115, 25, 25])
    ]

    _frame = Frame.new()
    _frame.add(_group)
  }

  update() {
    _button.update()
    _label.update()
    _textbox.update()
    _slider.update()
    _check.update()
    _frame.update()
  }

  draw(dt) {
    Canvas.cls()
    _button.draw()
    _label.draw()
    _textbox.draw()
    _slider.draw()
    _check.draw()
    _group.draw()
    _frame.draw()
  }
}

var Game = Main.new()

