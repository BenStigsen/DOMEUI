import "math" for Vector
import "graphics" for Canvas, Color
import "input" for Mouse, Keyboard

// Add padding
class Element {
  construct new(x, y) {
    init_(x, y, 0, 0)
  }

  construct new(x, y, w, h) {
    init_(x, y, w, h)
  }

  init_(x, y, w, h) {
    _x = x
    _y = y
    _w = w
    _h = h
    _hasFocus = false
  }

  update() {
    if (Mouse["left"].justPressed) {
      var pos = Mouse.position

      if (pos.x > _x && pos.x < (_x + _w)) {
        if (pos.y > _y && pos.y < (_y + _h)) {
          _hasFocus = true
        } else {
          _hasFocus = false
        }
      } else {
        _hasFocus = false
      }
    }
  }

  x {_x}
  y {_y}
  w {_w}
  h {_h}
  hasFocus     {_hasFocus}
  hasFocus=(v) {_hasFocus = v}
}

class Button is Element {
  construct new(x, y) {
    super(x, y, 86, 25)
    init_("Button", Color.rgb(255, 255, 255))
  }

  construct new(value, x, y) {
    super(x, y, 86, 25)
    init_(value, Color.rgb(255, 255, 255))
  }

  construct new(x, y, w, h) {
    super(x, y, w, h)
    init_("Button", Color.rgb(255, 255, 255))
  }

  construct new(value, x, y, w, h) {
    super(x, y, w, h)
    init_(value, Color.rgb(255, 255, 255))
  }

  init_(value, color) {
    _value = value
    _color = color
    _onClick = null
  }

  update() {
    super.update()

    if (hasFocus) {
      hasFocus = false

      if (_onClick != null) {
        _onClick.call()
      }
    }
  }

  draw() {
    Canvas.rect(x, y, w, h, _color)
    Canvas.print(_value, x + 5, y + 5, _color)
  }

  bind(fn) {
    _onClick = fn
  }

  value   {_value}
  color   {_color}

  value=(v) {_value = v}
}

class TextBox is Element {
  construct new(value, x, y) {
    super(x, y)
    init_(value, Color.rgb(255, 255, 255))
  }

  construct new(x, y, w, h) {
    super(x, y, w, h)
    init_("", Color.rgb(255, 255, 255))
  }

  construct new(value, x, y, w, h) {
    super(x, y, w, h)
    init_(value, Color.rgb(255, 255, 255))
  }

  construct new(value, x, y, w, h, color) {
    super(x, y, w, h)
    init_(value, color)
  }

  init_(value, color) {
    _value   = value
    _color   = color
    _onInput = null
  }

  update() {
    super.update()

    if (hasFocus) {
      var uppercase = false

      var keys = Keyboard.allPressed

      if (keys.count > 0) {
        if (_onInput != null) {
          _onInput.call()
        }
      }

      for (entry in keys) {
        // TO-DO: Add support for space and other symbols
        if (entry.value.justPressed) {
          // TO-DO: Add uppercase/lowercase support
          if (Keyboard.isKeyDown("CapsLock")) {
            uppercase = true
          }

          if (Keyboard.isKeyDown("Left Shift")) {
            uppercase = !uppercase
          }

          _value = _value + entry.key
        }
      }
    }
  }

  draw() {
    Canvas.rect(x, y, w, h, _color)
    Canvas.print(_value, x + 5, y + 5, _color)
  }

  onInput(fn) {
    _onInput = fn
  }

  value {_value}
  color {_color}

  value=(v) {_value = v}
}

// TO-DO: Add multiline support
class TextBoxMulti {
  construct new() {
    init_("", 0, 0, 200, 200, Color.rgb(255, 255, 255))
  }

  construct new(value, x, y, w, h, color) {
    init_(value, x, y, w, h, color)
  }

  init_(value, x, y, w, h, color) {
    _value = value
    _x = x
    _y = y
    _w = w
    _h = h
    _color = color
  }

  update() {
    var uppercase = false

    for (entry in Keyboard.allPressed) {

      // TO-DO: Add support for space and other symbols
      if (entry.value.justPressed) {
        // TO-DO: Add uppercase/lowercase support
        if (Keyboard.isKeyDown("CapsLock")) {
          uppercase = true
        }

        if (Keyboard.isKeyDown("Left Shift")) {
          uppercase = !uppercase
        }

        _value = _value + entry.key
      }
    }
  }

  draw() {
    Canvas.rect(_x, _y, _w, _h, _color)
    Canvas.print(_value, _x + 5, _y + 5, _color)
  }

  value {_value}
  x     {_x}
  y     {_y}
  w     {_w}
  h     {_h}
  color {_color}

  value=(v) {_value = v}
}

