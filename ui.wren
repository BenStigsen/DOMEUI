import "graphics" for Canvas, Color
import "input" for Mouse, Keyboard

/* TO-DO:
 - Add max amount of characters to TextBox
 - Add combobox
*/

class Rectangle {
  construct new(x, y, w, h) {
    init_(x, y, w, h)
  }

  init_(x, y, w, h) {
    _x = x
    _y = y
    _w = w
    _h = h
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

class Element {
  construct new(x, y) {
    init_(null, x, y, 0, 0)
  }

  construct new(value, x, y) {
    init_(value, x, y, 0, 0)
  }

  construct new(x, y, w, h) {
    init_(null, x, y, w, h)
  }

  construct new(value, x, y, w, h) {
    init_(value, x, y, w, h)
  }

  init_(value, x, y, w, h) {
    // Values
    _x = x
    _y = y
    _w = w
    _h = h

    _value = value

    _hitbox = Rectangle.new(_x, _y, _w, _h)

    _paddingX = 5.min(w)
    _paddingY = 5.min(h)

    _parent = null
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
    if (_onUpdate) {_onUpdate.call()}

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
  x        {_x}
  y        {_y}
  w        {_w}
  h        {_h}
  value    {_value}
  hitbox   {_hitbox}
  padding  {_paddingX}
  paddingX {_paddingX}
  paddingY {_paddingY}
  parent   {_parent}
  step     {_step}

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

  value=(v)    {_value    = v}
  hitbox=(v)   {_hitbox   = v}
  parent=(v)   {_parent   = v}
  step=(v)     {_step     = v}
  paddingX=(v) {_paddingX = v.min(w)}
  paddingY=(v) {_paddingY = v.min(h)}

  padding=(v) {
    _paddingX = v
    _paddingY = v
  }

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

class Frame is Element {
  construct new() {
    super(0, 0, Canvas.width, Canvas.height)
    init_()
  }

  construct new(x, y, w, h) {
    super(x, y, w, h)
    init_()
  }

  init_() {
    _children = []
  }

  update() {
    if (isEnabled) {
      super.update()

      for (child in children) {
        child.update()
      }
    }
  }

  draw() {
    if (isVisible) {
      super.draw()

      Canvas.clip(x, y, w, h)
      for (child in children) {
        child.draw()
      }
      Canvas.clip()
    }
  }

  add(v) {
    v.parent = this
    _children.add(v)
  }

  [i] {
    if (i < _children.count) {
      return _children[i]
    }
    return null
  }

  [i]=(v) {
    if (i < _children.count) {
      _children[i] = v
    }
  }

  children     {_children}
  children=(v) {_children}
}

class Label is Element {
  construct new(value, x, y) {
    super(value, x, y, 0, 0)
    init_(Color.white)
  }

  construct new(value, x, y, w, h) {
    super(value, x, y, w, h)
    init_(Color.white)
  }

  init_(color) {
    _color = color
  }

  update() {super.update()}

  draw() {
    if (isVisible) {
      //super.draw()

      // Clip
      if (w > 0 && h > 0) {
        Canvas.clip(x, y, w, h)
        Canvas.print(value, x, y, _color)
        Canvas.clip()
      } else {
        Canvas.print(value, x, y, _color)
      }
    }
  }

  // Variables
  color     {_color}
  color=(v) {_color = v}
}

// Button
class Button is Element {
  construct new(value, x, y) {
    super(value, x, y, 86, 25)
    init_(Color.white)
  }

  construct new(value, x, y, w, h) {
    super(value, x, y, w, h)
    init_(Color.white)
  }

  init_(color) {
    _color = color
  }

  update() {
    if (isEnabled) {
      super.update()

      // Button press
      if (isFocused) {isFocused = false}
    }
  }

  draw() {
    if (isVisible) {
      super.draw()

      Canvas.clip(x, y, w, h)
      Canvas.rect(x, y, w, h, _color)
      Canvas.print(value, x + paddingX, y + paddingY, _color)
      Canvas.clip()
    }
  }

  // Variables
  color     {_color}
  color=(v) {_color = v}
}

// TextBox
class TextBox is Element {
  construct new(value, x, y) {
    super(value, x, y)
    init_(Color.white)
  }

  construct new(value, x, y, w, h) {
    super(value, x, y, w, h)
    init_(Color.white)
  }

  construct new(value, x, y, w, h, color) {
    super(value, x, y, w, h)
    init_(color)
  }

  init_(color) {
    _color = color
  }

  update() {
    if (isEnabled) {
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

            value = value + entry.key
          }
        }
      }
    }
  }

  draw() {
    if (isVisible) {
      super.draw()

      Canvas.clip(x, y, w, h)
      Canvas.rect(x, y, w, h, _color)
      Canvas.print(value, x + paddingX, y + paddingY, _color)
      Canvas.clip()
    }
  }

  // Variables
  color     {_color}
  color=(v) {_color = v}
}

class Slider is Element {
  construct new(x, y, w, h) {
    super(50, x, y, w, h)
    init_(0, 100, 10, 20)
  }

  construct new(x, y, w, h, hw, hh) {
    super(50, x, y, w, h)
    init_(0, 100, hw, hh)
  }

  construct new(value, min, max, x, y, w, h) {
    super(value, x, y, w, h)
    init_(min, max, 10, 20)
  }

  construct new(value, min, max, x, y, w, h, hw, hh) {
    super(value, x, y, w, h)
    init_(min, max, hw, hh)
  }

  init_(min, max, hw, hh) {
    _minX = x
    _maxX = (x + w) - hw

    _min = min
    _max = max

    hitbox.x = map(value, _min, _max, _minX, _maxX)
    hitbox.y = (y + (h / 2)) - (hh / 2)
    hitbox.w = hw
    hitbox.h = hh

    _color = Color.white
    _isDragging = false

    _onDrag = null
  }

  update() {
    if (isEnabled) {
      super.update()

      if (isFocused) {
        _isDragging = Mouse.isButtonPressed("left")
        isFocused = _isDragging

        if (_isDragging) {
          hitbox.x = (Mouse.pos.x - (hitbox.w / 2)).clamp(_minX, _maxX)
          value = map(hitbox.x, _minX, _maxX, _min, _max).round

          if (_onDrag) {_onDrag.call()}
        }
      }
    }
  }

  draw() {
    if (isVisible) {
      super.draw()

      Canvas.rect(x, y, w, h, _color)
      Canvas.rectfill(hitbox.x, hitbox.y, hitbox.w, hitbox.h, Color.white)
    }
  }

  map(v, afrom, ato, bfrom, bto) {
    return bfrom + ((v - afrom) * (bto - bfrom) / (ato - afrom))
  }

  onDrag(fn) {_onDrag = fn}
  onDrag     {_onDrag}

  min   {_min}
  max   {_max}
  color {_color}

  min=(v) {
    value = map(hitbox.x, _minX, _maxX, v, _max).round
    _min = v
  }

  max=(v) {
    value = map(hitbox.x, _minX, _maxX, _min, v).round
    _max = v
  }

  value=(v) {
    super.value = v.clamp(_min, _max)
    hitbox.x = (x - (hitbox.w / 2)) + (value / (_max - _min)) * w
  }

  color=(v) {_color = v}
}

class CheckBox is Element {
  construct new(x, y) {
    super(false, x, y, 30, 30)
    init_(Color.white)
  }

  construct new(value, x, y) {
    super(value, x, y, 30, 30)
    init_(Color.white)
  }

  construct new(x, y, w, h) {
    super(false, x, y, w, h)
    init_(Color.white)
  }

  construct new(value, x, y, w, h) {
    super(value, x, y, w, h)
    init_(Color.white)
  }

  init_(color) {
    _color = color

    onMouseClick {
      value = !value
    }
  }

  update() {
    if (isEnabled) {
      super.update()
    }
  }

  draw() {
    if (isVisible) {
      super.draw()

      Canvas.rect(x, y, w, h, _color)

      if (value) {
        Canvas.rectfill(x + paddingX, y + paddingY, w - (paddingX * 2), h - (paddingY * 2), _color)
      }
    }
  }

  color       {_color}
  color=(v)   {_color = v}
}

class RadioGroup is Frame {
  construct new() {
    super(0, 0, Canvas.width, Canvas.width)
    _onSelect = null
  }

  update() {
    if (isEnabled) {
      super.update()

      for (child in children) {
        child.update()
      }
    }
  }

  draw() {
    if (isVisible) {
      super.draw()

      for (child in children) {
        child.draw()
      }
    }
  }

  select(id) {
    if (_onSelect) {_onSelect.call()}

    for (child in children) {
      if (child.id == id) {
        child.value = true
      } else {
        if (child.value && child.onDeselect) {
          child.onDeselect.call()
        }
        child.value = false
      }
    }
  }

  selected {
    for (child in children) {
      if (child.value) {
        return child.id
      }
    }
    return null
  }

  onSelect(fn) {_onSelect = fn}
  onSelect     {_onSelect}
}

class RadioButton is Element {
  construct new(x, y) {
    super(false, x, y, 30, 30)
    init_(Color.white)
  }

  construct new(value, x, y) {
    super(value, x, y, 30, 30)
    init_(Color.white)
  }

  construct new(value, x, y, r) {
    super(value, x, y, r, r)
    init_(Color.white)
  }

  init_(color) {
    hitbox.x = x - (w / 2)
    hitbox.y = y - (h / 2)
    _color = color

    if (__id) {
      __id = __id + 1
    } else {
      __id = 0
    }

    _id = __id

    _onSelect = null
    _onDeselect = null

    onMouseClick {
      if (!value) { // Only trigger functions when not selected
         if (parent && _id) {parent.select(_id)}
         if (_onSelect)     {_onSelect.call()}
      }
    }
  }

  update() {
    if (isEnabled) {
      super.update()
    }
  }

  draw() {
    if (isVisible) {
      super.draw()
      Canvas.circle(x, y, w / 2, _color)

      if (value) {
        Canvas.circlefill(x, y, (w / 2) - paddingX, _color)
      }
    }
  }

  onSelect(fn)   {_onSelect = fn}
  onDeselect(fn) {_onDeselect = fn}

  onSelect       {_onSelect}
  onDeselect     {_onDeselect}

  color {_color}
  id    {_id}

  color=(v) {_color = v}
}

/*
// MAYBE DROPDOWN SHOULD BE A FRAME FOR CHILDREN??
class Dropdown is Element {
  construct new(x, y, w, h) {
    super(x, y, w, h)
    init_("", [])
  }

  init_() {
    _extended = false
    _options  = []      // Buttons?
  }

  update() {
    if (isEnabled) {
      super.update()
    }
  }

  draw() {
    if (isVisible) {
      super.draw()

      // Draw dropdown (extended / !extended)
      if (_extended) {

      } else {

      }
    }
  }

  [i] {
    if (i < _options.count) {
      return _options.count[i]
    }
  }

  selected {value}
  extended {_extended}
  options  {_options}

  extended=(v) {_extended = v}
  options=(v)  {_options = v}
}
*/

// TO-DO: Add multiline support
//class TextBoxMulti {}

var Rect = Rectangle
var Region = Rectangle
var Btn = Button
var Check = CheckBox
var Radio = RadioButton

