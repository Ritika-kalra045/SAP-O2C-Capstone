*&---------------------------------------------------------------------*
*& Report  : ZSODATA
*& Title   : Sales Order ALV Report - O2C Data Viewer
*& Author  : Ritika Kalra | 3rd Year(B.Tech(CSE) | Roll No.: 23053294 | KIIT SAP Capstone Project | Batch: 2023-2027
*& Company : TechFlow Solutions Pvt. Ltd. (Fictional)
*& Date    : April 2026
*& Desc    : Displays Sales Order Header + Item data in an interactive
*&           ALV Grid using CL_GUI_ALV_GRID on custom Screen 100.
*&           Joins VBAK (Header) and VBAP (Item) up to 100 rows.
*&---------------------------------------------------------------------*
REPORT zsodata.

*----------------------------------------------------------------------*
* DATA DECLARATIONS
*----------------------------------------------------------------------*
DATA: gt_sodata   TYPE STANDARD TABLE OF zsodata,  " Internal table
      gs_sodata   TYPE zsodata,                     " Work area
      o_container TYPE REF TO cl_gui_custom_container,
      o_grid      TYPE REF TO cl_gui_alv_grid,
      gs_layout   TYPE lvc_s_layo.

*----------------------------------------------------------------------*
* SELECTION SCREEN
*----------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: s_vkorg FOR gs_sodata-vkorg,  " Sales Organization
                  s_vtweg FOR gs_sodata-vtweg,  " Distribution Channel
                  s_spart FOR gs_sodata-spart.  " Division
SELECTION-SCREEN END OF BLOCK b1.

*----------------------------------------------------------------------*
* START-OF-SELECTION
*----------------------------------------------------------------------*
START-OF-SELECTION.

  " Fetch data from VBAK (Header) INNER JOIN VBAP (Item)
  SELECT a~vbeln,   " Sales Document Number
         b~posnr,   " Item Number
         a~vbtyp,   " Document Category (C = Sales Order)
         a~vkorg,   " Sales Organization
         a~vtweg,   " Distribution Channel
         a~spart,   " Division
         b~matnr,   " Material Number
         b~charg,   " Batch Number
         b~zmeng,   " Target Quantity
         b~zieme,   " Unit of Measure
         b~netwr,   " Net Value
         b~waerk    " Currency
      UP TO 100 ROWS
    INTO TABLE @gt_sodata
    FROM vbak AS a
   INNER JOIN vbap AS b
      ON b~vbeln EQ a~vbeln
   WHERE a~vkorg IN @s_vkorg
     AND a~vtweg IN @s_vtweg
     AND a~spart IN @s_spart.

  " Set ALV Layout properties
  gs_layout-zebra     = abap_true.   " Alternating row colors
  gs_layout-cwidth_opt = abap_true.  " Auto-optimize column widths
  gs_layout-grid_title = 'TechFlow Solutions – Sales Order Report (O2C Viewer)'.

  " Call Screen 100 which hosts the ALV container
  CALL SCREEN 100.

*----------------------------------------------------------------------*
* SCREEN 100 - PBO (Process Before Output)
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'SOLST'.          " Set custom menu/toolbar
  SET TITLEBAR  'SOL'.            " Set window title

  " Create container only once
  IF o_container IS INITIAL.

    CREATE OBJECT o_container
      EXPORTING
        container_name = 'SOLIST'   " Must match container name in Screen Painter
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        OTHERS                      = 6.
    IF sy-subrc <> 0.
      MESSAGE 'Error creating container' TYPE 'E'.
    ENDIF.

    CREATE OBJECT o_grid
      EXPORTING
        i_parent = o_container
      EXCEPTIONS
        error_cntl_create = 1
        error_cntl_init   = 2
        error_cntl_link   = 3
        error_dp_create   = 4
        OTHERS            = 5.
    IF sy-subrc <> 0.
      MESSAGE 'Error creating ALV Grid' TYPE 'E'.
    ENDIF.

    " Bind data to grid
    CALL METHOD o_grid->set_table_for_first_display
      EXPORTING
        i_structure_name = 'ZSODATA'   " Data dictionary structure
        is_layout        = gs_layout
      CHANGING
        it_outtab        = gt_sodata
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        OTHERS                        = 4.
    IF sy-subrc <> 0.
      MESSAGE 'Error displaying ALV Grid' TYPE 'E'.
    ENDIF.

  ENDIF.

ENDMODULE.

*----------------------------------------------------------------------*
* SCREEN 100 - PAI (Process After Input)
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE sy-ucomm.
    WHEN 'BACK' OR 'EXIT' OR 'CANC'.
      " Destroy objects to free memory
      IF o_grid IS NOT INITIAL.
        CALL METHOD o_grid->free.
        FREE o_grid.
      ENDIF.
      IF o_container IS NOT INITIAL.
        CALL METHOD o_container->free.
        FREE o_container.
      ENDIF.
      SET SCREEN 0.
      LEAVE SCREEN.
    WHEN OTHERS.
      " Pass function code to ALV for toolbar handling (sort, filter, etc.)
      CALL METHOD cl_gui_cfw=>dispatch.
  ENDCASE.

ENDMODULE.
