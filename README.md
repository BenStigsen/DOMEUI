# DOMEUI
Minimal UI library for the tiny game engine **[DOME](https://github.com/domeengine/dome)**.

## Goal
The goal of DOMEUI is to provide a very minimal and easy-to-use set of UI controls.
For easy game creation and fast prototyping (especially during game jams).

DOMEUI examples use the **[monogram](https://datagoblin.itch.io/monogram)** font, but does work with other fonts.

Examples can be found **[here](./examples)**

## To-Do

***NOTE: Several bindings and TextBox changes depend on future DOME versions and will only be completed later.***
***Functions such as `onMouseRelease` and `onKeyRelease` should be exposed by DOME and shouldn't be handled by DOMEUI.***

### Specific
- [ ] Element _(superclass to all UI elements)_
  - [ ] Focus
  - [x] ~~Padding~~
  - [x] ~~Animation Support~~
  - [x] ~~Show / Hide~~
  - [x] ~~Disable widget~~
  - [ ] Binding _(more might be added)_
    - [x] ~~onFocusEnter~~
    - [x] ~~onFocusExit~~
    - [x] ~~onMouseClick~~
    - [ ] onMouseRelease
    - [x] ~~onKeyPress~~
    - [ ] onKeyRelease
    - [x] ~~onUpdate~~
    - [x] ~~onDraw~~
    - [x] ~~onVisible~~
    - [x] ~~onInvisible~~
    - [x] ~~onEnable~~
    - [x] ~~onDisable~~
- [x] ~~Frame~~
  - [x] ~~Children~~
- [ ] Label
  - [ ] Hitbox
- [x] ~~Button~~
  - [x] ~~Out-of-bounds clip~~
  - [x] ~~Input~~
- [x] ~~Checkbox~~
- [x] ~~RadioGroup~~
  - [x] ~~Binding~~
    - [x] ~~onSelect~~
- [x] ~~RadioButton~~
  - [x] ~~Get selection~~
  - [X] ~~Unique ID~~
  - [x] ~~Binding~~
    - [x] ~~onSelect~~
    - [x] ~~onDeselect~~
- [ ] TextBox
  - [x] ~~Out-of-bounds clip~~
  - [x] Cursor
  - [ ] Max Length
  - [x] Input _(until keycodes or UTF-8 characters are exposed from C, the user will have to supply their own list of allowed keys)._
- [ ] Multiline TextBox
  - [ ] Cursor
  - [ ] Max Length
  - [ ] Input
    - [ ] Letters / Numbers
    - [ ] Symbols
    - [ ] Special keys (capslock, shift, etc...)
  - [ ] Text wrapping
- [ ] Slider
  - [ ] Increments / Decimal rounding
  - [x] ~~Value scaling~~
  - [x] ~~Min / Max range~~
  - [x] ~~Binding~~
    - [x] ~~onDrag~~
- [ ] Dropdown **(?)**
  - ...

---

- [ ] Add rectangle, list and vector support **(NEEDS MORE TESTING)**
- [ ] Add foreground and background colors
- [ ] Simplify value system
- [ ] Simplify color system
- [ ] Simplify clipping system

---

- [ ] Add documentation

---

### [Examples](./examples)
- [x] ~~Frame~~
- [ ] Label
- [ ] Button
- [x] ~~Checkbox~~
- [x] ~~Radiobutton~~
- [ ] TextBox
- [ ] Multiline TextBox
- [ ] Slider
- [ ] Dropdown
- [ ] All Widgets

---
__The examples below are based on [7GUIs](https://eugenkiss.github.io/7guis/tasks/)__

- [x] ~~Counter~~
- [ ] Temperature Converter
- [ ] Flight Booker
- [ ] Timer
- [ ] CRUD?
- [ ] Circle Drawer
- [ ] Cells?
- [ ] Animation

