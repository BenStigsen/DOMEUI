import "graphics" for Canvas, Color
import "input" for Mouse, Keyboard

class Rectangle {
  construct new(x, y, w, h) {
    init_(x, y, w, h)
  }

  init_(x, y, w, h) {
    _x = x.round
    _y = y.round
    _w = w.round
    _h = h.round
  }

  pointInRectangle(x, y) {
    if (x > _x && x < (_x + _w)) {
      if (y > _y && y < (_y + _h)) {
        return true
      }
    }

    return false
  }

  toString {
    return "(%(x), %(y), %(w), %(h))"
  }

  x {_x}
  y {_y}
  w {_w}
  h {_h}

  x=(v) {_x = v}
  y=(v) {_y = v}
  w=(v) {_w = v}
  h=(v) {_h = v}
}

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

    _hitbox = Rectangle.new(_x, _y, _w, _h)

    _step = 0

    // Booleans
    _isFocused   = false
    _isEnabled   = true
    _isVisible   = true
    _isAnimating = false

    // Bindings
    _onFocusEnter    = null
    _onFocusExit     = null
    _onMouseClick    = null
    _onKeyPress      = null
    _onVisible       = null
    _onInvisible     = null
    _onEnable        = null
    _onDisable       = null
    _onUpdate        = null
    _onDraw          = null
    _onAnimation     = null
    _onAnimationDone = null
  }

  update() {
    // Bind: onUpdate
    if (_isEnabled) {
      if (_onUpdate) {_onUpdate.call()}

      if (_isVisible) {
        // Mouse Click
        if (Mouse["left"].justPressed) {
          var pos = Mouse.position

          if (_hitbox.pointInRectangle(pos.x, pos.y)) {
              isFocused = true

              // Bind: onMouseClick
              if (_onMouseClick) {onMouseClick.call()}
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
  }

  draw() {
    if (_isAnimating) {
      if (_onAnimation && (_step > 0)) {
        _onAnimation.call()
        _step = _step - 1
      } else {
        _isAnimating = false
        if (_onAnimationDone) {_onAnimationDone.call()}
      }
    }

    if (_onDraw) {_onDraw.call()}
  }

  // Properties
  x      {_x}
  y      {_y}
  w      {_w}
  h      {_h}
  hitbox {_hitbox}
  step   {_step}

  // Bindings
  onMouseClick(fn)    {_onMouseClick    = fn}
  onKeyPress(fn)      {_onKeyPress      = fn}
  onFocusEnter(fn)    {_onFocusEnter    = fn}
  onFocusExit(fn)     {_onFocusExit     = fn}
  onEnable(fn)        {_onEnable        = fn}
  onDisable(fn)       {_onDisable       = fn}
  onVisible(fn)       {_onVisible       = fn}
  onInvisible(fn)     {_onInvisible     = fn}
  onUpdate(fn)        {_onUpdate        = fn}
  onDraw(fn)          {_onDraw          = fn}
  onAnimation(fn)     {_onAnimation     = fn}
  onAnimationDone(fn) {_onAnimationDone = fn}

  // Variables
  onMouseClick    {_onMouseClick}
  onKeyPress      {_onKeyPress}
  onFocusEnter    {_onFocusEnter}
  onFocusExit     {_onFocusExit}
  onEnable        {_onEnable}
  onDisable       {_onDisable}
  onVisible       {_onVisible}
  onInvisible     {_onInvisible}
  onUpdate        {_onUpdate}
  onDraw          {_onDraw}
  onAnimation     {_onAnimation}
  onAnimationDone {_onAnimationDone}

  // Booleans
  isFocused   {_isFocused}
  isEnabled   {_isEnabled}
  isVisible   {_isVisible}
  isAnimating {_isAnimating}

  hitbox=(v) {_hitbox = v}
  step=(v)   {_step   = v}

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

  isAnimating=(v) {_isAnimating = v}
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
  color=(v) {_color = v}
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
  color=(v) {_color = v}
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
    _value = value
    _color = color
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
  color=(v) {_color = v}
}

class Slider is Element {
  construct new(x, y, w, h) {
    super(x, y, w, h)
    init_(10, 20)
  }

  construct new(x, y, w, h, hw, hh) {
    super(x, y, w, h)
    init_(hw, hh)
  }

  init_(hw, hh) {
    hitbox = Rectangle.new(x + ((x + w) / 2), (y + h) / 2, hw, hh)

    _w = w - hitbox.w

    _value = (100 / 2)
    _color = Color.rgb(255, 50, 50)
    _isDragging = false
    _scale = 100 / ((x + _w) - x)
  }

  update() {
    super.update()

    if (isFocused && !_isDragging) {
      if (Mouse.isButtonPressed("left")) {
        _isDragging = true
      }
    }

    if (_isDragging) {
      if (Mouse.isButtonPressed("left")) {
        var pos = Mouse.position

        hitbox.x = (pos.x).clamp(x, x + _w)
        _value = (_scale * (pos.x - x)).clamp(0, 100).round
      }
    }
  }

  draw() {
    super.draw()

    Canvas.rect(x, y, w, h, _color)
    Canvas.rectfill(hitbox.x, hitbox.y, hitbox.w, hitbox.h, Color.rgb(255, 255, 255))
  }

  value     {_value}
  value=(v) {_value = v}
}

// TO-DO: Add multiline support
//class TextBoxMulti {}

