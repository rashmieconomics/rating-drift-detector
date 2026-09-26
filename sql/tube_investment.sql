INSERT OR IGNORE INTO companies (
    company_id,
    company_name,
    sector
)
VALUES (
    'TUBEINVEST',
    'Tube Investment',
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
    'TUBEINVEST',
    '2026-09-15',
    'CRISIL AA+',
    'Stable',
    'Reaffirmed',
    'Strong diversification, global OEM relationships, healthy liquidity and low adjusted leverage. Key risks include global auto cyclicality and debt-funded acquisitions.',
    'CRISIL Rating Rationale - Tube Investment',
    'https://www.crisil.com/mnt/winshare/Ratings/RatingList/RatingDocs/TubeInvestmentsOfIndiaLimited_September%2015_%202026_RR_405091.html'
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
    'TUBEINVEST',
    'FY2026',
    22847,
    1118,
    4.9,
    0.03,
    33.64
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
    'TUBEINVEST',
    '2026-09-15',
    'Downward',
    'Net debt / EBITDA',
    '> 1.5x sustained',
    'Higher-than-expected debt-funded acquisitions or capex causing leverage to rise above 1.5x on a sustained basis.',
    'https://www.crisil.com/mnt/winshare/Ratings/RatingList/RatingDocs/TubeInvestmentsOfIndiaLimited_September%2015_%202026_RR_405091.html'
),
(
    'TUBEINVEST',
    '2026-09-15',
    'Downward',
    'EBITDA margin',
    '< 6% prolonged',
    'Sustained deterioration in profitability causing EBITDA margin below 6% for a prolonged period.',
    'https://www.crisil.com/mnt/winshare/Ratings/RatingList/RatingDocs/TubeInvestmentsOfIndiaLimited_September%2015_%202026_RR_405091.html'
),
(
    'TUBEINVEST',
    '2026-09-15',
    'Downward',
    'Liquidity',
    'Sharp deterioration',
    'A sharp deterioration in liquidity.',
    'https://www.crisil.com/mnt/winshare/Ratings/RatingList/RatingDocs/TubeInvestmentsOfIndiaLimited_September%2015_%202026_RR_405091.html'
);