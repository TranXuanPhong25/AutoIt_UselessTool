#include <GUIConstantsEx.au3>
#include<Array.au3>
#include<GuiListView.au3>
#include <ListViewConstants.au3>
#include <WindowsConstants.au3>
Opt("GUIResizeMode", $GUI_DOCKAUTO)
#Region ### START Koda GUI section ### Form=C:\Users\Rengumin\Documents\Code\Source\template.kxf
Global $Task = GUICreate("Task", 598, 420, -1, -1, BitOR($GUI_SS_DEFAULT_GUI,$WS_MAXIMIZEBOX,$WS_SIZEBOX,$WS_THICKFRAME,$WS_TABSTOP))
Global $MenuItem1 = GUICtrlCreateMenu("File")
Global $MenuItem2 = GUICtrlCreateMenuItem("Run New Task", $MenuItem1)
Global $MenuItem3 = GUICtrlCreateMenuItem("End Task", $MenuItem1)
Global $MenuItem4 = GUICtrlCreateMenuItem("Exit", $MenuItem1)
GUISetFont(12, 400, 0, "Segoe UI")
Global $ListView1 = GUICtrlCreateListView("Name|PID", 0, 0, 630, 475)

GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

loadProcess()
_GUICtrlListView_SetColumnWidth($ListView1,0,$LVSCW_AUTOSIZE_USEHEADER )
_GUICtrlListView_SetColumnWidth($ListView1,1,$LVSCW_AUTOSIZE_USEHEADER )

While 1
	$nMsg = GUIGetMsg()




	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $MenuItem4
			Exit
		Case $MenuItem2 ;run task
;~ 			ShellExecute("")

		Case $MenuItem3; terminate task
			local $index = _GUICtrlListView_GetSelectedIndices($ListView1)
			local $target = _GUICtrlListView_GetItemText($ListView1,Number($index))


			ProcessClose($target)

		Case $ListView1

	EndSwitch
WEnd
Func loadProcess()
	Global $ProcessArr = ProcessList()
	For $i = 2 to $ProcessArr[0][0]
		GUICtrlCreateListViewItem($ProcessArr[$i][0]&"|"&$ProcessArr[$i][1],$ListView1)

	Next

endFunc
