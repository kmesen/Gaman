﻿$PBExportHeader$w_rpt_category_summary.srw
$PBExportComments$Product Category
forward
global type w_rpt_category_summary from w_rpt_main
end type
end forward

global type w_rpt_category_summary from w_rpt_main
integer height = 1996
string title = "Sales Report by Product Category"
string menuname = ""
end type
global w_rpt_category_summary w_rpt_category_summary

type variables

end variables

on w_rpt_category_summary.create
int iCurrent
call super::create
end on

on w_rpt_category_summary.destroy
call super::destroy
end on

event ue_retrieve;//====================================================================
// Event: ue_retrieve()
//--------------------------------------------------------------------
// Description: 
//--------------------------------------------------------------------
// Arguments: 
//		None		
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

string  ls_DataObject

CHOOSE CASE is_reportstyle 
	CASE '2d pie'
		ls_dataobject = 'd_rep_category_summary_2dpie'
	CASE '2d line'
		ls_dataobject = 'd_rep_category_summary_2dline'
	CASE '3d column'
		ls_dataobject = 'd_rep_category_summary_3dcol'
	CASE 'grid data'
		ls_dataobject = 'd_rep_category_summary_grid'
END CHOOSE
IF dw_1.dataobject <>ls_dataobject THEN
	dw_1.dataobject = ls_DataOBject
	dw_1.settransobject(SQLCA)
END IF

super::event ue_retrieve()

end event

event ue_setinterface;call super::ue_setinterface;//====================================================================
// Event: ue_setinterface()
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

int  li_Cnt,li_Count
string  ls_Name

IF dw_1.describe("datawindow.processing") <>'1' THEN return -1
dw_1.modify("t_1.color="+string(il_TextColor))
dw_1.modify("compute_1.color="+string(il_TextColor))
dw_1.modify("compute_2.color="+string(il_TextColor))
dw_1.modify("t_2.color="+string(il_TextColor))


return 1
end event

type ddlb_style from w_rpt_main`ddlb_style within w_rpt_category_summary
end type

type uo_1 from w_rpt_main`uo_1 within w_rpt_category_summary
end type

type cb_close from w_rpt_main`cb_close within w_rpt_category_summary
boolean visible = false
end type

type cb_saveas from w_rpt_main`cb_saveas within w_rpt_category_summary
end type

type cb_print from w_rpt_main`cb_print within w_rpt_category_summary
boolean visible = false
end type

type dw_1 from w_rpt_main`dw_1 within w_rpt_category_summary
string dataobject = "d_rep_category_summary_2dpie"
end type

type gb_1 from w_rpt_main`gb_1 within w_rpt_category_summary
end type

type cb_1 from w_rpt_main`cb_1 within w_rpt_category_summary
end type

