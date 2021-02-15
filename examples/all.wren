import "dome" for Window
import "graphics" for Canvas, Font, Color
import "../ui" for Frame, Label, Button, Slider, CheckBox, RadioButton, RadioGroup

var WIDTH = 500
var HEIGHT = 300

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
    var frame      = _frame = Frame.new()

    var label      = Label.new("This is a label!", 10, 10)
    var labelSlide = _labelSlide = Label.new("5", 245, 250)
    var labelCheck = _labelCheck = Label.new("false", 50, 95)
    var labelRadio = _labelRadio = Label.new("Selected: 0", 330, 45)

    var button     = Button.new("Button", 10, 45)
    var slider     = _slider = Slider.new(5, 0, 10, 100, 200, 300, 20, 20, 60)
    var check      = _check  = CheckBox.new(10, 85)
    var group      = _group  = RadioGroup.new()

    group.add(RadioButton.new(true, 300, 30))
    group.add(RadioButton.new(300, 70))

    // Bindings
    button.onMouseClick {
      button.step = 255
      button.isAnimating = true
    }

    // Animations
    button.onAnimation {
      button.color = Color.rgb(button.step, 255 - button.step, button.step / 2)
    }

    button.onAnimationDone {
      button.color = Color.white
    }

    // Add to frame
    frame.add(label)
    frame.add(labelSlide)
    frame.add(labelCheck)
    frame.add(labelRadio)
    frame.add(button)
    frame.add(check)
    frame.add(slider)
    frame.add(group)
  }

  update() {
    _labelCheck.value = _check.value
    _labelRadio.value = _group.selected
    _labelSlide.value = _slider.value
    _frame.update()
  }

  draw(dt) {
    Canvas.cls()
    _frame.draw()
  }
}

var Game = Main.new()

