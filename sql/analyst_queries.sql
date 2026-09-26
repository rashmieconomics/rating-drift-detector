-- 1. Current watchlist ranked by risk score
SELECT company_name, sector, risk_score, risk_band, flags
FROM latest_credit_metrics
WHERE risk_band IN ('High', 'Moderate')
ORDER BY risk_score DESC;

-- 2. Companies whose financial risk has worsened while rating stayed unchanged
SELECT c.company_name, r.rating, r.outlook, m.debt_to_ebitda, m.interest_coverage, m.risk_score
FROM latest_credit_metrics m
JOIN companies c ON c.company_id = m.company_id
JOIN rating_actions r ON r.company_id = m.company_id
ORDER BY m.risk_score DESC;

-- 3. Sector peer benchmark
SELECT sector, ROUND(AVG(debt_to_ebitda),2) AS avg_debt_to_ebitda,
       ROUND(AVG(interest_coverage),2) AS avg_interest_coverage,
       ROUND(AVG(risk_score),1) AS avg_risk_score
FROM latest_credit_metrics
GROUP BY sector;
