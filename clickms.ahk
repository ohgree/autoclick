#NoEnv
#Persistent
#SingleInstance Force
SetBatchLines -1

Gui, Add, Text, x30 y35 w70 h20 , StartTime:
Gui, Add, DateTime, x+5 y30 wp hp vStartTime 1, HH:mm:ss ;time
Gui, Add, Button, x10 y70 w60 h20 Default, OK
Gui, Show, w220 h100, All-Clear!
Return

ButtonOK:
Gui, submit, nohide
FormatTime, StartTime, %StartTime%, HH:mm:ss
time_array := StrSplit(StartTime, ":")
target := toMs(time_array[1], time_array[2], time_array[3], 000)
InputBox, in_offset, Enter offset, , , 200, 100

OFFSET := -350 ; -160 is best, -150 is safe

if in_offset
	OFFSET := in_offset

TARGET_TIME := target
;TARGET_TIME := toMs(07, 03, 00, 000) ; change this
TARGET_TIME := TARGET_TIME + OFFSET
NOW := toMs(A_Hour, A_Min, A_Sec, A_MSec)
MIDNIGHT := toMs(24, 00, 00, 000)

;if (NOW < TARGET_TIME)
waitTime := TARGET_TIME - NOW
;else
;waitTime := (MIDNIGHT - NOW) + TARGET_TIME ; calc ms left till midnight + ms left till TARGET_TIME the next day

SetTimer WaitTimer_Once, % -waitTime ; initial run

MsgBox % "Set timer at " StartTime " with offset " OFFSET "ms"
return

GuiClose:
	ExitApp


WaitTimer_Once() {
	Click
}
/*
ButtonOK:
Gui,Submit
FormatTime, date, %date%, dddd dd/MM/yy
SendInput, %date%
return
*/
/*
MsgBox % target

OFFSET := -160 ; -160 is best, -150 is safe
TARGET_TIME := toMs(07, 03, 00, 000) ; change this
TARGET_TIME := TARGET_TIME + OFFSET
NOW := toMs(A_Hour, A_Min, A_Sec, A_MSec)
MIDNIGHT := toMs(24, 00, 00, 000)

if (NOW < TARGET_TIME)
waitTime := TARGET_TIME - NOW
else
waitTime := (MIDNIGHT - NOW) + TARGET_TIME ; calc ms left till midnight + ms left till TARGET_TIME the next day

SetTimer WaitTimer, % -waitTime ; initial run

WaitTimer() {
	static 24_HOURS := toMs(24, 00, 00, 000)

	Click

	SetTimer, , % -24_HOURS 
}
*/
getOffset() {

	InputBox, offset, Offset, Your offset?
	return offset
	/*
	Gui, Add, Text,, Your offset:
	Gui, Add, Edit, vName
	Gui, Add, Button, , OK
	Gui, Add, Button, , END
	Gui, Show, , Offset
	Gui, Show
	Return
	*/
/*
	ButtonOK:
	Gui, Submit
	MsgBox, Hello %Name%
	Gui, Show
	return
	*/
}

toMs(hh := 0, mm := 0, ss := 0, ms := 0) {
	return hh * 3600000 + mm * 60000 + ss * 1000 + ms
}