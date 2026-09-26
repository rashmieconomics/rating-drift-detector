# Technical Accounting and Project Glossary

This file contains the most important terms used across the project, explained in a way that a beginner can understand.

---

## 1. Financial accounting terms

### Revenue
Revenue is the money earned from selling goods or services before any costs are deducted.

It is often called the top line because it appears at the top of the income statement.

### EBITDA
Earnings before interest, taxes, depreciation, and amortization.

It shows operating performance before financing and non-cash accounting effects.

### Depreciation
A non-cash charge reflecting the reduction in value of tangible assets over time.

### Amortization
A non-cash charge reflecting the reduction in value of intangible assets over time.

### Interest Expense
The cost of borrowing funds.

### Debt
Borrowed capital used to finance operations or investments.

### Current Assets
Assets expected to be converted into cash within one year.

### Current Liabilities
Obligations due within one year.

### Working Capital
Current Assets minus Current Liabilities.

### Receivables
Amounts customers owe to the company.

### Operating Cash Flow
Cash generated from regular business operations.

### Cash Conversion
How efficiently earnings are being translated into cash.

---

## 2. Credit analysis terms

### Leverage
The extent to which a company uses debt to finance itself.

### Debt-to-EBITDA
The ratio of debt to EBITDA. It shows borrowing relative to operating earnings.

### Interest Coverage
The number of times earnings can cover interest expense.

### Liquidity
The firm’s ability to satisfy short-term liabilities.

### Solvency
The firm’s ability to meet long-term obligations.

### Credit Surveillance
A process of continuously monitoring a borrower’s financial health.

### Watchlist
A list of companies that require more analysis because of weak credit indicators.

### Rating Action
A decision by a credit rating agency such as an upgrade, downgrade, or outlook change.

---

## 3. Data and software terms

### CSV
Comma-separated values file. A simple tabular data format used to store spreadsheet-like data.

### SQLite
A lightweight file-based database engine. It stores structured data on disk and is often used for local analytics tools.

### ETL
Extract, transform, load. The process of taking raw data, cleaning it, calculating metrics, and saving it for analysis.

### Pipeline
A sequence of processing steps through which raw data is transformed into useful output.

### Risk Score
A numeric score that summarizes the level of financial stress in a company.

### Risk Band
A category such as Low, Moderate, or High assigned based on the score.

### Flags
Plain-English explanations of why a company received a risk score.

### Workbook
An Excel file containing multiple tabs or sheets.

### Dashboard
A summary page that gives a quick high-level view of the outcome.

### Peer Comparison
Comparing one company with others in the same sector.

---

## 4. Important accounting formulas in the project

### Current Ratio
Current Assets / Current Liabilities

### Debt-to-EBITDA
Total Debt / EBITDA

### Interest Coverage
EBITDA / Interest Expense

### Receivable Days
(Receivables x 90) / Revenue

### Cash Conversion
Operating Cash Flow / EBITDA

### Revenue Growth
(Current Revenue - Prior Revenue) / Prior Revenue

---

## 5. How to interpret the ratios

### Current Ratio > 1.0
Usually indicates adequate short-term liquidity.

### Current Ratio < 1.0
Signals possible short-term stress.

### Debt-to-EBITDA high
Signals higher leverage and greater risk.

### Interest coverage low
Signals weaker debt service capacity.

### Receivable days rising
Signals slower customer collections or weaker working capital quality.

### Cash conversion low
Signals weak ability to turn earnings into cash.

---

## 6. Why the model is explainable

This project does not hide the cause of a risk flag. Each company receives clear messages such as:

- High leverage
- Tight liquidity
- Weak debt protection
- Receivables stretched
- Weak cash conversion

This is called explainability: the user can see which ratio caused the signal.

---

## 7. Why it is not a rating model

This project is intentionally designed as a triage and surveillance tool.

It does not replace a rating agency or analyst judgment. It only helps identify where further review is necessary.

---

## 8. Typical beginner questions

### Why do we divide by EBITDA instead of revenue?
Because EBITDA measures operating earnings and is commonly used in leverage analysis.

### Why use current ratio instead of net worth?
Because this project is focused on near-term credit stress and short-term solvency.

### Why are receivables important?
Because inefficient collections can reduce cash and increase liquidity pressure.

### Why is cash flow so important?
Because a company can show profits but still face real liquidity problems if cash generation is weak.

---

## 9. Summary

This project brings together:

- accounting analysis
- ratio interpretation
- credit risk screening
- Python automation
- SQL storage
- Excel reporting

The most important idea is simple: financial deterioration often shows up before a formal rating change, and this project helps identify those signals early.
