import "graphics" for Canvas, Color
import "input" for Mouse, Keyboard
import "math" for Vector

/* TO-DO:
 - Add max amount of characters to TextBox
 - Add combobox
 - error checks
 - testing
 - super null check show error
*/

class Theme {
  construct new() {
    if (!__fg)  {__fg  = Color.white}
    if (!__bg)  {__bg  = Color.black}
    if (!__out) {__out = Color.white}
    init_(__fg, __bg, __out)
  }

  construct new(fg, bg) {
    init_(fg, bg, Color.white)
  }
  
  construct new(fg, bg, out) {
    init_(fg, bg, out)
  }
  
  init_(fg, bg, out) {
    _fg  = fg
    _bg  = bg
    _out = out
  }
  
  // Getters
  fg  {__fg}
  bg  {__bg}
  out {__out}
  
  foreground {__fg}
  background {__bg}
  outline    {__out}
  
  // Setters
  fg=(v)  {__fg = v}
  bg=(v)  {__bg = v}
  out=(v) {__out = v}
  
  foreground=(v) {__fg = v}
  background=(v) {__bg = v}
  outline=(v)    {__out = v}
}
var theme_default = Theme.new(Color.white, Color.black, Color.white)

class Rectangle {
  construct new(a) {
    if (a is List) {
      if (a.count == 2) {
        init_(a[0], a[1], 0, 0)
      } else if (a.count == 4) {
        init_(a[0], a[1], a[2], a[3])
      }
    } else if (a is Vector) {
      init_(a.x, a.y, a.z, a.w)
    } else {
      // Error
    }
  }
  
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
  construct new(a) {
    if (a is List) {
      if (a.count == 2) {
        init_("", a[0], a[1], 0, 0)
      } else if (a.count == 4) {
        init_("", a[0], a[1], a[2], a[3])
      } else {
        // Error
      }
    } else if (a is Rectangle) {
      init_("", a.x, a.y, a.w, a.h)
    } else if (a is Vector) {
      init_("", a.x, a.y, a.z, a.w)
    } else {
      init_(a, 0, 0, 0, 0)
    }
  }
  
  construct new(a, b) {
    if (b is List) {
      if (b.count == 2) {
        init_(a, b[0], b[1], 0, 0)
      } else if (b.count == 4) {
        init_(a, b[0], b[1], b[2], b[3])
      } else {
        // Error
      }
    } else if (b is Rectangle) {
      init_(a, b.x, b.y, b.w, b.h)
    } else if (b is Vector) {
      init_(a, b.x, b.y, b.z, b.w)
    } else {
      // Error
    }
  }

  init_(value, x, y, w, h) {
    // Values
    _x = x
    _y = y
    _w = w
    _h = h

    _value = value
    _theme = Theme.new()

    _hitbox = Rectangle.new(_x, _y, _w, _h)

    _paddingX = 5.min(w)
    _paddingY = 5.min(h)

    _parent = null
    _step   = 0

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
  theme    {_theme}
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

  x=(v)        {_x        = v}
  y=(v)        {_y        = v}
  w=(v)        {_w        = v}
  h=(v)        {_h        = v}
  value=(v)    {_value    = v}
  theme=(v)    {_theme    = v}
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
    super([0, 0, Canvas.width, Canvas.height])
    init_()
  }
  
  construct new(a) {
    super(a)
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
  children=(v) {
    _children = v
    
    for (child in _children) {
      child.parent = this
    }
  }
}

class Label is Element {
  construct new(a) {
    super(a)
  }
  
  construct new(a, b) {
    super(a, b)
  }

  update() {super.update()}

  draw() {
    if (isVisible) {
      //super.draw()

      // Clip
      if (w > 0 && h > 0) {
        Canvas.clip(x, y, w, h)
        Canvas.print(value, x, y, theme.fg)
        Canvas.clip()
      } else {
        Canvas.print(value, x, y, theme.fg)
      }
    }
  }
}

// Button
class Button is Element {
  construct new(a) {
    super(a)
  }
  
  construct new(a, b) {
    super(a, b)
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
      //Canvas.rect(x, y, w, h, _color)
      Canvas.rect(x, y, w, h, theme.out)
      Canvas.print(value, x + paddingX, y + paddingY, theme.fg)
      Canvas.clip()
    }
  }

  // Variables
  //color     {_color}
  //color=(v) {_color = v}
}

// TextBox
// TO-DO: Add case conversion
// TO-DO: Change the way symbols + letters are supported
class TextBox is Element {
  construct new(a) {
    super(a)
    init_()
  }
  
  construct new(a, b) {
    super(a, b)
    init_()
  }
  
  init_() {
    _pos = value.count
    _max = -1
  }

  update() {
    if (isEnabled) {
      super.update()

      if (isFocused) {
        if (Keyboard.text.count > 0) {
          insert_(Keyboard.text)
        } else if (Keyboard["return"].justPressed && _pos > 0) {
          insert_("\n")
        } else if (Keyboard["backspace"].justPressed && _pos > 0) {
          delete_()
        } else {
          if (Keyboard["left"].justPressed) {
            moveCursor_(-1)
          } else if (Keyboard["right"].justPressed) {
            moveCursor_(1)
          }
        }
      }
    }
  }

  draw() {
    if (isVisible) {
      super.draw()

      Canvas.clip(x, y, w, h)
      Canvas.rect(x, y, w, h, theme.out)
      Canvas.print(value, x + paddingX, y + paddingY, theme.fg)
      Canvas.clip()
    }
  }
  
  delete_() {
    if (_pos > 0) {
      var codePoints = value.codePoints
      codePoints = codePoints.take(_pos-1).toList + codePoints.skip(_pos).toList
      
      value = ""
      for (point in codePoints) {
        value = value + String.fromCodePoint(point)
      }
      
      _pos = _pos - 1
    }
  }
  
  insert_(text) {
    var result = ""
    var length = text.codePoints.count
    var count  = length
    
    if (_max != -1) {
      count = _max - (value.codePoints.count + (count - 1))
    }
    
    if (count > 0) {
      for(point in value.codePoints.take(_pos))  result = result + String.fromCodePoint(point)
      for(point in text.codePoints.take(count))  result = result + String.fromCodePoint(point)
      for(point in value.codePoints.skip(_pos))  result = result + String.fromCodePoint(point)
      
      value = result
      
      _pos = _pos + length
    }
  }
  
  moveCursor_(direction) {
    if (direction >= 0) {
      if (_pos + direction <= value.count) {_pos = _pos + direction}
    } else {
      if (_pos + direction > 0)            {_pos = _pos + direction}
    }
  }
  
  max         {_max}
  allowedKeys {_allowedKeys}
  
  max=(v)         {_max = v}
  allowedKeys=(v) {_allowedKeys = v}
}

// TO-DO: Add default variables
// TO-DO: Add rectangle support in new(a, b)
class Slider is Element {
  construct new() {
    super(50, [0, 0, 100, 20])
    init_(0, 100, 10, 20)
  }

  construct new(a) {
    if (a is Num) {
      super(a, [0, 0, 100, 20])
    } else {
      super(50, a)
    }
    init_(0, 100, 10, 20)
  }
  
  construct new(a, b) {
    super(a, b)
    init_(0, 100, 10, 20)
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

      Canvas.rect(x, y, w, h, theme.out)
      Canvas.rectfill(hitbox.x, hitbox.y, hitbox.w, hitbox.h, theme.fg)
    }
  }

  map(v, afrom, ato, bfrom, bto) {
    return bfrom + ((v - afrom) * (bto - bfrom) / (ato - afrom))
  }

  onDrag(fn) {_onDrag = fn}
  onDrag     {_onDrag}

  min   {_min}
  max   {_max}

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
}

class CheckBox is Element {
  construct new(a) {
    if (a is Bool) {
      super(a, [0, 0, 20, 20])
    } else {
      super(false, a)
    }
    init_()
  }
  
  construct new(a, b) {
    super(a, b)
    init_()
  }

  init_() {
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

      Canvas.rect(x, y, w, h, theme.out)

      if (value) {
        Canvas.rectfill(x + paddingX, y + paddingY, w - (paddingX * 2), h - (paddingY * 2), theme.fg)
      }
    }
  }
}

class RadioGroup is Frame {
  construct new() {
    super([0, 0, Canvas.width, Canvas.width])
    _onSelect = null
  }
  
  construct new(a) {
    super(a)
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
  construct new(a) {
    if (a is Bool) {
      super(a, [20, 20, 25, 25])
    } else {
      super(false, a)
    }
    
    init_()
  }
  
  construct new(a, b) {
    super(a, b)
    init_()
  }

  init_() {
    hitbox.x = x - (w / 2)
    hitbox.y = y - (h / 2)

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
      Canvas.circle(x, y, w / 2, theme.out)

      if (value) {
        Canvas.circlefill(x, y, (w / 2) - paddingX, theme.fg)
      }
    }
  }

  onSelect(fn)   {_onSelect = fn}
  onDeselect(fn) {_onDeselect = fn}

  onSelect       {_onSelect}
  onDeselect     {_onDeselect}

  id    {_id}
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

// TO-DO: Add multiline support (perhaps just a variable?)

var Rect = Rectangle
var Region = Rectangle
var Btn = Button
var Check = CheckBox
var Radio = RadioButton

