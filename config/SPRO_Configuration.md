# SPRO Configuration Reference
TechFlow Solutions Pvt. Ltd. - SAP SD O2C Setup

> **Transaction:** SPRO → SAP Reference IMG

---

1. Enterprise Structure - Definition

1.1 Define Company Code
```
Path: SPRO > Enterprise Structure > Definition > Financial Accounting
      > Edit, Copy, Delete, Check Company Code
Action: New Entry
  Company Code : TFSOL
  Name         : TechFlow Solutions Pvt. Ltd.
  City         : Noida
  Country      : IN
  Currency     : INR
  Language     : EN
```

1.2 Define Sales Organization

```
Path: SPRO > Enterprise Structure > Definition > Sales and Distribution
      > Define, Copy, Delete, Check Sales Organization
Action: New Entry
  Sales Org : TF01
  Descr     : TechFlow North India Sales
  CompCode  : TFSOL
  Address   : Sector 62, Noida, UP – 201309
```

1.3 Define Distribution Channel

```
Path: SPRO > Enterprise Structure > Definition > Sales and Distribution
      > Define, Copy, Delete, Check Distribution Channel
  10 = Direct Sales (B2B Direct to Customer)
  20 = Dealer Network (future)
```

1.4 Define Division

```
Path: SPRO > Enterprise Structure > Definition > Logistics – General
      > Define, Copy, Delete, Check Division
  01 = Consumer Electronics
  02 = Accessories & Peripherals (future)
```

---

2. Enterprise Structure - Assignment

2.1 Assign Sales Organization to Company Code

```
Path: SPRO > Enterprise Structure > Assignment > Sales and Distribution
      > Assign Sales Organization to Company Code
  TF01 → TFSOL
```

2.2 Assign Distribution Channel to Sales Organization

```
Path: SPRO > Enterprise Structure > Assignment > Sales and Distribution
      > Assign Distribution Channel to Sales Organization
  10 → TF01
```

2.3 Assign Division to Sales Organization

```
Path: SPRO > Enterprise Structure > Assignment > Sales and Distribution
      > Assign Division to Sales Organization
  01 → TF01
```

2.4 Set Up Sales Area

```
Path: SPRO > Enterprise Structure > Assignment > Sales and Distribution
      > Set Up Sales Area
  TF01 / 10 / 01 (North India / Direct / Electronics)
```

2.5 Assign Plant to Sales Organization

```
Path: SPRO > Enterprise Structure > Assignment > Sales and Distribution
      > Assign Sales Organization – Distribution Channel – Plant
  TF01 / 10 → TF10 (Noida Plant)
```

2.6 Assign Shipping Point to Plant

```
Path: SPRO > Enterprise Structure > Assignment > Logistics Execution
      > Assign Shipping Point to Plant
  SP01 → TF10
```

---

3. Sales Document Types

3.1 Standard Document Types Used (No Custom Config Needed)

```
Path: SPRO > Sales and Distribution > Sales > Sales Documents
      > Sales Document Header > Define Sales Document Types

  IN  = Inquiry        (Standard SAP)
  QT  = Quotation      (Standard SAP)
  OR  = Standard Order (Standard SAP)
  RE  = Returns        (Standard SAP — for future)
```

---

4. Pricing Procedure

4.1 Create Pricing Procedure ZTFPR1

```
Path: SPRO > SD > Basic Functions > Pricing > Pricing Control
      > Define and Assign Pricing Procedures

Step 1: Define Calculation Schema
  Procedure : ZTFPR1
  Desc      : TechFlow Standard Pricing

  Step | CTyp | Description          | From | To | Req | Stat | ATyp | AccKey
  -----|------|----------------------|------|----|----|------|------|-------
  10   | PR00 | Base Price           |      |    |  X |      |      | ERL
  20   | K007 | Customer Discount    | 10   |    |    |      | X    | ERS
  30   | KF00 | Freight              |      |    |    |      |      | ERF
  40   |      | Net Value            | 10   | 30 |    |  X   |      |
  50   | MWST | Output Tax (GST)     | 40   |    |    |      |      | MWS
  60   |      | Grand Total          | 40   | 50 |    |  X   |      |

Step 2: Define Document Pricing Procedure
  A = Standard

Step 3: Define Customer Pricing Procedure
  1 = Standard

Step 4: Assign Pricing Procedure
  SOrg | DC | Div | DocPP | CustPP | PricProc
  TF01 | 10 | 01  |   A   |   1    | ZTFPR1
```

---

5. Output Determination (Invoice PDF)

5.1 Billing Output - RD00

```
Path: SPRO > SD > Basic Functions > Output Control
      > Output Determination > Maintain Output Determination for Billing

Condition Table : 6 (Sales Organization + Billing Type)
Access Sequence : V10000
Output Type     : RD00 (Invoice)

Condition Record:
  Sales Org : TF01
  Bill Type : F2
  Medium    : 1 (Print) or 5 (Email)
  Time      : 4 (Send immediately when saved)
  Partner   : BP (Bill-To Party)
```

---

6. Copy Control

6.1 Inquiry → Quotation (VA21 references VA11)

```
Path: SPRO > SD > Sales > Maintain Copy Control for Sales Documents
      > Copying Control: Sales Document to Sales Document
  Source: IN (Inquiry) → Target: QT (Quotation)
  Pos/Neg Quantities: +
  Copy Item No.: tick 
```

6.2 Quotation → Sales Order (VA01 references VA21)

```
  Source: QT → Target: OR
  Same settings as above
```

6.3 Delivery → Invoice (VTFL)

```
Path: SPRO > SD > Billing > Billing Documents
      > Maintain Copying Control for Billing Documents
      > Copying Control: Delivery Document to Billing Document (VTFL)
  Source: LF (Delivery) → Target: F2 (Invoice)
  Billing Quantity: B (Goods Issue quantity)
  Pos/Neg: +
```

---

7. Shipping Point Determination

```
Path: SPRO > Logistics Execution > Shipping > Basic Shipping Functions
      > Shipping Point and Goods Receiving Point Determination
      > Assign Shipping Points

Rule: Shipping Cond (01) + Loading Group (0001) + Plant (TF10) = SP01
```

---

8. Credit Management (Basic Setup)

```
Path: SPRO > SD > Basic Functions > Credit Management/Risk Management
      > Credit Management > Define Credit Control Area
  Credit Control Area : TF01
  Currency            : INR
  Update              : 000012 (SD Document)
  Risk Category       : 010 (Medium Risk — Default)

Customer Credit Limit (FD32):
  Customer : CUST-1001
  Cr.Limit : INR 25,00,000
  Risk Cat  : 010
```
