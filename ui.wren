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
    _isVisible = true

    // Bindings
    _onFocusEnter = null
    _onFocusExit  = null
    _onMouseClick = null
    _onKeyPress   = null
    _onVisible    = null
    _onInvisible  = null
    _onEnable     = null
    _onDisable    = null
    _onUpdate     = null
    _onDraw       = null
  }

  update() {
    // Bind: onUpdate
    if (_onUpdate) {_onUpdate.call()}

    if (_isEnabled && _isVisible) {
      // Mouse Click
      if (Mouse["left"].justPressed) {
        var pos = Mouse.position

        if (pos.x > _x && pos.x < (_x + _w)) {
          if (pos.y > _y && pos.y < (_y + _h)) {
            isFocused = true

            // Bind: onMouseClick
            if (_onMouseClick) {onMouseClick.call()}

          } else {
            isFocused = false
          }
        } else {
          isFocused = false
        }
      }

      // Keyboard Input
      if (_isFocused && (Keyboard.allPressed.count > 0)) {
        if (_onKeyPress) {_onKeyPress.call()}
      }
    }
  }

  draw() {
    if (_onDraw) {_onDraw.call()}
  }

  // Properties
  x {_x}
  y {_y}
  w {_w}
  h {_h}

  // Bindings
  onMouseClick(fn) {_onMouseClick = fn}
  onKeyPress(fn)   {_onKeyPress   = fn}
  onFocusEnter(fn) {_onFocusEnter = fn}
  onFocusExit(fn)  {_onFocusExit  = fn}
  onEnable(fn)     {_onEnable     = fn}
  onDisable(fn)    {_onDisable     = fn}
  onVisible(fn)    {_onVisible    = fn}
  onInvisible(fn)  {_onInvisible  = fn}
  onUpdate(fn)     {_onUpdate     = fn}
  onDraw(fn)       {_onDraw       = fn}

  // Variables
  onMouseClick {_onMouseClick}
  onKeyPress   {_onKeyPress}
  onFocusEnter {_onFocusEnter}
  onFocusExit  {_onFocusExit}
  onEnable     {_onEnable}
  onDisable    {_onDisable}
  onVisible    {_onVisible}
  onInvisible  {_onInvisible}
  onUpdate     {_onUpdate}
  onDraw       {_onDraw}

  // Booleans
  isFocused {_isFocused}
  isEnabled {_isEnabled}
  isVisible {_isVisible}

  isFocused=(v) {
    _isFocused = v
    if (v) {
      if (_onFocusEnter) {_onFocusEnter.call()}
    } else {
      if (_onFocusExit)  {_onFocusExit.call()}
    }
  }

  isEnabled=(v) {
    _isEnabled = v
    if (v) {
      if (_onEnable)  {_onEnable.call()}
    } else {
      if (_onDisable) {_onDisable.call()}
    }
  }

  isVisible=(v) {
    _isVisible = v
    if (v) {
      if (_onVisible)   {_onVisible.call()}
    } else {
      if (_onInvisible) {_onInvisible.call()}
    }
  }
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
    if (isVisible) {
      //super.update()

      // Clip
      if (w > 0 && h > 0) {
        Canvas.clip(x, y, w, h)
        Canvas.print(_value, x, y, _color)
        Canvas.clip()
      } else {
        Canvas.print(_value, x, y, _color)
      }
    }
  }

  // Variables
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
    if (isVisible) {
      super.draw()

      Canvas.clip(x, y, w, h)
      Canvas.rect(x, y, w, h, _color)
      Canvas.print(_value, x + 5, y + 5, _color)
      Canvas.clip()
    }
  }

  // Variables
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
    if (isVisible) {
      super.draw()

      Canvas.clip(x, y, w, h)
      Canvas.rect(x, y, w, h, _color)
      Canvas.print(_value, x + 5, y + 5, _color)
      Canvas.clip()
    }
  }

  // Variables
  value {_value}
  color {_color}

  value=(v) {_value = v}
}

// TO-DO: Add multiline support
//class TextBoxMulti {}

