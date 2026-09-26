# Rating Drift Detector

An explainable credit-surveillance project for a CRISIL / S&P Global GAC internship portfolio. It combines Python, SQLite SQL and Excel to identify companies whose financial profile is weakening before a rating action.

## What it does

- Loads quarterly financial statements and rating-action history into SQLite.
- Calculates leverage, interest coverage, liquidity, working-capital and cash-conversion signals.
- Produces an explainable 0-100 risk score and a watchlist.
- Generates an Excel analyst workbook with a dashboard, peer comparison and detailed watchlist.

## Project structure

```text
data/raw/                 Curated sample data (synthetic, for demonstration)
sql/                      Reusable analyst queries
src/                      Python pipeline and workbook generator
artifacts/                Generated SQLite database and Excel workbook
```

## Quick start

```bash
python -m src.pipeline
python -m src.export_excel
```

The project only uses Python's standard library. The sample data is intentionally synthetic and clearly labelled; replace it with cited NSE filings and public rating rationales before presenting it as a live-company study.

## Questions answered

1. Which borrowers should enter the watchlist?
2. What changed in their financial profile?
3. How do they compare with sector peers?
4. Has the stated rating remained unchanged despite worsening indicators?

## Interview talking points

- The score is a triage tool, not a credit-rating model.
- Each flag is traceable to a financial ratio and a plain-English explanation.
- SQLite keeps the analysis repeatable; Excel turns it into an analyst-facing review pack.
- A production version would add data validation, sourced filings, rating-rationale extraction and analyst overrides.

## Resume bullet

Built an explainable credit-surveillance system using Python, SQLite and Excel; integrated multi-period financial data with rating actions, generated ratio-based early-warning flags, and delivered a peer-benchmarking watchlist for corporate credit review.
