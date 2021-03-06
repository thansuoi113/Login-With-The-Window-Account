$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type st_3 from statictext within w_main
end type
type st_2 from statictext within w_main
end type
type st_1 from statictext within w_main
end type
type sle_password from singlelineedit within w_main
end type
type sle_user from singlelineedit within w_main
end type
type cb_2 from commandbutton within w_main
end type
type cb_1 from commandbutton within w_main
end type
end forward

global type w_main from window
integer width = 1806
integer height = 948
boolean titlebar = true
string title = "Login With Window Account"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_3 st_3
st_2 st_2
st_1 st_1
sle_password sle_password
sle_user sle_user
cb_2 cb_2
cb_1 cb_1
end type
global w_main w_main

type prototypes
Function ULong WNetGetUser(String lpname, Ref String lpusername, Ref ULong buflen) Library "mpr.dll" Alias For "WNetGetUserW"
Function Boolean LogonUser ( String lpszUsername, String lpszDomain, String lpszPassword, ULong dwLogonType, ULong dwLogonProvider, Ref ULong phToken) Library "advapi32.dll" Alias For "LogonUserW"
Function Boolean CloseHandle (ULong hObject) Library "kernel32.dll"
Function Boolean GetUserNameA(Ref String uname, Ref ULong slength) Library "ADVAPI32.DLL" Alias For "GetUserNameA;Ansi"

end prototypes
type variables

end variables

on w_main.create
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.sle_password=create sle_password
this.sle_user=create sle_user
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.st_3,&
this.st_2,&
this.st_1,&
this.sle_password,&
this.sle_user,&
this.cb_2,&
this.cb_1}
end on

on w_main.destroy
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_password)
destroy(this.sle_user)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;/*
ULong lu_val
Boolean lb_rtn
lu_val = 255
String ls_username = Space( 255 )

lb_rtn = GetUserNameA(ls_username, lu_val)
sle_user.Text = ls_username
*/
end event

type st_3 from statictext within w_main
integer x = 5
integer y = 60
integer width = 1769
integer height = 152
integer textsize = -18
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Login With Window Account"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_main
integer x = 69
integer y = 488
integer width = 411
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Password:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_main
integer x = 69
integer y = 320
integer width = 411
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "User:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_password from singlelineedit within w_main
integer x = 507
integer y = 476
integer width = 1079
integer height = 100
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "TEST1"
boolean password = true
borderstyle borderstyle = stylelowered!
end type

type sle_user from singlelineedit within w_main
integer x = 507
integer y = 308
integer width = 1079
integer height = 100
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "TEST"
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_main
integer x = 1225
integer y = 656
integer width = 357
integer height = 116
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Close"
end type

event clicked;Close(parent)
end event

type cb_1 from commandbutton within w_main
integer x = 521
integer y = 656
integer width = 357
integer height = 116
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Login"
end type

event clicked;

Constant ULong LOGON32_LOGON_NETWORK = 3
Constant ULong LOGON32_PROVIDER_DEFAULT = 0
String ls_domain, ls_user, ls_password
ULong lul_token
Boolean lbl_result

//Sets And Gets values
ls_domain = ""
ls_user = Trim(sle_user.Text)
ls_password = Trim(sle_password.Text)

//Error User checking
If (IsNull(ls_user) Or ls_user = "") Then
	MessageBox("Warning", "You must enter a User ID.", StopSign!)
	sle_user.SetFocus()
	Return
End If

//Error Password checking
If (IsNull(ls_password) Or ls_password = "") Then
	MessageBox("Warning", "You must enter a Password.", StopSign!)
	sle_password.SetFocus()
	Return
End If

//Determines is the User ID And Password are valid
lbl_result = LogonUser( ls_user, ls_domain, ls_password, LOGON32_LOGON_NETWORK, LOGON32_PROVIDER_DEFAULT, lul_token )

//Valid
If (lbl_result) Then
	//Close Handle of Token
	CloseHandle(lul_token)
	MessageBox("Warning", "Login Success")
Else
	CloseHandle(lul_token)
	//Error Message
	MessageBox("Warning", "Invalid User ID or Password.", StopSign!)
End If


end event

