Const $text = "Altium Designer 18 Installer"

Func Uninstall($config)
    Local $uninstall = $config.Item("uninstall")
    ConsoleWrite("XXX Uninstall: " & $uninstall & @LF)

    ; Run uninstallation program
    ;local $pid = Run('C:\Program Files\Altium\AD19\System\Installation\AltiumInstaller.exe -Ufninstall -UniqueID:"{404E0CD4-F33F-4949-8A1C-936FEA2385B1}"')
    local $pid = Run('C:\Program Files\Altium\AD19\System\Installation\AltiumInstaller.exe -Uninstall')

    If $pid = 0 Then
	   ConsoleWrite("Error: " & @error & @LF)
    EndIf

    ; Altium Designer Uninstaller
    ;
	ConsoleWrite("Welcome" & @LF)
    WinWaitActive($text, "Uninstall")
	ConsoleWrite("xxxx" & @LF)
    ControlCommand($text, "", "[CLASS:TXPRadioButton; INSTANCE:1]", "Check", "")
    ConsoleWrite("yyyyy" & @LF)
	Send("!n")
    ConsoleWrite("zzzz" & @LF)

    ; Uninstallation Finish
	WinWait($text, "Finish")
    Send("!f")
	ConsoleWrite("Finish" & @LF)

    WinClose($text)
 EndFunc

ConsoleWrite("Starting" & @LF)
Local $config = ObjCreate("Scripting.Dictionary")
; $config.Add("uninstall", $CmdLine[1])
$config.Add("uninstall", 'C:\Program Files\Altium\AD19\System\Installation\AltiumInstaller.exe -Uninstall')

#RequireAdmin
Uninstall($config)
ConsoleWrite("End of Uninstall!" & @LF)