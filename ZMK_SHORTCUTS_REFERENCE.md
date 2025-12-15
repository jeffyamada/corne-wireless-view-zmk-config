# ZMK Shortcuts and Keycodes Reference

This document provides a comprehensive reference of shortcuts, keycodes, and behaviors available in ZMK that can be configured via the ZMK Studio GUI or directly in keymap files.

## Table of Contents

- [Basic Behaviors](#basic-behaviors)
- [Keyboard Keycodes](#keyboard-keycodes)
- [Modifiers](#modifiers)
- [Layer Behaviors](#layer-behaviors)
- [Media Controls](#media-controls)
- [Consumer Controls](#consumer-controls)
- [Modifier Functions](#modifier-functions)
- [Advanced Behaviors](#advanced-behaviors)

---

## Basic Behaviors

### Key Press (`&kp`)
Sends a standard keycode when pressed.

**Usage:** `&kp KEYCODE`

**Example:** `&kp A`, `&kp SPACE`, `&kp ENTER`

---

## Keyboard Keycodes

### Letters
- `A`, `B`, `C`, `D`, `E`, `F`, `G`, `H`, `I`, `J`, `K`, `L`, `M`
- `N`, `O`, `P`, `Q`, `R`, `S`, `T`, `U`, `V`, `W`, `X`, `Y`, `Z`

### Numbers
- `N1` (or `NUMBER_1`) - 1
- `N2` (or `NUMBER_2`) - 2
- `N3` (or `NUMBER_3`) - 3
- `N4` (or `NUMBER_4`) - 4
- `N5` (or `NUMBER_5`) - 5
- `N6` (or `NUMBER_6`) - 6
- `N7` (or `NUMBER_7`) - 7
- `N8` (or `NUMBER_8`) - 8
- `N9` (or `NUMBER_9`) - 9
- `N0` (or `NUMBER_0`) - 0

### Symbols and Punctuation
- `EXCL` or `EXCLAMATION` - !
- `AT` or `AT_SIGN` - @
- `HASH` or `POUND` - #
- `DLLR` or `DOLLAR` - $
- `PERCENT` or `PRCNT` - %
- `CARET` - ^
- `AMPS` or `AMPERSAND` - &
- `ASTERISK` or `STAR` - *
- `LPAR` or `LEFT_PARENTHESIS` - (
- `RPAR` or `RIGHT_PARENTHESIS` - )
- `MINUS` - -
- `UNDER` or `UNDERSCORE` - _
- `EQUAL` - =
- `PLUS` - +
- `LBKT` or `LEFT_BRACKET` - [
- `RBKT` or `RIGHT_BRACKET` - ]
- `LBRC` or `LEFT_BRACE` - {
- `RBRC` or `RIGHT_BRACE` - }
- `BSLH` or `BACKSLASH` - \
- `PIPE` - |
- `SEMI` or `SEMICOLON` - ;
- `COLON` - :
- `SQT` or `SINGLE_QUOTE` or `APOSTROPHE` - '
- `DQT` or `DOUBLE_QUOTES` - "
- `GRAVE` - `
- `TILDE` - ~
- `COMMA` - ,
- `DOT` or `PERIOD` - .
- `FSLH` or `SLASH` - /
- `QMARK` or `QUESTION` - ?
- `LT` or `LESS_THAN` - <
- `GT` or `GREATER_THAN` - >

### Control & Whitespace
- `TAB` - Tab
- `SPACE` or `SPC` - Spacebar
- `ENTER` or `RETURN` or `RET` - Enter/Return
- `ESCAPE` or `ESC` - Escape
- `BSPC` or `BACKSPACE` - Backspace
- `DEL` or `DELETE` - Delete (forward delete)

### Navigation Keys
- `UP` or `UP_ARROW` - Up Arrow
- `DOWN` or `DOWN_ARROW` - Down Arrow
- `LEFT` or `LEFT_ARROW` - Left Arrow
- `RIGHT` or `RIGHT_ARROW` - Right Arrow
- `HOME` - Home
- `END` - End
- `PG_UP` or `PAGE_UP` - Page Up
- `PG_DN` or `PAGE_DOWN` - Page Down
- `INS` or `INSERT` - Insert

### Function Keys
- `F1` through `F24` - Function keys F1-F24

### Lock Keys
- `CAPS` or `CAPSLOCK` - Caps Lock
- `PSCRN` or `PRINTSCREEN` - Print Screen
- `SLCK` or `SCROLLLOCK` - Scroll Lock
- `PAUSE_BREAK` - Pause/Break

### Keypad Keys
- `KP_NUM` or `KP_NUMLOCK` - Num Lock
- `KP_DIVIDE` or `KP_SLASH` - Keypad /
- `KP_MULTIPLY` or `KP_ASTERISK` - Keypad *
- `KP_MINUS` or `KP_SUBTRACT` - Keypad -
- `KP_PLUS` - Keypad +
- `KP_ENTER` - Keypad Enter
- `KP_N0` through `KP_N9` - Keypad 0-9
- `KP_DOT` - Keypad .
- `KP_COMMA` - Keypad ,
- `KP_EQUAL` - Keypad =
- `KP_CLEAR` - Keypad Clear

### Editing Keys
- `K_CUT` - Cut
- `K_COPY` - Copy
- `K_PASTE` - Paste
- `K_UNDO` - Undo
- `K_REDO` or `K_AGAIN` - Redo/Again
- `K_FIND` - Find
- `K_SELECT` - Select
- `K_STOP` - Stop

### Application Keys
- `K_APP` or `K_APPLICATION` or `K_CMENU` - Application/Context Menu
- `K_EXEC` or `K_EXECUTE` - Execute
- `K_HELP` - Help
- `K_MENU` - Menu
- `K_CANCEL` - Cancel
- `K_POWER` or `K_PWR` - Power

---

## Modifiers

### Left Modifiers
- `LCTRL` or `LEFT_CONTROL` - Left Control
- `LSHIFT` or `LSHFT` or `LEFT_SHIFT` - Left Shift
- `LALT` or `LEFT_ALT` - Left Alt
- `LGUI` or `LEFT_GUI` or `LWIN` or `LCMD` - Left GUI/Windows/Command/Meta

### Right Modifiers
- `RCTRL` or `RIGHT_CONTROL` - Right Control
- `RSHIFT` or `RSHFT` or `RIGHT_SHIFT` - Right Shift
- `RALT` or `RIGHT_ALT` - Right Alt
- `RGUI` or `RIGHT_GUI` or `RWIN` or `RCMD` - Right GUI/Windows/Command/Meta

---

## Modifier Functions

Modifier functions can be combined with keycodes to create modified key presses.

**Format:** `MODIFIER(KEYCODE)` or `MODIFIER(MODIFIER(KEYCODE))` for multiple modifiers

### Modifier Prefixes
- `LS(...)` - Left Shift
- `LC(...)` - Left Control
- `LA(...)` - Left Alt
- `LG(...)` - Left GUI
- `RS(...)` - Right Shift
- `RC(...)` - Right Control
- `RA(...)` - Right Alt
- `RG(...)` - Right GUI

**Examples:**
- `&kp LS(A)` - Shift+A (capital A)
- `&kp LC(C)` - Ctrl+C (copy)
- `&kp LG(LEFT)` - Cmd+Left Arrow (macOS) or Win+Left Arrow (Windows)
- `&kp LC(RA(B))` - Ctrl+Alt+B

---

## Layer Behaviors

### Momentary Layer (`&mo`)
Activates a layer while held.

**Usage:** `&mo LAYER_NUMBER`

**Example:** `&mo 1` - Activates layer 1 while held

### Toggle Layer (`&tog`)
Toggles a layer on/off.

**Usage:** `&tog LAYER_NUMBER`

**Example:** `&tog 2` - Toggles layer 2

### To Layer (`&to`)
Switches to a layer (one-shot).

**Usage:** `&to LAYER_NUMBER`

**Example:** `&to 3` - Switches to layer 3

### Transparent (`&trans`)
Passes through to the layer below.

**Usage:** `&trans`

---

## Media Controls

### Volume (Consumer Keycodes)
- `C_VOL_UP` or `C_VOLUME_UP` - Volume Up
- `C_VOL_DN` or `C_VOLUME_DOWN` - Volume Down
- `C_MUTE` - Mute

### Media Playback
- `C_PLAY_PAUSE` or `C_PP` - Play/Pause
- `C_NEXT` - Next Track
- `C_PREV` - Previous Track
- `C_STOP` - Stop
- `C_EJECT` - Eject

### Display Brightness
- `C_BRI_UP` or `C_BRIGHTNESS_UP` - Brightness Up
- `C_BRI_DN` or `C_BRIGHTNESS_DOWN` - Brightness Down

### Consumer Controls
- `C_AL_CALC` - Calculator
- `C_AL_PWR` - Power
- `C_AL_EMAIL` - Email
- `C_AL_FILE_MANAGER` - File Manager
- `C_AL_IM` - Instant Messenger
- `C_AL_KEYBOARD_LAYOUT` - Keyboard Layout
- `C_AL_LOCAL_BROWSER` - Local Browser
- `C_AL_LOCK` - Lock
- `C_AL_LOWER_BRIGHTNESS` - Lower Brightness
- `C_AL_MEDIA_PLAYER` - Media Player
- `C_AL_PICKUP_PHONE` - Pickup Phone
- `C_AL_SCREENSAVER` - Screensaver
- `C_AL_SEARCH` - Search
- `C_AL_SLEEP` - Sleep
- `C_AL_TERMINAL_LOCK` - Terminal Lock
- `C_AL_UPPER_BRIGHTNESS` - Upper Brightness
- `C_AL_WWW_BROWSER` - WWW Browser

---

## Advanced Behaviors

### Mod-Tap (`&mt`)
Sends one keycode when held (usually a modifier) and another when tapped.

**Usage:** `&mt MODIFIER TAP_KEY`

**Example:** 
- `&mt LSHIFT A` - Hold for Shift, tap for A
- `&mt LCTRL ESC` - Hold for Ctrl, tap for Escape

### Layer-Tap (`&lt`)
Activates a layer when held, sends a keycode when tapped.

**Usage:** `&lt LAYER_NUMBER KEYCODE`

**Example:** `&lt 1 SPACE` - Hold for layer 1, tap for Space

### Sticky Key (`&sk`)
Makes a modifier key "sticky" - press once to activate, press again to deactivate.

**Usage:** `&sk KEYCODE`

**Example:** `&sk LSHIFT` - Sticky Shift

### Sticky Layer (`&sl`)
Makes a layer "sticky" - press once to activate, press again to deactivate.

**Usage:** `&sl LAYER_NUMBER`

**Example:** `&sl 2` - Sticky layer 2

### Key Toggle (`&kt`)
Toggles a key on/off.

**Usage:** `&kt KEYCODE`

**Example:** `&kt CAPS` - Toggle Caps Lock

### Caps Word (`&caps_word`)
Activates caps word mode (capitalizes next word).

**Usage:** `&caps_word`

### Reset (`&reset`)
Resets the keyboard (enters bootloader).

**Usage:** `&reset`

### Bootloader (`&bootloader`)
Enters bootloader mode.

**Usage:** `&bootloader`

### None (`&none`)
No action (empty key).

**Usage:** `&none`

---

## Macros

Macros can be defined in the keymap file and then referenced in bindings.

**Example Definition:**
```dts
macros {
    macro_0: macro_0 {
        label = "ZM_macro_0";
        compatible = "zmk,behavior-macro";
        #binding-cells = <0>;
        bindings = <&macro_tap &kp LG(K) &kp LG(LEFT)>;
    };
};
```

**Usage:** `&macro_0`

---

## Common Modifier Combinations

### macOS (Command)
- `LG(K)` - Cmd+K
- `LG(LEFT)` - Cmd+Left Arrow
- `LG(RIGHT)` - Cmd+Right Arrow
- `LG(UP)` - Cmd+Up Arrow
- `LG(DOWN)` - Cmd+Down Arrow
- `LG(TAB)` - Cmd+Tab (App Switcher)
- `LG(SPACE)` - Cmd+Space (Spotlight)

### Windows/Linux (Control)
- `LC(C)` - Ctrl+C (Copy)
- `LC(V)` - Ctrl+V (Paste)
- `LC(X)` - Ctrl+X (Cut)
- `LC(Z)` - Ctrl+Z (Undo)
- `LC(Y)` - Ctrl+Y (Redo)
- `LC(A)` - Ctrl+A (Select All)
- `LC(S)` - Ctrl+S (Save)
- `LC(TAB)` - Ctrl+Tab (Tab Switcher)

### Alt Combinations
- `LA(TAB)` - Alt+Tab (Window Switcher)
- `LA(F4)` - Alt+F4 (Close Window)

### Shift Combinations
- `LS(TAB)` - Shift+Tab (Reverse Tab)
- `LS(SPACE)` - Shift+Space

---

## Tips for ZMK Studio GUI

1. **Basic Key Press**: Select "Key Press" behavior and choose your keycode from the dropdown
2. **Modifiers**: Use modifier functions like `LS(...)`, `LC(...)`, `LG(...)` for modified keys
3. **Layers**: Use `&mo`, `&tog`, or `&to` behaviors for layer switching
4. **Hold-Tap**: Use `&mt` for mod-tap and `&lt` for layer-tap behaviors
5. **Media Keys**: Use consumer keycodes (prefixed with `C_`) for media controls
6. **Empty Keys**: Use `&none` or `&trans` for keys you don't want to bind

---

## Notes

- ZMK uses 0-based layer numbering (Layer 0 is the base layer)
- Consumer keycodes (`C_*`) are used for media and system controls
- Keyboard keycodes (`K_*`) are used for standard keyboard functions
- Modifier functions can be nested: `LC(RA(B))` = Ctrl+Alt+B
- Some keycodes have multiple aliases (e.g., `SPACE` and `SPC` both work)
- Conditional layers allow automatic layer activation when multiple layers are active simultaneously

---

## References

- [ZMK Documentation](https://zmk.dev/docs)
- [ZMK Keycodes List](https://zmk.dev/docs/keymaps/list-of-keycodes)
- [ZMK Behaviors](https://zmk.dev/docs/keymaps/behaviors)

