INSERT OR IGNORE INTO companies (
    company_id,
    company_name,
    sector
)
VALUES (
    'UNOMINDALTD',
    'Uno Minda Limited',
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
    'UNOMINDALTD',
    '2026-09-25',
    'ICRA AA+',
    'Stable',
    'Reaffirmed',
    'Strong diversification, global OEM relationships, healthy liquidity and low adjusted leverage. Key risks include global auto cyclicality and debt-funded acquisitions.',
    'ICRA Rating Rationale - Uno Minda Limited ',
    'https://www.icra.in/Rationale/ShowRationaleReport?Id=14494'
);

-- 7. Insert ICRA-adjusted FY2026 financial indicators
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
    'UNOMINDALTD',
    'FY2026',
    19657.6,
    1035.2,
    5.3,
    0.9,
    12.1
);

-- 8. Insert ICRA's downside rating triggers
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
    'UNOMINDALTD',
    '2026-09-25',
    'Downward',
    'Net debt / EBITDA',
    '> 1.5x sustained',
    'Higher-than-expected debt-funded acquisitions or capex causing leverage to rise above 1.5x on a sustained basis.',
    'https://www.icra.in/Rationale/ShowRationaleReport?Id=144984'
),
(
    'UNOMINDALTD',
    '2026-09-25',
    'Downward',
    'EBITDA margin',
    '< 6% prolonged',
    'Sustained deterioration in profitability causing EBITDA margin below 6% for a prolonged period.',
    'https://www.icra.in/Rationale/ShowRationaleReport?Id=144984'
),
(
    'UNOMINDALTD',
    '2026-09-25',
    'Downward',
    'Liquidity',
    'Sharp deterioration',
    'A sharp deterioration in liquidity.',
    'https://www.icra.in/Rationale/ShowRationaleReport?Id=144984'
);