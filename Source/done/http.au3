#include <ButtonConstants.au3>
#include "Json.au3"
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include<Array.au3>
#Region ### START Koda GUI section ### Form=C:\Users\Rengumin\Documents\Code\Source\template.kxf
Global $something = GUICreate("something", 615, 329, -1, -1)
GUISetFont(16, 400, 0, "Segoe UI")
Global $Label1 = GUICtrlCreateLabel("Token", 24, 24, 60, 34)
Global $Label2 = GUICtrlCreateLabel("reply message: ", 24, 80, 150, 34)
Global $Token = GUICtrlCreateInput("", 200, 24, 361, 38)
Global $Template_string = GUICtrlCreateInput("", 200, 84, 361, 38)
Global $Save_str = GUICtrlCreateCheckbox("Save String", 200, 136, 225, 25)
Global $hide_c = GUICtrlCreateCheckbox("Hide content", 200, 176, 201, 25)
Global $Label3 = GUICtrlCreateLabel("Delay", 24, 248, 56, 34)
Global $Delay = GUICtrlCreateInput("", 200, 251, 161, 38)
Global $Button1 = GUICtrlCreateButton("Start", 432, 152, 153, 137)
GUISetState(@SW_SHOW)

#EndRegion ### END Koda GUI section ###
global $status = true
While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $Button1

			if $status Then
				Start()
				GUICtrlSetData($Button1,"Running...")
				$status = not($status)

			Else
				$status = not($status)
				GUICtrlSetData($Button1,"Start")
			EndIf

	EndSwitch
WEnd

Func Start()
	global $PNumbers =[] ;sdt

	local $Post_id = graphAPI("me/feed",'["data"][0]["id"]',"GET")
	local $cmts = graphAPI($Post_id&"/comments/",'["data"]',"GET")

	;reply
	$content = GUICtrlRead($Template_string)
	if $content Then
		for $cmt in $cmts
			local $ms = Json_Get($cmt,'["id"]')
			local $msgs = Json_Get($cmt,'["message"]')

			reply($ms,$content)
			_ArrayAdd($PNumbers,extractPhoneNumber($msgs))
		Next
		MsgBox(0,"","replied")
	EndIf
	;save Phone number
	if GUICtrlRead($Save_str) = $GUI_CHECKED Then
		_ArrayDelete($PNumbers,0)
		For $it = 0 to   UBound($PNumbers)-1 step  1
			if $PNumbers[$it] then
				IniWrite("PhoneNumber.ini","sdt",$it,$PNumbers[$it])
			endif
		Next
	EndIf

	;hide content
	if GUICtrlRead($hide_c) = $GUI_CHECKED then
		for $cmt in $cmts
			local $cmt_id = Json_Get($cmt,"[id]")
			hideContent($cmt_id)
		Next
		MsgBox(0,"","hid all others users comment")
	EndIf

	Sleep(GUICtrlRead($Delay))
EndFunc

func hideContent($cmt_id)
	graphAPI($cmt_id&"/?is_hidden=true&",'',"POST")
EndFunc
func reply($ms,$content)
	graphAPI("/"&$ms&'/comments?message='&$content&'&',"","POST")
EndFunc
func extractPhoneNumber($str)
	return	StringRegExp($str, "\d{9}",1)
EndFunc
func graphAPI($path,$dir,$method)
	local $page_token = "EAAKmZACMoEjABAMVPZC7MFBDnHecp2vxZBTDk9ONjk16eWIubYEKEWfVbgfBZCxIYZBhEyzn5YmE8MlZCZCqUZCFfi3RPJmZB4jeNtWcxw3FZBwL41543dx08G19VO8QVVfWybpYMN2UBWZBTpQcEyOxZCqkNHXb1fFZBtHOuJOOzm5LvvPdx9eUBhhfr"

	global $ohttp = ObjCreate("WinHttp.WinHttpRequest.5.1")
	Local $req = "https://graph.facebook.com/" & $path

	if StringInStr($path , "?") then
		$req &= "&access_token="&$page_token
	else
		$req &= "?access_token="&$page_token
	EndIf

	$ohttp.open($method,$req,false)
	$ohttp.send()
	$ohttp.WaitForResponse()
	local $result = $ohttp.responseText()
	$Json = Json_Decode($result)
;~ 	local $res = Json_Get($Json,'["data"][0]["id"]')

	local $res = Json_Get($Json,$dir)

	return $res

EndFunc