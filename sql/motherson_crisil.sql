-- 1. Create the company table
CREATE TABLE IF NOT EXISTS companies (
    company_id TEXT PRIMARY KEY,
    company_name TEXT NOT NULL,
    sector TEXT NOT NULL
);

-- 2. Create the CRISIL rating-action table
CREATE TABLE IF NOT EXISTS rating_actions (
    rating_action_id INTEGER PRIMARY KEY AUTOINCREMENT,
    company_id TEXT NOT NULL,
    action_date TEXT NOT NULL,
    rating TEXT NOT NULL,
    outlook TEXT NOT NULL,
    action_type TEXT NOT NULL,
    rationale_summary TEXT,
    source_document TEXT NOT NULL,
    source_url TEXT NOT NULL,
    FOREIGN KEY (company_id) REFERENCES companies(company_id)
);

-- 3. Create the table for CRISIL financial indicators
CREATE TABLE IF NOT EXISTS rating_financial_indicators (
    indicator_id INTEGER PRIMARY KEY AUTOINCREMENT,
    company_id TEXT NOT NULL,
    fiscal_year TEXT NOT NULL,
    revenue_crore REAL,
    pat_crore REAL,
    pat_margin_pct REAL,
    adjusted_debt_to_networth REAL,
    interest_coverage REAL,
    FOREIGN KEY (company_id) REFERENCES companies(company_id)
);

-- 4. Create the table for CRISIL downside triggers
CREATE TABLE IF NOT EXISTS rating_sensitivity_factors (
    factor_id INTEGER PRIMARY KEY AUTOINCREMENT,
    company_id TEXT NOT NULL,
    rating_date TEXT NOT NULL,
    direction TEXT NOT NULL,
    metric TEXT NOT NULL,
    threshold TEXT NOT NULL,
    condition_description TEXT NOT NULL,
    source_url TEXT NOT NULL,
    FOREIGN KEY (company_id) REFERENCES companies(company_id)
);

-- 5. Insert Motherson as a company
INSERT OR IGNORE INTO companies (
    company_id,
    company_name,
    sector
)
VALUES (
    'MOTHERSON',
    'Samvardhana Motherson International Limited',
    'Auto Components'
);

-- 6. Insert the CRISIL rating action
INSERT INTO rating_actions (
    company_id,
    action_date,
    rating,
    outlook,
    action_type,
    rationale_summary,
    source_document,
    source_url
)
VALUES (
    'MOTHERSON',
    '2026-06-18',
    'CRISIL AAA',
    'Stable',
    'Reaffirmed',
    'Strong diversification, global OEM relationships, healthy liquidity and low adjusted leverage. Key risks include global auto cyclicality and debt-funded acquisitions.',
    'CRISIL Rating Rationale - Samvardhana Motherson International Limited',
    'https://www.crisil.com/mnt/winshare/Ratings/RatingList/RatingDocs/SamvardhanaMothersonInternationalLimited_June%2018_%202026_RR_398205.html'
);

-- 7. Insert CRISIL-adjusted FY2026 financial indicators
INSERT INTO rating_financial_indicators (
    company_id,
    fiscal_year,
    revenue_crore,
    pat_crore,
    pat_margin_pct,
    adjusted_debt_to_networth,
    interest_coverage
)
VALUES (
    'MOTHERSON',
    'FY2026',
    125953,
    3935,
    3.1,
    0.50,
    7.8
);

-- 8. Insert CRISIL's downside rating triggers
INSERT INTO rating_sensitivity_factors (
    company_id,
    rating_date,
    direction,
    metric,
    threshold,
    condition_description,
    source_url
)
VALUES
(
    'MOTHERSON',
    '2026-06-18',
    'Downward',
    'Net debt / EBITDA',
    '> 1.5x sustained',
    'Higher-than-expected debt-funded acquisitions or capex causing leverage to rise above 1.5x on a sustained basis.',
    'https://www.crisil.com/mnt/winshare/Ratings/RatingList/RatingDocs/SamvardhanaMothersonInternationalLimited_June%2018_%202026_RR_398205.html'
),
(
    'MOTHERSON',
    '2026-06-18',
    'Downward',
    'EBITDA margin',
    '< 6% prolonged',
    'Sustained deterioration in profitability causing EBITDA margin below 6% for a prolonged period.',
    'https://www.crisil.com/mnt/winshare/Ratings/RatingList/RatingDocs/SamvardhanaMothersonInternationalLimited_June%2018_%202026_RR_398205.html'
),
(
    'MOTHERSON',
    '2026-06-18',
    'Downward',
    'Liquidity',
    'Sharp deterioration',
    'A sharp deterioration in liquidity.',
    'https://www.crisil.com/mnt/winshare/Ratings/RatingList/RatingDocs/SamvardhanaMothersonInternationalLimited_June%2018_%202026_RR_398205.html'
);