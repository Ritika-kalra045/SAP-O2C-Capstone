# Screenshots Guide
## What to Capture & Where to Find Each Screenshot

> Since direct SAP GUI access is unavailable, use SAP Learning Hub, openSAP demos,
> SAP Fiori Launchpad trials, or replicate with mockup tools like Figma / Canva.
> Label every screenshot clearly before adding to the `/screenshots/` folder.

---

## Screenshot 1 — SAP Easy Access Menu
**File:** `01_sap_easy_access_menu.png`
**Transaction:** SAP GUI Home Screen
**What to show:**
- Left menu tree expanded to: Logistics > Sales and Distribution > Sales
- Show the folder icons for: Inquiry, Quotation, Sales Order
**Label:** "SAP Easy Access Menu — SD Navigation Tree"

---

## Screenshot 2 — Create Inquiry (VA11)
**File:** `02_inquiry_va11.png`
**Transaction:** VA11
**What to show:**
- Initial screen with: Inquiry Type = IN, Sales Org = TF01, DC = 10, Division = 01
- Item overview tab: Material = TF-LAP-001, Qty = 50
**Label:** "VA11 — Create Inquiry: RetailMart requests 50 ProBook Laptops"

---

## Screenshot 3 — Quotation Header (VA23)
**File:** `03_quotation_va23.png`
**Transaction:** VA23 (Display Quotation)
**What to show:**
- Header tab: Quotation QT-20260418-001, Customer CUST-1001, Valid From/To dates
- Conditions tab: PR00 = 45,000, K007 = 5%, MWST = 18%
**Label:** "VA23 — Quotation with Validity Period and Pricing Conditions"

---

## Screenshot 4 — Sales Order Overview (VA03)
**File:** `04_sales_order_va03.png`
**Transaction:** VA03 (Display Sales Order)
**What to show:**
- Order SO-20260419-001, Customer CUST-1001, date, Net Value = 4,32,500 INR
- Item row: TF-LAP-001, Qty 10 EA, Plant TF10
**Label:** "VA03 — Sales Order Overview: 10 ProBook Laptops for RetailMart"

---

## Screenshot 5 — Sales Order Document Flow
**File:** `05_document_flow.png`
**Transaction:** VA03 > Extras > Document Flow (or click Document Flow button)
**What to show:**
- Tree: Inquiry → Quotation → Sales Order → Delivery → Invoice
- Each with status (Completed / Being Processed)
**Label:** "Document Flow: End-to-End O2C Chain from Inquiry to Invoice"

---

## Screenshot 6 — Sales Order Conditions Tab
**File:** `06_so_conditions.png`
**Transaction:** VA03 > Item > Conditions
**What to show:**
- Condition type column: PR00, K007, KF00, MWST
- Amount column with values
- Net value and total with tax
**Label:** "Sales Order — Condition-Based Pricing Breakdown (ZTFPR1)"

---

## Screenshot 7 — Create Delivery (VL01N)
**File:** `07_delivery_vl01n.png`
**Transaction:** VL01N
**What to show:**
- Shipping Point = SP01, Selection Date = 25-Apr-2026
- Reference Sales Order = SO-20260419-001
- Picking tab: Material TF-LAP-001, Qty 10
**Label:** "VL01N — Outbound Delivery Created for Sales Order"

---

## Screenshot 8 — Post Goods Issue (VL02N)
**File:** `08_post_goods_issue.png`
**Transaction:** VL02N > Post Goods Issue
**What to show:**
- Delivery document DEL-20260424-001
- Status field showing "Goods Issue Completed" (green)
- Material document number generated
**Label:** "VL02N — Post Goods Issue: 10 Laptops Dispatched from TF10"

---

## Screenshot 9 — Billing Document (VF03)
**File:** `09_billing_vf01.png`
**Transaction:** VF03 (Display Billing)
**What to show:**
- Invoice INV-20260425-001, Type F2, Customer CUST-1001
- Net Amount = 4,32,500 | Tax = 77,850 | Total = 5,10,350 INR
**Label:** "VF01/VF03 — Billing Document (Invoice F2) for RetailMart"

---

## Screenshot 10 — Accounting Document at Billing
**File:** `10_billing_accounting.png`
**Transaction:** VF03 > Accounting tab (or follow-on documents)
**What to show:**
- FI document showing: Dr Accounts Receivable 5,10,350 | Cr Revenue 4,32,500 | Cr Tax 77,850
**Label:** "FI Integration — Accounting Entry Generated at Billing"

---

## Screenshot 11 — Incoming Payment (F-28)
**File:** `11_payment_f28.png`
**Transaction:** F-28
**What to show:**
- Document Date = 20-May-2026, Amount = 5,10,350
- Customer CUST-1001 open items listed
- Invoice INV-20260425-001 selected for clearing
**Label:** "F-28 — Incoming Payment from RetailMart India (NEFT)"

---

## Screenshot 12 — Customer Line Items Cleared (FBL5N)
**File:** `12_cleared_fbl5n.png`
**Transaction:** FBL5N
**What to show:**
- Customer CUST-1001 line items report
- Invoice line: 5,10,350 INR — Status: CLEARED (green checkmark)
**Label:** "FBL5N — Accounts Receivable Cleared: O2C Cycle Complete"

---

## Screenshot 13 — SPRO Configuration Tree
**File:** `13_spro_config.png`
**Transaction:** SPRO
**What to show:**
- IMG tree expanded to show SD configuration nodes
- Highlight: Enterprise Structure, Pricing, Output Determination
**Label:** "SPRO — SAP Implementation Guide: SD Configuration Nodes"

---

## Screenshot 14 — ABAP Report ALV Output (ZSODATA)
**File:** `14_abap_alv_zsodata.png`
**Transaction:** SE38 → Run ZSODATA
**What to show:**
- ALV grid with zebra striping
- Columns: VBELN, POSNR, VKORG, VTWEG, MATNR, ZMENG, NETWR, WAERK
- At least 5 rows of sample data
**Label:** "ABAP Report ZSODATA — ALV Grid Output (VBAK + VBAP Join)"

---

## Where to Get These Screenshots (Since No SAP Access)

| Source | URL | What You Can Get |
|--------|-----|-----------------|
| SAP Learning Hub | learning.sap.com | Free trial with SAP GUI demo |
| openSAP | open.sap.com | Free SAP SD course screenshots |
| SAP Help Portal | help.sap.com | Transaction documentation images |
| YouTube SAP Tutorials | youtube.com | Screen recordings you can capture |
| SAP Fiori Trial | www.sap.com/products/trial | Browser-based SAP trial |
| Mockup Tool | canva.com / figma.com | Create realistic SAP UI mockups |

---

## Tip: Create Mockup Screenshots
If live SAP screenshots are not available, create professional mockups in Canva:
1. Use a grey background (#F4F4F4)
2. Add a blue header bar (#0070F2 — SAP blue)
3. Add table grids with the field names and sample data from this project
4. Label them clearly as "Simulated SAP GUI Screen" to maintain academic honesty
