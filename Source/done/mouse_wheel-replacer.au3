#RequireAdmin
#include <AutoItConstants.au3>
HotKeySet("{NUMPADSUB}","UP")
HotKeySet("{NUMPADADD}","Down")
HotKeySet("{PAUSE}","stop")
While 1
	Sleep(100)
WEnd
Func	UP()

MouseWheel($MOUSE_WHEEL_UP, 1)
EndFunc

Func Down()
		MouseWheel($MOUSE_WHEEL_DOWN ,1 )

EndFunc
func stop()
	exit 0
EndFunc