﻿$PBExportHeader$w_set_filter.srw
$PBExportComments$Set Filter  statement
forward
global type w_set_filter from window
end type
type cb_2 from commandbutton within w_set_filter
end type
type cb_1 from commandbutton within w_set_filter
end type
type dw_3 from datawindow within w_set_filter
end type
type dw_2 from datawindow within w_set_filter
end type
type dw_1 from datawindow within w_set_filter
end type
type gb_1 from groupbox within w_set_filter
end type
type gb_2 from groupbox within w_set_filter
end type
type gb_3 from groupbox within w_set_filter
end type
end forward

global type w_set_filter from window
integer width = 3040
integer height = 1688
boolean titlebar = true
string title = "Set Filter"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 32039904
string icon = "AppIcon!"
boolean center = true
event type integer ue_getfilter ( )
cb_2 cb_2
cb_1 cb_1
dw_3 dw_3
dw_2 dw_2
dw_1 dw_1
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_set_filter w_set_filter

type variables
//====================================================================
// Declare: Instance Variables()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: (none)
//--------------------------------------------------------------------
// Returns: (none)
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

string   is_CallType
string   is_CustFilter,is_OrderFilter,is_ProductFilter

end variables

event type integer ue_getfilter();//====================================================================
// Event: ue_getfilter()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: (none)
//--------------------------------------------------------------------
// Returns: integer
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

Int   li_cnt,li_Count
String  ls_ColName,ls_Data,ls_Operator,ls_Temp

If dw_1.AcceptText() < 0 Then Return -1
li_Count = Integer(dw_1.Describe("datawindow.column.count"))
For li_cnt = 1 To li_Count
	ls_ColName = dw_1.Describe("#"+String(li_cnt)+".name")
	ls_Data = String(dw_1.Object.Data[1,li_cnt])
	ls_Data = Trim(ls_Data)
	If ls_Data = '' Or IsNull(ls_Data) Then Continue
	If is_CustFIlter = '' Then
		is_CustFIlter = " ( "+ls_ColName +" = '"+ls_Data+"' ) "
	Else
		is_CustFIlter += " AND ( "+ls_ColName +" = '"+ls_Data+"' ) "
	End If
Next

If dw_2.AcceptText() < 0 Then Return -1
ls_Operator = dw_2.GetItemString(1,'foperator')

li_Count = Integer(dw_2.Describe("datawindow.column.count"))
For li_cnt = 1 To li_Count
	ls_ColName = dw_2.Describe("#"+String(li_cnt)+".name")
	If ls_ColName = 'foperator' Then Continue
	ls_Data = String(dw_2.Object.Data[1,li_cnt])
	ls_Data = Trim(ls_Data)
	If ls_Data = '' Or IsNull(ls_Data) Then Continue
	If ls_ColName = 'famount' Then
		ls_Temp = " ( "+ls_ColName +" "+ls_Operator+" "+ls_Data+" ) "
	Else
		ls_Temp = " ( "+ls_ColName +" = '"+ls_Data+"' ) "
	End If
	If is_OrderFilter = '' Then
		is_OrderFilter = ls_Temp
	Else
		is_OrderFilter += " AND "+ls_Temp
	End If
Next

If dw_3.AcceptText() < 0 Then Return -1
ls_Operator = dw_3.GetItemString(1,'foperator')

li_Count = Integer(dw_3.Describe("datawindow.column.count"))
For li_cnt = 1 To li_Count
	ls_ColName = dw_3.Describe("#"+String(li_cnt)+".name")
	If ls_ColName = 'foperator' Then Continue
	ls_Data = String(dw_3.Object.Data[1,li_cnt])
	ls_Data = Trim(ls_Data)
	If ls_Data = '' Or IsNull(ls_Data) Then Continue
	If ls_ColName = 'funit_price' Then
		ls_Temp = " ( "+ls_ColName +" "+ls_Operator+" "+ls_Data+" ) "
	Else
		ls_Temp = " ( "+ls_ColName +" = '"+ls_Data+"' ) "
	End If
	If is_ProductFilter = '' Then
		is_ProductFilter = ls_Temp
	Else
		is_ProductFilter += " AND "+ls_Temp
	End If
Next

If is_CustFIlter = '' And is_ProductFilter = '' And is_OrderFilter = '' Then
	MessageBox('Alert','Please set the filter criteria.')
	Return -1
End If

Return 1

end event

on w_set_filter.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_1=create dw_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_3,&
this.dw_2,&
this.dw_1,&
this.gb_1,&
this.gb_2,&
this.gb_3}
end on

on w_set_filter.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event open;//====================================================================
// Event: open()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: (none)
//--------------------------------------------------------------------
// Returns: long [pbm_open]
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

is_CallType = message.stringparm
dw_1.settransobject(SQLCA)
dw_2.settransobject(SQLCA)
dw_3.settransobject(SQLCA)
dw_1.insertrow(0)
dw_2.insertrow(0)
dw_3.insertrow(0)
CHOOSE CASE lower(is_CallType)
	CASE 'w_accounts_receivable'
		dw_1.object.fpaymentdue.protect='1'
		dw_2.object.fpaid.protect='1'
END CHOOSE

end event

type cb_2 from commandbutton within w_set_filter
integer x = 2514
integer y = 248
integer width = 448
integer height = 120
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancel"
boolean cancel = true
end type

event clicked;//====================================================================
// Event: clicked()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: (none)
//--------------------------------------------------------------------
// Returns: long [pbm_bnclicked]
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

closewithreturn(parent,'cancel')
end event

type cb_1 from commandbutton within w_set_filter
integer x = 2514
integer y = 68
integer width = 448
integer height = 120
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Set"
boolean default = true
end type

event clicked;//====================================================================
// Event: clicked()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: (none)
//--------------------------------------------------------------------
// Returns: long [pbm_bnclicked]
//--------------------------------------------------------------------
// Author: 	laihaichun		Date: 2003/12/31
//--------------------------------------------------------------------
// Modify History: 
//	
//--------------------------------------------------------------------
// CopyRight 2003----???? Appeon Inc.
//====================================================================

If Parent.Event ue_getfilter() < 0 Then Return
Choose Case Lower(is_CallType)
	Case 'w_accounts_receivable'
		w_accounts_receivable.Post Event ue_setfilter(is_CustFilter,is_OrderFilter,is_ProductFilter)
	Case 'w_customer_maintenance'
		w_customer_maintenance.Post Event ue_setfilter(is_CustFilter,is_OrderFilter,is_ProductFilter)
	Case 'w_customer_select'
		w_customer_select.Post Event ue_setfilter(is_CustFilter,is_OrderFilter,is_ProductFilter)
	Case 'w_ship_order'
		w_ship_order.Post Event ue_setfilter(is_CustFilter,is_OrderFilter,is_ProductFilter)
	Case 'w_processing_order'
		w_processing_order.Post Event ue_setfilter(is_CustFilter,is_OrderFilter,is_ProductFilter)
	Case 'w_order_main'
		w_order_main.Post Event ue_setfilter(is_CustFilter,is_OrderFilter,is_ProductFilter)
End Choose

CLOSE(Parent)

end event

type dw_3 from datawindow within w_set_filter
integer x = 87
integer y = 1228
integer width = 2309
integer height = 280
integer taborder = 30
string title = "none"
string dataobject = "d_product_filter"
boolean border = false
boolean livescroll = true
end type

type dw_2 from datawindow within w_set_filter
integer x = 87
integer y = 720
integer width = 2309
integer height = 380
integer taborder = 20
string title = "none"
string dataobject = "d_order_filter"
boolean border = false
boolean livescroll = true
end type

type dw_1 from datawindow within w_set_filter
integer x = 87
integer y = 108
integer width = 2309
integer height = 516
integer taborder = 10
string title = "none"
string dataobject = "d_cust_filter"
boolean border = false
boolean livescroll = true
end type

type gb_1 from groupbox within w_set_filter
integer x = 41
integer y = 32
integer width = 2400
integer height = 608
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 32039904
string text = "Customer"
end type

type gb_2 from groupbox within w_set_filter
integer x = 41
integer y = 648
integer width = 2400
integer height = 492
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 32039904
string text = "Order"
end type

type gb_3 from groupbox within w_set_filter
integer x = 41
integer y = 1160
integer width = 2400
integer height = 380
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 32039904
string text = "Product"
end type

