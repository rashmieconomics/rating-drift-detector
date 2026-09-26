# Replacing the sample data with public evidence

The included data is synthetic and must remain labelled as such. For a portfolio version using listed companies, replace it with a small, auditable sample.

1. Select six to eight companies from a single sector.
2. Collect twelve quarterly results from NSE or BSE filings and record the document URL and reporting date.
3. Collect public rating rationales from CRISIL Ratings, ICRA, India Ratings or CARE Ratings.
4. Enter only facts that can be traced to a source document. Keep a `source_url` column when extending the SQLite schema.
5. Update `data/raw/*.csv`, then rerun `python -m src.export_excel`.

Do not present the risk score as an external credit rating. It is a transparent surveillance screen designed to prioritise analyst review.
