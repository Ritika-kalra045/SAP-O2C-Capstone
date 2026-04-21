# SAP SD – Order-to-Cash (O2C) End-to-End Capstone Project
<div align="center">
![SAP](https://img.shields.io/badge/SAP-SD%20Module-0070F2?style=for-the-badge\&logo=sap\&logoColor=white)
![ABAP](https://img.shields.io/badge/ABAP-Custom%20Report-FF6600?style=for-the-badge)
![SAP FI](https://img.shields.io/badge/SAP-FI%20Integration-00A86B?style=for-the-badge)
![SPRO](https://img.shields.io/badge/SPRO-Configuration-DC143C?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen?style=for-the-badge)
**KIIT SAP Capstone Project | April 2026**
A complete, production-grade SAP SD Order-to-Cash implementation for a fictional Indian consumer electronics company.
</div>
---
## Table of Contents
* Overview
* Company Profile
* O2C Process Flow
* Repository Structure
* Organizational Setup
* Master Data
* 7-Step O2C Execution
* SPRO Configuration
* ABAP Report
* Pricing Calculation
* FI Accounting Entries
* Transaction Code Reference
* Screenshots
* Diagrams
* Future Enhancements
* Author
* License
---
## Overview
This project demonstrates a **complete end-to-end Order-to-Cash (O2C)** process in SAP SD for **TechFlow Solutions Pvt. Ltd.**, a fictional Indian electronics company.
The O2C cycle represents the **core revenue engine** of any enterprise — from customer inquiry to payment realization.
### ✔ Key Highlights
* Real SAP T-Codes with step-by-step execution
* Complete master data (Customer, Material, Pricing)
* SPRO configuration with exact IMG paths
* FI integration (PGI + Billing accounting entries)
* Custom ABAP ALV report (VBAK + VBAP)
* India-specific setup (GST, INR, NEFT, Net 30)
---
## Company Profile
| Field                | Detail                       |
| -------------------- | ---------------------------- |
| Company Name         | TechFlow Solutions Pvt. Ltd. |
| Industry             | Consumer Electronics (B2B)   |
| Location             | Noida, India                 |
| Company Code         | TFSOL                        |
| Sales Org            | TF01                         |
| Distribution Channel | 10 (Direct B2B)              |
| Division             | 01                           |
| Plant                | TF10                         |
| Shipping Point       | SP01                         |
| Customer             | RetailMart India Ltd.        |
| Product              | ProBook 14 Laptop            |
| Currency             | INR                          |
---
## O2C Process Flow
```
Inquiry → Quotation → Sales Order → Delivery → PGI → Billing → Payment
```
✔ Fully integrated document flow
✔ Covers logistics + finance lifecycle
---
## Repository Structure
```
SAP-O2C-Capstone/
│
├── README.md
├── docs/
├── abap/
├── config/
└── screenshots/
```
---
## Organizational Setup
```
Company Code (TFSOL)
   │
   Sales Org (TF01)
      │
      Dist Channel (10) — Division (01)
         │
         Sales Area (TF01/10/01)
            │
            Plant (TF10) — Shipping Point (SP01)
            ```
            ---
## Master Data
### Customer
| Field         | Value                 |
| ------------- | --------------------- |
| Customer      | CUST-1001             |
| Name          | RetailMart India Ltd. |
| Payment Terms | Net 30                |
| Currency      | INR                   |
| Credit Limit  | ₹25,00,000            |
### Material
| Field    | Value      |
| -------- | ---------- |
| Material | TF-LAP-001 |
| Type     | FERT       |
| Unit     | EA         |
| Plant    | TF10       |
| HSN      | 8471       |
---
## 7-Step O2C Execution
### 1. Inquiry (VA11)
* Non-binding request
* Qty: 50
### 2. Quotation (VA21)
* Price: ₹45,000/unit
* Validity: 30 days
### 3. Sales Order (VA01)
* Qty: 10
* Value: ₹4,32,500
### 4. Delivery (VL01N)
* Picking + packing
### 5. Post Goods Issue (VL02N)
* Stock ↓
* COGS posted
### 6. Billing (VF01)
* Invoice: ₹5,10,350
### 7. Payment (F-28)
* NEFT received
* Cleared in FBL5N
---
## SPRO Configuration
Key areas:
* Enterprise Structure setup
* Sales Org creation
* Pricing Procedure (ZTFPR1)
* Output determination
* Copy control (VTFL)
* Shipping point determination
 See: `config/SPRO_Configuration.md`
---
## ABAP Report – ZSODATA
Custom ALV report combining **VBAK + VBAP**
### Features
* ALV Grid display
* Zebra layout
* Auto column width
* Interactive toolbar
### Sample Logic
```abap
SELECT a~vbeln, b~posnr, a~vkorg
FROM vbak AS a
INNER JOIN vbap AS b
ON b~vbeln = a~vbeln
INTO TABLE @gt_sodata.
```
---
## Pricing Calculation
| Condition | Description | Amount        |
| --------- | ----------- | ------------- |
| PR00      | Base Price  | ₹4,50,000     |
| K007      | Discount    | -₹22,500      |
| KF00      | Freight     | +₹5,000       |
| **Net**   |             | ₹4,32,500     |
| GST 18%   |             | +₹77,850      |
| **Total** |             | **₹5,10,350** |
---
## FI Accounting Entries
### PGI
* Dr COGS
* Cr Inventory
### Billing
* Dr Accounts Receivable
* Cr Revenue
* Cr GST
### Payment
* Dr Bank
* Cr Accounts Receivable
---
## Transaction Codes
| T-Code | Purpose         |
| ------ | --------------- |
| VA01   | Sales Order     |
| VL01N  | Delivery        |
| VL02N  | PGI             |
| VF01   | Billing         |
| F-28   | Payment         |
| FBL5N  | Customer Ledger |
---
## Screenshots
Stored in `/screenshots/`
Includes:
* Sales Order
* Delivery
* PGI
* Billing
* Payment
---
## Diagrams
* O2C Flow
* System Architecture
* Document Flow
---
## Future Enhancements
* [ ] Credit Management
* [ ] Returns Processing
* [ ] Batch Management
* [ ] S/4HANA Migration
* [ ] SAP Fiori Apps
* [ ] EDI Integration
---
## What Makes This Project Stand Out
* End-to-end SD + FI integration
* Real-world Indian taxation (GST)
* Strong pricing procedure design
* ABAP + functional combination
* Full document traceability
---
## Author
| Field       | Details      |
| ----------- | ------------ |
| Name        | Ritika Kalra |
| Program     | B.Tech CSE   |
| Batch       | 2023–2027    |
| Institution | KIIT         |
| Submission  | April 2026   |
---
## License
This project is for **academic purposes only**.
All company and data are fictional.
---
<div align="center">
    *If this project helped you, consider starring the repo!*
</div>
