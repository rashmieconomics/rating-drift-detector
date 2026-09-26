import tempfile
import unittest
from pathlib import Path

from src.export_excel import export_workbook
from src.pipeline import calculate_metrics

class CreditScoreTests(unittest.TestCase):
    def test_deteriorating_company_is_high_risk(self):
        rows = [{"company_id":"X","quarter":"2025-Q1","revenue":"100","ebitda":"20","total_debt":"50","interest_expense":"3","current_assets":"100","current_liabilities":"80","receivables":"25","operating_cash_flow":"15"}, {"company_id":"X","quarter":"2025-Q4","revenue":"90","ebitda":"15","total_debt":"80","interest_expense":"10","current_assets":"80","current_liabilities":"90","receivables":"50","operating_cash_flow":"2"}]
        result = calculate_metrics(rows)[0]
        self.assertEqual(result["risk_band"], "High")
        self.assertIn("High leverage", result["flags"])

    def test_export_workbook_creates_xlsx(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            output = Path(tmpdir) / "rating_drift_dashboard.xlsx"
            result = export_workbook(output)
            self.assertTrue(result.exists())
            self.assertTrue(result.suffix == ".xlsx")

if __name__ == "__main__":
    unittest.main()
