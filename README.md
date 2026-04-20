SAP SD — Order-to-Cash (O2C) End-to-End Capstone Project
<div align="center">
![SAP](https://img.shields.io/badge/SAP-SD%20Module-0070F2?style=for-the-badge&logo=sap&logoColor=white)
![ABAP](https://img.shields.io/badge/ABAP-Custom%20Report-FF6600?style=for-the-badge)
![SAP FI](https://img.shields.io/badge/SAP-FI%20Integration-00A86B?style=for-the-badge)
![SPRO](https://img.shields.io/badge/SPRO-Configuration-DC143C?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen?style=for-the-badge)
KIIT SAP Capstone Project | April 2026
A complete, production-grade SAP SD Order-to-Cash implementation for a fictional Indian consumer electronics company
</div>
---


Table of Contents
Overview
Company Profile
O2C Process Flow
Repository Structure
Organizational Setup
Master Data
7-Step O2C Execution
SPRO Configuration
ABAP Report
Pricing Calculation
FI Accounting Entries
Transaction Code Reference
Screenshots
Future Enhancements
Author
---


Overview
This project demonstrates a complete, end-to-end Order-to-Cash (O2C) business process in SAP SD (Sales & Distribution) for TechFlow Solutions Pvt. Ltd., a fictional Indian consumer electronics manufacturer.
The O2C cycle is the revenue engine of any enterprise - it covers every step from the moment a customer expresses interest in buying a product, all the way to the moment payment is received and financial books are closed. This project implements all 7 stages with:
Real SAP transaction codes and screen-by-screen guidance
Complete master data (Customer, Material, Pricing)
SPRO customization steps with exact IMG paths
Cross-module FI integration (accounting entries at PGI and Billing)
Custom ABAP ALV report joining VBAK + VBAP tables
India-specific: GST 18%, INR currency, NEFT payment, Net 30 terms
---


Company Profile
Field	Detail
Company Name	TechFlow Solutions Pvt. Ltd.
Industry	Consumer Electronics - B2B Manufacturing & Sales
HQ Location	Sector 62, Noida, Uttar Pradesh – 201309
Company Code	TFSOL
Sales Organization	TF01 - North India
Distribution Channel	10 - Direct B2B Sales
Division	01 - Consumer Electronics
Sales Area	TF01 / 10 / 01
Manufacturing Plant	TF10 - Noida
Shipping Point	SP01 - Noida Dispatch Dock
Customer	RetailMart India Ltd. (CUST-1001)
Product	TechFlow ProBook 14 Laptop (TF-LAP-001)
Currency	INR (Indian Rupee)
---


O2C Process Flow
```
╔══════════════════════════════════════════════════════════════════╗
║              TechFlow Solutions — O2C Process Flow               ║
╚══════════════════════════════════════════════════════════════════╝

    [CUSTOMER: RetailMart India Ltd.]
              │
              │  "We need 50 ProBook 14 Laptops"
              ▼
    ┌─────────────────────┐
    │  1. INQUIRY (VA11)  │  ◄── Non-binding request logged
    │     Type: IN        │      INQ: 10000001
    └────────┬────────────┘
             │ Sales team reviews & prepares offer
             ▼
    ┌─────────────────────┐
    │ 2. QUOTATION (VA21) │  ◄── Formal offer with validity 30 days
    │     Type: QT        │      QT: 20000001 | INR 45,000/unit
    └────────┬────────────┘
             │ Customer accepts → places order
             ▼
    ┌──────────────────────┐
    │ 3. SALES ORDER (VA01)│  ◄── Legal commitment, 10 units
    │     Type: OR         │      SO: 30000001 | INR 4,32,500
    └────────┬─────────────┘
             │ Warehouse picks & packs
             ▼
    ┌───────────────────────────┐
    │ 4. DELIVERY (VL01N)       │  ◄── Physical dispatch initiated
    │    Type: LF               │      DEL: 80000001
    └────────┬──────────────────┘
             │
             ▼
    ┌───────────────────────────┐
    │ 5. GOODS ISSUE (VL02N)    │  ◄── Stock reduced, COGS posted
    │    PGI Posted             │      Material Doc + FI Doc created
    └────────┬──────────────────┘
             │ Goods delivered to RetailMart Delhi
             ▼
    ┌───────────────────────────┐
    │ 6. BILLING / INVOICE(VF01)│  ◄── INR 5,10,350 invoice raised
    │    Type: F2               │      INV: 90000001 | Due: 25-May
    └────────┬──────────────────┘
             │ RetailMart pays via NEFT on 20-May
             ▼
    ┌───────────────────────────┐
    │ 7. PAYMENT + CLEAR (F-28) │  ◄── INR 5,10,350 received & cleared
    │    FBL5N: Status = CLEARED│      O2C Cycle COMPLETE 
    └───────────────────────────┘
```
---


Repository Structure
```
SAP-O2C-Capstone/
│
├── README.md                          ← You are here (full project overview)
│
├── docs/
│   ├── SAP_O2C_Project_Report.docx   ← 5-page formal project report (Word)
│   ├── SAP_O2C_Project_Report.pdf    ← PDF version for submission
│   └── Master_Data_Reference.md      ← All master data, pricing, accounting
│
├── abap/
│   ├── ZSODATA_report.abap           ← Full ABAP source code (ALV Report)
│   └── ZSODATA_table_definition.md   ← SE11 data dictionary steps
│
├── config/
│   └── SPRO_Configuration.md         ← All IMG configuration steps
│
└── screenshots/
    ├── SCREENSHOTS_GUIDE.md          ← What each screenshot should show
    ├── 01_sap_easy_access_menu.png
    ├── 02_inquiry_va11.png
    ├── 03_quotation_va23.png
    ├── 04_sales_order_va03.png
    ├── 05_document_flow.png
    ├── 06_so_conditions.png
    ├── 07_delivery_vl01n.png
    ├── 08_post_goods_issue.png
    ├── 09_billing_vf01.png
    ├── 10_billing_accounting.png
    ├── 11_payment_f28.png
    ├── 12_cleared_fbl5n.png
    ├── 13_spro_config.png
    └── 14_abap_alv_zsodata.png
```
---


Organizational Setup
```
                    TechFlow Solutions Pvt. Ltd.
                       [Company Code: TFSOL]
                               │
                   ┌───────────┴───────────┐
            Sales Org: TF01          Company Code: TFSOL
           (North India Sales)       (Financial Entity)
                   │
         ┌─────────┴─────────┐
    Dist. Channel: 10      Division: 01
     (Direct B2B)       (Consumer Electronics)
         │
    Sales Area: TF01/10/01
         │
    ┌────┴────┐
  Plant: TF10  Shipping Point: SP01
  (Noida)      (Noida Dock)
         │
  Storage Loc: SL01
  (Finished Goods WH)
```
---


Master Data
Customer - CUST-1001 (RetailMart India Ltd.)
Field	Value
Account Group	0001 (Sold-To Party)
Address	12, Connaught Place, New Delhi – 110001
GSTIN	07AABCR1234F1Z5
Payment Terms	ZN30 - Net 30 Days
Incoterms	CIF (Cost Insurance Freight)
Currency	INR
Credit Limit (FD32)	INR 25,00,000
Reconciliation A/c	140000 (Accounts Receivable)
Material - TF-LAP-001 (TechFlow ProBook 14 Laptop)
Field	Value
Material Type	FERT (Finished Product)
Base Unit	EA (Each)
Division	01 - Consumer Electronics
Delivering Plant	TF10 (Noida)
Gross Weight	2.5 KG
HSN Code	8471 (Laptops)
Availability Check	02 (Individual Requirements)
---


7-Step O2C Execution
Step 1 - Inquiry (VA11)
> *"RetailMart wants to know pricing for 50 ProBook 14 laptops"*
T-Code: VA11 | Type: IN
Key Fields: Sales Area TF01/10/01, Customer CUST-1001, Material TF-LAP-001, Qty 50
Output: Inquiry document INQ-10000001
Business Purpose: Log customer interest without any legal commitment
Step 2 - Quotation (VA21)
> *"TechFlow formally offers the product at INR 45,000/unit, valid 30 days"*
T-Code: VA21 | Type: QT | Ref: INQ-10000001
Validity: 18-Apr-2026 to 18-May-2026
Output: Quotation QT-20000001 | Expected value: INR 21,37,500
Business Purpose: Legally binding offer communicated to customer
Step 3 - Sales Order (VA01)
> *"RetailMart accepts and orders 10 units initially"*
T-Code: VA01 | Type: OR | Ref: QT-20000001
Customer PO: PO-RM-2026-0041
Output: SO-30000001 | Net Value: INR 4,32,500
Business Purpose: Legal purchase agreement — triggers all downstream steps
Step 4 - Delivery (VL01N)
> *"Warehouse picks 10 laptops and prepares for dispatch"*
T-Code: VL01N | Shipping Point: SP01 | Ref: SO-30000001
Output: DEL-80000001 | Picking confirmed at SL01
Business Purpose: Authorize and plan physical goods movement
Step 5 - Post Goods Issue (VL02N)
> *"Goods dispatched - inventory reduced, cost recognized"*
T-Code: VL02N → Post Goods Issue button
Effect: Stock - 10 EA | Dr COGS 2,50,000 | Cr Inventory 2,50,000
Business Purpose: Transfer ownership and recognize cost of goods sold
Step 6 - Billing / Invoice (VF01)
> *"TechFlow sends GST-compliant invoice to RetailMart"*
T-Code: VF01 | Type: F2 | Ref: DEL-80000001
Output: INV-90000001 | Total: INR 5,10,350 | Due: 25-May-2026
FI Entry: Dr AR 5,10,350 | Cr Revenue 4,32,500 | Cr GST 77,850
Step 7 - Payment & Clearing (F-28)
> *"RetailMart pays via NEFT on 20-May - cycle complete"*
T-Code: F-28 | Amount: INR 5,10,350
Verify: FBL5N → Status: CLEARED 
FI Entry: Dr Bank 5,10,350 | Cr AR 5,10,350
---


SPRO Configuration
> See [`config/SPRO_Configuration.md`](config/SPRO_Configuration.md) for full details
Key configuration areas:
Area	Path	Action
Company Code	SPRO > Enterprise Structure > Definition > FI	Create TFSOL
Sales Org	SPRO > Enterprise Structure > Definition > SD	Create TF01
Assignments	SPRO > Enterprise Structure > Assignment > SD	Link all units
Pricing Procedure	SPRO > SD > Basic Functions > Pricing	Create ZTFPR1
Output (Invoice)	SPRO > SD > Basic Functions > Output Control	RD00 condition
Copy Control	SPRO > SD > Sales > Copy Control (VTFL)	LF → F2
Shipping Point	SPRO > LE > Shipping > Shipping Point Determination	SP01 rule
---

ABAP Report: ZSODATA
Custom ABAP report that queries Sales Order data and displays in an interactive ALV grid.
Key Logic
```abap
SELECT a~vbeln, b~posnr, a~vkorg, a~vtweg, a~spart,
       b~matnr, b~charg, b~zmeng, b~zieme, b~netwr, b~waerk
    UP TO 100 ROWS
  INTO TABLE @gt_sodata
  FROM vbak AS a
 INNER JOIN vbap AS b ON b~vbeln EQ a~vbeln.
```

Features
Zebra-striped rows (`gs_layout-zebra = abap_true`)
Auto column width optimization (`cwidth_opt = abap_true`)
Custom screen 100 with container `SOLIST`
PF-Status with BACK/EXIT/CANCEL handling
Passes function codes to ALV for built-in toolbar (sort, filter, export)
How to Run
Open `SE38` in SAP GUI
Create program `ZSODATA`, paste code from `abap/ZSODATA_report.abap`
Activate (Ctrl+F3)
Execute (F8) or create T-Code `ZSO_VIEWER` via SE93
> See [`abap/ZSODATA_table_definition.md`](abap/ZSODATA_table_definition.md) for SE11 table creation steps
---


Pricing Calculation
```
Product  : TechFlow ProBook 14 Laptop (TF-LAP-001)
Customer : RetailMart India Ltd. (CUST-1001)
Quantity : 10 EA
Procedure: ZTFPR1

╔══════════════════════════════════════════════════════════════╗
║  Condition  │  Description          │         Amount        ║
╠══════════════════════════════════════════════════════════════╣
║  PR00       │  Base Price           │  INR 45,000 × 10      ║
║             │                       │       = 4,50,000.00   ║
║  K007       │  Customer Discount 5% │         -22,500.00    ║
║  KF00       │  Freight Surcharge    │  INR 500 × 10         ║
║             │                       │         + 5,000.00    ║
║─────────────┼───────────────────────┼───────────────────────║
║             │  Net Value (pre-tax)  │       4,32,500.00     ║
║  MWST       │  GST @ 18%            │         +77,850.00    ║
║─────────────┼───────────────────────┼───────────────────────║
║             │  TOTAL INVOICE VALUE  │  ▶ INR 5,10,350.00 ◀  ║
╚══════════════════════════════════════════════════════════════╝
Payment Due: 25-May-2026 (Net 30 Days from invoice date)
```
---


FI Accounting Entries
At Post Goods Issue
Account	Description	Debit	Credit
500000	Cost of Goods Sold	2,50,000	-
300000	Finished Goods Inventory	-	2,50,000
At Billing (Invoice Creation)
Account	Description	Debit	Credit
140000	Accounts Receivable	5,10,350	-
800000	Revenue - Electronics	-	4,32,500
175000	GST Output Tax Payable	-	77,850
At Payment Receipt
Account	Description	Debit	Credit
113100	Bank - HDFC Account	5,10,350	-
140000	Accounts Receivable	-	5,10,350
---


Transaction Code Reference
T-Code	Description	Stage
`VA11`	Create Inquiry	Step 1
`VA21`	Create Quotation	Step 2
`VA01`	Create Sales Order	Step 3
`VL01N`	Create Outbound Delivery	Step 4
`VL02N`	Post Goods Issue	Step 5
`VF01`	Create Billing Document	Step 6
`F-28`	Incoming Customer Payment	Step 7
`FBL5N`	Customer Line Items (verify clear)	Verify
`XD01`	Create Customer Master	Master Data
`MM01`	Create Material Master	Master Data
`VK11`	Create Pricing Condition Records	Master Data
`SPRO`	SAP Implementation Guide	Config
`SE38`	ABAP Editor	Development
`SE11`	Data Dictionary	Development
`SE93`	Create Transaction Code	Development
`VA05`	List of Sales Orders	Reporting
`VF05`	List of Billing Documents	Reporting
`MB52`	Warehouse Stock Overview	Verification
`FD32`	Customer Credit Management	Credit
---


Screenshots
> Screenshots in `/screenshots/` folder illustrate key stages of the Order-to-Cash (O2C) process including sales order creation, delivery, goods issue, and billing.

| # | Screenshot | Transaction |
|---|-----------|-------------|
| 01 | Sales Order Creation | VA01 |
| 02 | Pricing Conditions | VA01 / VA03 |
| 03 | Sales Order Overview | VA03 |
| 04 | Delivery Creation | VL01N |
| 05 | Delivery Overview | VL01N |
| 06 | Change Delivery | VL02N |
| 07 | Post Goods Issue | VL02N |
| 08 | Billing Creation | VF01 |
| 09 | Billing Overview | VF03 |
---


Future Enhancements
[ ] Credit Management (FD32): Auto-block orders exceeding customer credit limit
[ ] Returns Processing: RE order type → Return Delivery → Credit Memo cycle
[ ] Batch Management: Track production batch numbers for warranty/recall
[ ] S/4HANA Migration: Business Partner (BP) model, Universal Journal
[ ] SAP Fiori Apps: F0842 (Create SO), F0844 (Track SO) for mobile UI
[ ] Intercompany Sales: Cross-company code billing for multi-entity setup
[ ] EDI Integration: Automatic Sales Order creation from customer EDI/XML
---


What Makes This Project Stand Out
Full cross-module integration - SD triggers FI accounting entries automatically, demonstrating real enterprise system value
India-specific compliance - GST 18%, HSN codes, NEFT payment, GSTIN on customer master
Condition technique mastery - PR00, K007, KF00, MWST in pricing procedure ZTFPR1
ABAP technical depth - Custom ALV report bridging functional SD and technical development
End-to-end traceability - Document flow from Inquiry → Payment Clearing is fully documented
---


Author
Field	Details
Name	[Your Full Name]
Roll No.	[Your Roll Number]
Batch / Program	[e.g., SAP SD — 2025-26]
Institution	KIIT
Submission	April 21, 2026
Module	SAP SD (Sales & Distribution)
Process	Order-to-Cash (O2C)
---


License
This project is created for academic purposes at KIIT. All company names, customer names, and business data are entirely fictional and used for educational demonstration only.
---
<div align="center">
"Order-to-Cash is not just a transaction process — it is how an enterprise converts customer trust into recognized revenue."
⭐ If this project helped you, please star the repository!
</div>
