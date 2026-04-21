# Master Data Reference
## TechFlow Solutions Pvt. Ltd. - SAP SD O2C Project

---

## Customer Master - CUST-1001

| Field | Value |
|-------|-------|
| Customer Number | CUST-1001 |
| Name | RetailMart India Ltd. |
| Account Group | 0001 (Sold-To Party) |
| Country | IN (India) |
| Region | DL (Delhi) |
| City | New Delhi |
| Street | 12, Connaught Place, New Delhi – 110001 |
| Telephone | +91-11-4567-8900 |
| Email | procurement@retailmart.in |
| GSTIN | 07AABCR1234F1Z5 |
| Currency | INR |
| Payment Terms | ZN30 (Net 30 Days) |
| Incoterms | CIF (Cost Insurance Freight) |
| Delivery Priority | 02 (Normal) |
| Shipping Conditions | 01 (Standard Ground) |
| Sales District | NORTH |
| Tax Classification | 1 (Liable for GST) |
| Recon Account (FI) | 140000 (Accounts Receivable) |

### Partner Functions
| Code | Function | Assigned To |
|------|----------|-------------|
| SP | Sold-To Party | CUST-1001 |
| SH | Ship-To Party | CUST-1001 (Delhi WH) |
| BP | Bill-To Party | CUST-1001 (AP Dept.) |
| PY | Payer | CUST-1001 (NEFT) |

---

## Material Master - TF-LAP-001

| Field | Value |
|-------|-------|
| Material Number | TF-LAP-001 |
| Description | TechFlow ProBook 14 Laptop |
| Material Type | FERT (Finished Product) |
| Industry Sector | M (Mechanical Engineering) |
| Base Unit | EA (Each) |
| Sales Unit | EA |
| Material Group | ELEC01 |
| Division | 01 (Consumer Electronics) |
| Gross Weight | 2.5 KG |
| Net Weight | 2.1 KG |
| Volume | 0.012 M3 |
| Delivering Plant | TF10 (Noida) |
| Storage Location | SL01 (Finished Goods) |
| Availability Check | 02 (Individual Requirements) |
| Loading Group | 0001 (Manual) |
| Transport Group | 0001 |
| Tax Classification | 1 (Full GST) |
| HSN Code | 8471 (Laptops/Notebooks) |

---

## Pricing Condition Records (VK11)

### PR00 - Base Price
| Sales Org | DC | Material | Valid From | Valid To | Amount | Currency | Per |
|-----------|-----|----------|-----------|----------|--------|----------|-----|
| TF01 | 10 | TF-LAP-001 | 01.01.2026 | 31.12.2026 | 45,000.00 | INR | 1 EA |

### K007 - Customer Discount
| Sales Org | DC | Customer | Valid From | Valid To | Rate |
|-----------|-----|----------|-----------|----------|------|
| TF01 | 10 | CUST-1001 | 01.01.2026 | 31.12.2026 | 5% |

### KF00 - Freight Surcharge
| Sales Org | DC | Material | Valid From | Valid To | Amount | Per |
|-----------|-----|----------|-----------|----------|--------|-----|
| TF01 | 10 | TF-LAP-001 | 01.01.2026 | 31.12.2026 | 500.00 INR | 1 EA |

### MWST - Output Tax (GST)
| Country | Tax Code | Tax % | Account Key |
|---------|----------|-------|-------------|
| IN | A1 | 18% | MWS |

---

## Pricing Calculation - Sample Order (10 Units)

```
Material     : TF-LAP-001 (TechFlow ProBook 14)
Customer     : CUST-1001 (RetailMart India)
Quantity     : 10 EA
Sales Area   : TF01 / 10 / 01

PR00 Base Price        : INR 45,000 × 10  = 4,50,000.00
K007 Cust Discount 5%  :                  =   -22,500.00
KF00 Freight           : INR 500 × 10     =    +5,000.00
                         ─────────────────────────────────
Net Value (pre-tax)    :                  = 4,32,500.00
MWST GST @ 18%         : on 4,32,500      =   +77,850.00
                         ─────────────────────────────────
TOTAL INVOICE VALUE    :                  = 5,10,350.00 INR
Payment Due            : Net 30 → 25-May-2026
```

---

## Sample Document Numbers

| Document | Type | Number | Date | T-Code |
|----------|------|--------|------|--------|
| Inquiry | IN | 10000001 | 18-Apr-2026 | VA11 |
| Quotation | QT | 20000001 | 18-Apr-2026 | VA21 |
| Sales Order | OR | 30000001 | 19-Apr-2026 | VA01 |
| Delivery | LF | 80000001 | 24-Apr-2026 | VL01N |
| Invoice | F2 | 90000001 | 25-Apr-2026 | VF01 |
| FI Clearing | DZ | 1400000001 | 20-May-2026 | F-28 |

---

## Accounting Entries Summary

### At Post Goods Issue (VL02N)
| GL Account | Description | Debit | Credit |
|------------|-------------|-------|--------|
| 500000 | Cost of Goods Sold | 2,50,000 | - |
| 300000 | Finished Goods Inventory | - | 2,50,000 |

*(COGS assumed at INR 25,000/unit standard cost)*

### At Billing / Invoice (VF01)
| GL Account | Description | Debit | Credit |
|------------|-------------|-------|--------|
| 140000 | Accounts Receivable (CUST-1001) | 5,10,350 | - |
| 800000 | Revenue - Electronics Sales | - | 4,32,500 |
| 175000 | GST Output Tax Payable | - | 77,850 |

### At Payment Receipt (F-28)
| GL Account | Description | Debit | Credit |
|------------|-------------|-------|--------|
| 113100 | Bank - HDFC Current Account | 5,10,350 | - |
| 140000 | Accounts Receivable (CUST-1001) | - | 5,10,350 |
