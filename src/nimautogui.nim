import winim, os, osproc, math, private/utils

proc setpos*(x: int32, y: int32) =
    SetCursorPos(x, y)

proc movepos*(x: int32, y: int32) =
    var cords: POINT
    GetCursorPos(cords)
    setpos(cords.x + x, cords.y + y)

proc mousedown*() =
    var
        input: INPUT
        inputs: UINT = 1

    input.type = INPUT_MOUSE
    input.mi.dx = 0
    input.mi.dy = 0
    input.mi.mouseData = 0
    input.mi.dwFlags = MOUSEEVENTF_LEFTDOWN
    input.mi.time = 0
    input.mi.dwExtraInfo = 0

    SendInput(inputs, input, cast[int32](sizeof(INPUT)))

proc mouseup*() =
    var
        input: INPUT
        inputs: UINT = 1

    input.type = INPUT_MOUSE
    input.mi.dx = 0
    input.mi.dy = 0
    input.mi.mouseData = 0
    input.mi.dwFlags = MOUSEEVENTF_LEFTUP
    input.mi.time = 0
    input.mi.dwExtraInfo = 0

    SendInput(inputs, input, cast[int32](sizeof(INPUT)))

proc click*(num: int) =
    for i in 0..num:
        mousedown()
        mouseup()

proc wait*(time: int) =
    sleep(time)

proc moveaxis*(axis: string, value: int32) =
    if axis == "x":
        var cords: POINT
        GetCursorPos(cords)
        setpos(cords.x + value, cords.y)
    elif axis == "y":
        var cords: POINT
        GetCursorPos(cords)
        setpos(cords.x, cords.y + value)

proc rmousedown*() =
    var
        input: INPUT
        inputs: UINT = 1

    input.type = INPUT_MOUSE
    input.mi.dx = 0
    input.mi.dy = 0
    input.mi.mouseData = 0
    input.mi.dwFlags = MOUSEEVENTF_RIGHTDOWN
    input.mi.time = 0
    input.mi.dwExtraInfo = 0

    SendInput(inputs, input, cast[int32](sizeof(INPUT)))

proc rmouseup*() =
    var
        input: INPUT
        inputs: UINT = 1

    input.type = INPUT_MOUSE
    input.mi.dx = 0
    input.mi.dy = 0
    input.mi.mouseData = 0
    input.mi.dwFlags = MOUSEEVENTF_RIGHTUP
    input.mi.time = 0
    input.mi.dwExtraInfo = 0

    SendInput(inputs, input, cast[int32](sizeof(INPUT)))

proc rclick*(num: int) =
    for i in 0..num:
        rmousedown()
        rmouseup()

proc scroll*(num: int32) =
    var
        input: INPUT
        inputs: UINT = 1

    input.type = INPUT_MOUSE
    input.mi.mouseData = num
    input.mi.dwFlags = MOUSEEVENTF_WHEEL

    SendInput(inputs, input, cast[int32](sizeof(INPUT)))

proc hscroll*(num: int32) =
    var
        input: INPUT
        inputs: UINT = 1

    input.type = INPUT_MOUSE
    input.mi.mouseData = num
    input.mi.dwFlags = MOUSEEVENTF_HWHEEL

    SendInput(inputs, input, cast[int32](sizeof(INPUT)))

proc mmousedown*() =
    var
        input: INPUT
        inputs: UINT = 1

    input.type = INPUT_MOUSE
    input.mi.dx = 0
    input.mi.dy = 0
    input.mi.mouseData = 0
    input.mi.dwFlags = MOUSEEVENTF_MIDDLEDOWN
    input.mi.time = 0
    input.mi.dwExtraInfo = 0

    SendInput(inputs, input, cast[int32](sizeof(INPUT)))

proc mmouseup*() =
    var
        input: INPUT
        inputs: UINT = 1

    input.type = INPUT_MOUSE
    input.mi.dx = 0
    input.mi.dy = 0
    input.mi.mouseData = 0
    input.mi.dwFlags = MOUSEEVENTF_MIDDLEUP
    input.mi.time = 0
    input.mi.dwExtraInfo = 0

    SendInput(inputs, input, cast[int32](sizeof(INPUT)))

proc mclick*(num: int) =
    for i in 0..num:
        mmousedown()
        mmouseup()

proc setaxis*(axis: string, value: int32) =
    if axis == "x":
        var cords: POINT
        GetCursorPos(cords)
        setpos(value, cords.y)
    elif axis == "y":
        var cords: POINT
        GetCursorPos(cords)
        setpos(cords.x, cords.y + value)

proc center* =
    setpos(cast[int32]((GetSystemMetrics(0) / 2).round.to_int), cast[int32]((GetSystemMetrics(1) / 2).round.to_int))

proc log*(text: string, file: string = "macro_log.txt") =
    var log = open("macro_log.txt", fmAppend)
    log.writeLine(text)

proc clipboard*: string =
    return execProcess("powershell Get-Clipboard")

proc keydown*(key: string) =
    var t: INPUT
    t.type = INPUT_KEYBOARD
    t.ki.wScan = 0
    t.ki.time = 0
    t.ki.dwExtraInfo = 0
    t.ki.wVk = getid(key)
    t.ki.dwFlags = 0
    SendInput(1, t, cast[int32](sizeof(t)))

proc keyup*(key: string) =
    var t: INPUT
    t.type = INPUT_KEYBOARD
    t.ki.wScan = 0
    t.ki.time = 0
    t.ki.dwExtraInfo = 0
    t.ki.wVk = getid(key)
    t.ki.dwFlags = 0x0002
    SendInput(1, t, cast[int32](sizeof(t)))

proc press*(key: string) =
    keydown(key)
    keyup(key)

proc typewords*(key: string) =
    for i in key.items:
        var t = $i
        if t.iscap:
            keydown("shift")
            press(t)
            keyup("shift")
        else:
            press(t)
proc hotkey*(key: string, key2: string) =
    keydown(key)
    press(key2)
    keyup(key)