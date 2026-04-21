# ZSODATA - SAP Data Dictionary Table Definition

## How to Create the ZSODATA Structure in SE11

### Step 1: Open SE11
- Transaction Code: `SE11`
- Select: **Database Table**
- Enter name: `ZSODATA`
- Click **Create**

### Step 2: Short Description
```
TechFlow - Sales Order Data (O2C Report Structure)
```

### Step 3: Delivery Class
- Set to: **A** (Application Table - master and transaction data)

### Step 4: Data Browser / Table View Maintenance
- Set to: **Display/Maintenance Allowed**

### Step 5: Fields Definition

| Field Name | Key | Data Element | Domain | Data Type | Length | Description |
|------------|-----|-------------|--------|-----------|--------|-------------|
| MANDT      | ✅  | MANDT        | MANDT  | CLNT      | 3      | Client      |
| VBELN      | ✅  | VBELN_VA     | VBELN  | CHAR      | 10     | Sales Document Number |
| POSNR      | ✅  | POSNR_VA     | POSNR  | NUMC      | 6      | Sales Document Item |
| VBTYP      |     | VBTYP        | VBTYP  | CHAR      | 1      | SD Document Category |
| VKORG      |     | VKORG        | VKORG  | CHAR      | 4      | Sales Organization |
| VTWEG      |     | VTWEG        | VTWEG  | CHAR      | 2      | Distribution Channel |
| SPART      |     | SPART        | SPART  | CHAR      | 2      | Division |
| MATNR      |     | MATNR        | MATNR  | CHAR      | 18     | Material Number |
| CHARG      |     | CHARG_D      | CHARG  | CHAR      | 10     | Batch Number |
| ZMENG      |     | ZMENG_VA     | MENG13 | QUAN      | 13     | Target Quantity |
| ZIEME      |     | ZIEME_VA     | MEINS  | UNIT      | 3      | Unit of Measure |
| NETWR      |     | NETWR_AP     | NETWR  | CURR      | 15     | Net Value |
| WAERK      |     | WAERK        | WAERK  | CUKY      | 5      | Currency |

### Step 6: Technical Settings
- Data Class: **APPL0** (Master Data, Transparent Table)
- Size Category: **0** (< 700 entries expected)
- Buffering: **Buffering Not Allowed**

### Step 7: Activate
- Click the **Activate** button (Ctrl+F3)
- Confirm the activation dialog

### Alternative: Declare as Local Type (No SE11 Needed)
If you cannot create a DB table, declare inline in the ABAP program:

```abap
TYPES: BEGIN OF ty_sodata,
  vbeln TYPE vbak-vbeln,
  posnr TYPE vbap-posnr,
  vbtyp TYPE vbak-vbtyp,
  vkorg TYPE vbak-vkorg,
  vtweg TYPE vbak-vtweg,
  spart TYPE vbak-spart,
  matnr TYPE vbap-matnr,
  charg TYPE vbap-charg,
  zmeng TYPE vbap-zmeng,
  zieme TYPE vbap-zieme,
  netwr TYPE vbap-netwr,
  waerk TYPE vbap-waerk,
END OF ty_sodata.

DATA gt_sodata TYPE STANDARD TABLE OF ty_sodata.
```

Then change `i_structure_name = 'ZSODATA'` to use `it_fieldcatalog` parameter instead.

---

## Transaction Code Setup (SE93)
To create custom T-Code `ZSO_VIEWER` for this report:
1. Open SE93
2. Enter: `ZSO_VIEWER`
3. Select: **Program and selection screen (report transaction)**
4. Program: `ZSODATA`
5. Screen Number: `1000` (standard selection screen)
6. Save and activate
