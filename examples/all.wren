import "dome" for Window
import "graphics" for Canvas, Font, Color
import "ui" for Label, Button, TextBox, Slider, CheckBox, RadioButton, RadioGroup, Frame

var WIDTH = 750
var HEIGHT = 500

class Main {
  construct new() {}

  init() {
    // Window
    Window.resize(WIDTH, HEIGHT)
    Canvas.resize(WIDTH, HEIGHT)

    // Settings
    Font.load("monogram", "./monogram.ttf", 36)
    Canvas.font = "monogram"
    
    // Widgets
    _label   = Label.new("Label",  [10, 10])
    _button  = Button.new("Press", [10, 40, 75, 25])
    _textbox = TextBox.new("Text", [10, 70, 300, 200])
    _slider = Slider.new([75, 0, 100], [10, 275, 300, 20])
    _check = CheckBox.new([335, 10])
    _group = RadioGroup.new()
    
    _frame = Frame.new()
    
    _group.add(RadioButton.new([350, 70]))
    _group.add(RadioButton.new([350, 110]))
    
    _frame.add(_group)
  }

  update() {
    _label.update()
    _button.update()
    _textbox.update()
    _slider.update()
    _check.update()
    //_group.update()
    _frame.update()
  }

  draw(dt) {
    Canvas.cls()
    _label.draw()
    _button.draw()
    _textbox.draw()
    _slider.draw()
    _check.draw()
    //_group.draw()
    _frame.draw()
  }
}

var Game = Main.new()

