// import "math" for Vector
import "graphics" for Canvas, Color
import "input" for Mouse, Keyboard

// TO-DO: Add padding
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

    // Booleans
    _isFocused = false
    _isEnabled = true

    // Bindings
    _onFocusEnter = null
    _onFocusExit  = null
    _onMouseClick = null
    _onKeyPress   = null
    _onUpdate     = null
    _onDraw       = null
  }

  update() {
    if (_onUpdate != null) {_onUpdate.call()}

    // Focus
    if (_isEnabled) {
      if (Mouse["left"].justPressed) {
        var pos = Mouse.position

        if (pos.x > _x && pos.x < (_x + _w)) {
          if (pos.y > _y && pos.y < (_y + _h)) {
            _isFocused = true

            if (_onFocusEnter != null) {_onFocusEnter.call()}
            if (_onMouseClick != null) {_onMouseClick.call()}

          } else {
            _isFocused = false
          }
        } else {
          _isFocused = false
        }
      }

      if (_isFocused && (Keyboard.allPressed.count > 0)) {
        if (_onKeyPress != null) {_onKeyPress.call()}
      }
    }
  }

  draw() {
    if (_onDraw != null) {_onDraw.call()}
  }

  // Bindings
  onMouseClick(fn) {_onMouseClick = fn}
  onKeyPress(fn)   {_onKeyPress   = fn}
  onFocusEnter(fn) {_onFocusEnter = fn}
  onFocusExit(fn)  {_onFocusExit  = fn}
  onUpdate(fn)     {_onUpdate     = fn}
  onDraw(fn)       {_onDraw       = fn}

  // Variables
  onMouseClick {_onMouseClick}
  onKeyPress   {_onKeyPress}
  onFocusEnter {_onFocusEnter}
  onFocusExit  {_onFocusExit}
  onUpdate     {_onUpdate}
  onDraw       {_onDraw}

  x {_x}
  y {_y}
  w {_w}
  h {_h}
  isFocused {_isFocused}
  isEnabled {_isEnabled}

  isFocused=(v) {_isFocused = v}
  isEnabled=(v) {_isEnabled = v}
}

class Label is Element {
  construct new(value, x, y) {
    super(x, y, 0, 0)
    init_(value, Color.rgb(255, 255, 255))
  }

  construct new(value, x, y, w, h) {
    super(x, y, w, h)
    init_(value, Color.rgb(255, 255, 255))
  }

  init_(value, color) {
    _value = value
    _color = color
  }

  //update() {super.update()}

  draw() {
    //super.update()

    if (w > 0 && h > 0) {
      Canvas.clip(x, y, w, h)
      Canvas.print(_value, x, y)
      Canvas.clip()
    } else {
      Canvas.print(_value, x, y, _color)
    }
  }

  value {_value}
  color {_color}

  value=(v) {_value = v}
}

// Button
class Button is Element {
  construct new(value, x, y) {
    super(x, y, 86, 25)
    init_(value, Color.rgb(255, 255, 255))
  }

  construct new(value, x, y, w, h) {
    super(x, y, w, h)
    init_(value, Color.rgb(255, 255, 255))
  }

  init_(value, color) {
    _value = value
    _color = color
  }

  update() {
    super.update()

    // Button press
    if (isFocused) {isFocused = false}
  }

  draw() {
    super.draw()

    Canvas.clip(x, y, w, h)
    Canvas.rect(x, y, w, h, _color)
    Canvas.print(_value, x + 5, y + 5, _color)
    Canvas.clip()
  }

  value {_value}
  color {_color}

  value=(v) {_value = v}
}

// TextBox
class TextBox is Element {
  construct new(value, x, y) {
    super(x, y)
    init_(value, Color.rgb(255, 255, 255))
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
  }

  update() {
    super.update()

    if (isFocused) {
      var uppercase = false
      var keys = Keyboard.allPressed

      for (entry in keys) {
        // TO-DO: Add support for space and other symbols
        if (entry.value.justPressed) {
          // TO-DO: Add uppercase/lowercase support
          uppercase = Keyboard.isKeyDown("CapsLock")

          if (Keyboard.isKeyDown("Left Shift")) {
            uppercase = !uppercase
          }

          _value = _value + entry.key
        }
      }
    }
  }

  draw() {
    super.draw()

    Canvas.clip(x, y, w, h)
    Canvas.rect(x, y, w, h, _color)
    Canvas.print(_value, x + 5, y + 5, _color)
    Canvas.clip()
  }

  value {_value}
  color {_color}

  value=(v) {_value = v}
}

// TO-DO: Add multiline support
//class TextBoxMulti {}

