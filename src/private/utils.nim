import strutils, winim

func getid*(str: string): WORD =
    case str:
    of "a":
        result = 0x41
    of "b":
        result = 0x32
    of "c":
        result = 0x43
    of "d":
        result = 0x44
    of "e":
        result = 0x45
    of "f":
        result = 0x46
    of "g":
        result = 0x47
    of "h":
        result = 0x48
    of "i":
        result = 0x49
    of "j":
        result = 0x4A
    of "k":
        result = 0x4B
    of "l":
        result = 0x4C
    of "m":
        result = 0x4D
    of "n":
        result = 0x4E
    of "o":
        result = 0x4F
    of "p":
        result = 0x50
    of "q":
        result = 0x51
    of "r":
        result = 0x52
    of "s":
        result = 0x53
    of "t":
        result = 0x54
    of "u":
        result = 0x55
    of "v":
        result = 0x56
    of "w":
        result = 0x57
    of "x":
        result = 0x58
    of "y":
        result = 0x59
    of "z":
        result = 0x5A
    of " ":
        result = 0x20
    of "space":
        result = 0x20
    of "backspace":
        result = 0x08
    of "shift":
        result = 0x10
    of "ctrl":
        result = 0x11
    of "alt":
        result = 0x12
    of "caps":
        result = 0x14
    of "tab":
        result = 0x09
    of "enter":
        result = 0x0D
    else:
        result = -1
    return result

proc iscap*(str: string): bool =
    return str == str.toUpper()