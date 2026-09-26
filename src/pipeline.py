"""Load financial data, calculate explainable credit signals, and persist SQLite outputs."""
from __future__ import annotations

import csv
import sqlite3
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
RAW = ROOT / "data" / "raw"
DB_PATH = ROOT / "artifacts" / "rating_drift.db"


def ratio(numerator: float, denominator: float) -> float:
    return round(numerator / denominator, 3) if denominator else 0.0


def calculate_metrics(rows: list[dict[str, str]]) -> list[dict[str, object]]:
    grouped: dict[str, list[dict[str, str]]] = {}
    for row in rows:
        grouped.setdefault(row["company_id"], []).append(row)
    metrics = []
    for company_id, history in grouped.items():
        history.sort(key=lambda x: x["quarter"])
        latest, prior = history[-1], history[0]
        rev = float(latest["revenue"]); ebitda = float(latest["ebitda"])
        debt = float(latest["total_debt"]); interest = float(latest["interest_expense"])
        current_ratio = ratio(float(latest["current_assets"]), float(latest["current_liabilities"]))
        debt_to_ebitda = ratio(debt, ebitda)
        interest_coverage = ratio(ebitda, interest)
        receivable_days = ratio(float(latest["receivables"]) * 90, rev)
        cash_conversion = ratio(float(latest["operating_cash_flow"]), ebitda)
        revenue_growth = ratio(rev - float(prior["revenue"]), float(prior["revenue"]))
        score = 0; flags = []
        if debt_to_ebitda > 4: score += 30; flags.append("High leverage")
        elif debt_to_ebitda > 3: score += 18; flags.append("Leverage rising")
        if interest_coverage < 2: score += 25; flags.append("Weak debt protection")
        elif interest_coverage < 3: score += 12; flags.append("Debt protection softening")
        if current_ratio < 1: score += 20; flags.append("Liquidity below 1.0x")
        elif current_ratio < 1.2: score += 10; flags.append("Tight liquidity")
        if receivable_days - ratio(float(prior["receivables"]) * 90, float(prior["revenue"])) > 12:
            score += 12; flags.append("Receivables stretched")
        if cash_conversion < 0.25: score += 13; flags.append("Weak cash conversion")
        band = "High" if score >= 45 else "Moderate" if score >= 20 else "Low"
        metrics.append({"company_id": company_id, "quarter": latest["quarter"], "revenue_growth": revenue_growth,
                        "debt_to_ebitda": debt_to_ebitda, "interest_coverage": interest_coverage,
                        "current_ratio": current_ratio, "receivable_days": receivable_days,
                        "cash_conversion": cash_conversion, "risk_score": score, "risk_band": band,
                        "flags": "; ".join(flags) if flags else "No material signal"})
    return metrics


def load_csv(filename: str) -> list[dict[str, str]]:
    with (RAW / filename).open(newline="", encoding="utf-8") as handle:
        return list(csv.DictReader(handle))


def build_database() -> None:
    DB_PATH.parent.mkdir(exist_ok=True)
    if DB_PATH.exists(): DB_PATH.unlink()
    companies, financials, actions = load_csv("companies.csv"), load_csv("quarterly_financials.csv"), load_csv("rating_actions.csv")
    metrics = calculate_metrics(financials)
    with sqlite3.connect(DB_PATH) as conn:
        conn.executescript("""
        CREATE TABLE companies (company_id TEXT PRIMARY KEY, company_name TEXT, sector TEXT);
        CREATE TABLE quarterly_financials (company_id TEXT, quarter TEXT, revenue REAL, ebitda REAL, total_debt REAL, interest_expense REAL, current_assets REAL, current_liabilities REAL, receivables REAL, operating_cash_flow REAL);
        CREATE TABLE rating_actions (company_id TEXT, action_date TEXT, rating TEXT, outlook TEXT, action_type TEXT, rationale_summary TEXT);
        CREATE TABLE latest_credit_metrics (company_id TEXT, quarter TEXT, revenue_growth REAL, debt_to_ebitda REAL, interest_coverage REAL, current_ratio REAL, receivable_days REAL, cash_conversion REAL, risk_score INTEGER, risk_band TEXT, flags TEXT);
        """)
        conn.executemany("INSERT INTO companies VALUES (:company_id,:company_name,:sector)", companies)
        conn.executemany("INSERT INTO quarterly_financials VALUES (:company_id,:quarter,:revenue,:ebitda,:total_debt,:interest_expense,:current_assets,:current_liabilities,:receivables,:operating_cash_flow)", financials)
        conn.executemany("INSERT INTO rating_actions VALUES (:company_id,:action_date,:rating,:outlook,:action_type,:rationale_summary)", actions)
        conn.executemany("INSERT INTO latest_credit_metrics VALUES (:company_id,:quarter,:revenue_growth,:debt_to_ebitda,:interest_coverage,:current_ratio,:receivable_days,:cash_conversion,:risk_score,:risk_band,:flags)", metrics)
    processed = ROOT / "data" / "processed" / "latest_credit_metrics.csv"
    with processed.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(metrics[0]))
        writer.writeheader(); writer.writerows(metrics)
    print(f"Created {DB_PATH} with {len(metrics)} current company metrics.")


if __name__ == "__main__":
    build_database()
