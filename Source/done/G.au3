#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\..\..\..\Downloads\5761455_league of legends_logo_lol_strategy_icon.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <ButtonConstants.au3>
#include "Json.au3"
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include<Array.au3>
Opt("GUIResizeMode", $GUI_DOCKAUTO)
global $imgdir=@ScriptDir&"\image.jpg"
global $html = graphAPI("https://lienminh.garena.vn/champions","GET")
Global $pure_heroes = StringRegExp($html, 'class="name" data-v-5eb1082c>\w+.?\w+',3)
global $heroes=[]
;~ global $img =[]
For $hero in  $pure_heroes
	local $x = StringRegExp($hero,">.+",1)
	$x= _ArrayToString($x)
	$x = StringTrimLeft($x,1)
	if $x="ng" then
		$x="Wukong"
	EndIf
	if $x="Dr" then
		$x="Dr.Mundo"
	EndIf
	_ArrayAdd($heroes,$x)
;~ 	_ArrayAdd($img,"https://cdngarenanow-a.akamaihd.net/games/lol/2020/LOLwebsite/champion/"&$x&"_0.jpg")
Next


#Region ### START Koda GUI section ### Form=
Global $Form1 = GUICreate("Randomrize Hero", 792, 549, 621, 250, BitOR($GUI_SS_DEFAULT_GUI,$WS_MAXIMIZEBOX,$WS_TABSTOP))
GUISetFont(14, 400, 0, "Segoe UI")
Global $Button1 = GUICtrlCreateButton("Start", 600, 464, 137, 49)
Global $All = GUICtrlCreateRadio("All", 616, 48, 105, 33)
Global $xathu = GUICtrlCreateRadio("Radio1", 616, 107, 105, 33)
Global $dausi = GUICtrlCreateRadio("Radio1", 616, 226, 105, 33)
Global $tanker = GUICtrlCreateRadio("Radio1", 616, 167, 105, 33)
Global $satthu = GUICtrlCreateRadio("Radio1", 616, 286, 105, 33)
Global $sp = GUICtrlCreateRadio("Radio1", 616, 405, 105, 33)
Global $phapsu = GUICtrlCreateRadio("Radio1", 616, 345, 105, 33)
Global $Pic1 = GUICtrlCreatePic("", 100, 100, 250, 282, BitOR($GUI_SS_DEFAULT_PIC,$SS_CENTERIMAGE))
Global $Label1 = GUICtrlCreateLabel("",195, 448, 220, 41)
GUICtrlSetFont(-1, 20, 400, 0, "Segoe UI")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			FileDelete($imgdir)
			Exit
		Case $Button1
			global $re= $heroes[Random(1,160,1)]
			GUICtrlSetData($Label1,$re)
			if $re ="Wukong" Then
				$re = "MonkeyKing"
			EndIf
			$re = StringReplace($re,".","")
			if StringInStr($re,"'") Then
				$re = StringReplace($re,"'","")
				$re =StringLeft($re,1)&StringLower(StringRight($re,StringLen($re)-1))


			EndIf

			$re = StringReplace($re," ","")
			global $img = "https://cdngarenanow-a.akamaihd.net/games/lol/2020/LOLwebsite/champion/"&$re&"_0.jpg"
			InetGet($img,"image.jpg")
			GUICtrlSetImage($Pic1,$imgdir)

	EndSwitch
WEnd
;~ Func	UltimateRandom()
;~ 	local $r =  Random(1,160,1)
;~ 	if $r < 80 Then
;~ 		return Random(1,80,1)
;~ 	Else
;~ 		return Random(Random(40,90,1),160,1)
;~ 	EndIf
;~ EndFunc
func graphAPI($path,$method)
	global $ohttp = ObjCreate("WinHttp.WinHttpRequest.5.1")
	$ohttp.open($method,$path,false)
	$ohttp.send()
	$ohttp.WaitForResponse()
	return $ohttp.responseText()
EndFunc