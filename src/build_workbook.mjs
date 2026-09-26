import fs from "node:fs/promises";
import { Workbook, SpreadsheetFile } from "@oai/artifact-tool";

const root = new URL("..", import.meta.url).pathname;
const csv = await fs.readFile(`${root}/data/processed/latest_credit_metrics.csv`, "utf8");
const lines = csv.trim().split(/\r?\n/);
const headers = lines.shift().split(",");
const rows = lines.map(line => {
  const values = line.split(",");
  return Object.fromEntries(headers.map((h, i) => [h, values[i]]));
});
const companiesCsv = await fs.readFile(`${root}/data/raw/companies.csv`, "utf8");
const companyRows = companiesCsv.trim().split(/\r?\n/).slice(1).map(x => x.split(","));
const companyMap = Object.fromEntries(companyRows.map(([id, name, sector]) => [id, {name, sector}]));

const wb = Workbook.create();
const dash = wb.worksheets.add("Dashboard");
const watch = wb.worksheets.add("Watchlist");
const data = wb.worksheets.add("Metrics data");
const readme = wb.worksheets.add("Read me");
for (const sheet of [dash, watch, data, readme]) sheet.showGridlines = false;

const navy = "#1F4E78", blue = "#D9EAF7", amber = "#FFF2CC", red = "#FCE4D6", green = "#E2F0D9", gray = "#F3F6F9";
function title(sheet, text) { sheet.getRange("A2").values = [[text]]; sheet.getRange("A2").format = { font: { bold: true, size: 16, color: navy } }; }
function header(sheet, range) { sheet.getRange(range).format = { fill: navy, font: { bold: true, color: "#FFFFFF" }, horizontalAlignment: "center", verticalAlignment: "center" }; }

title(dash, "Rating Drift Detector");
dash.getRange("A3").values = [["Credit-surveillance summary | Sample data | Latest quarter: 2025-Q4"]];
dash.getRange("A3").format = { font: { italic: true, color: "#666666" } };
dash.getRange("A5:B8").values = [["Metric", "Value"], ["Companies monitored", null], ["High-risk companies", null], ["Average risk score", null]];
dash.getRange("B6:B8").formulas = [["=COUNTA('Metrics data'!A4:A9)"], ["=COUNTIF('Metrics data'!J4:J9,\"High\")"], ["=AVERAGE('Metrics data'!I4:I9)"]];
header(dash, "A5:B5"); dash.getRange("A6:A8").format = { fill: gray, font: { bold: true } }; dash.getRange("B6:B8").format = { fill: blue, font: { bold: true, size: 12 }, horizontalAlignment: "center" };
dash.getRange("A1:A14").format.columnWidth = 25; dash.getRange("B1:B14").format.columnWidth = 22; dash.getRange("B8").format.numberFormat = "0.0";
dash.getRange("D5:H5").values = [["Company", "Risk score", "Risk band", "Key credit signal", "Analyst action"]]; header(dash, "D5:H5");
const watchRows = rows.sort((a,b) => Number(b.risk_score)-Number(a.risk_score)).map(r => [companyMap[r.company_id].name, Number(r.risk_score), r.risk_band, r.flags, r.risk_band === "High" ? "Review at next credit committee" : r.risk_band === "Moderate" ? "Add to quarterly watchlist" : "Continue routine monitoring"]);
dash.getRange(`D6:H${5+watchRows.length}`).values = watchRows;
dash.getRange(`D6:D${5+watchRows.length}`).format.columnWidth = 27; dash.getRange(`E6:E${5+watchRows.length}`).format.numberFormat = "0"; dash.getRange(`F6:F${5+watchRows.length}`).format.columnWidth = 13; dash.getRange(`G6:G${5+watchRows.length}`).format.columnWidth = 28; dash.getRange(`H6:H${5+watchRows.length}`).format.columnWidth = 27;
dash.getRange(`E6:E${5+watchRows.length}`).conditionalFormats.add("colorScale", { colors: [green, amber, red], thresholds: ["min", "50%", "max"] });
dash.getRange("A11:H11").values = [["How to read the score", "", "", "", "", "", "", ""]]; dash.getRange("A11:H11").format = { fill: gray, font: { bold: true, color: navy } };
dash.getRange("A12:H14").values = [["High (45+)", "Immediate analyst review: leverage, coverage, liquidity or cash conversion has weakened materially."], ["Moderate (20–44)", "Include in the quarterly surveillance pack and monitor the stated risk drivers."], ["Low (<20)", "No material quantitative signal in this period. Continue normal monitoring."]];
dash.getRange("A12:A14").format = { font: { bold: true } }; dash.getRange("B12:B14").format.columnWidth = 95;
dash.getRange("A1:H1").format.rowHeight = 8; dash.freezePanes.freezeRows(5);

title(watch, "Company watchlist and peer metrics");
const dataHeaders = ["Company", "Sector", "Quarter", "Revenue growth", "Debt / EBITDA", "Interest coverage", "Current ratio", "Receivable days", "Cash conversion", "Risk score", "Risk band", "Credit flags"];
watch.getRange("A4:L4").values = [dataHeaders]; header(watch, "A4:L4");
const watchDetail = rows.sort((a,b)=>Number(b.risk_score)-Number(a.risk_score)).map(r => [companyMap[r.company_id].name, companyMap[r.company_id].sector, r.quarter, Number(r.revenue_growth), Number(r.debt_to_ebitda), Number(r.interest_coverage), Number(r.current_ratio), Number(r.receivable_days), Number(r.cash_conversion), Number(r.risk_score), r.risk_band, r.flags]);
watch.getRange(`A5:L${4+watchDetail.length}`).values = watchDetail;
watch.getRange(`D5:D${4+watchDetail.length}`).format.numberFormat = "0.0%"; watch.getRange(`E5:G${4+watchDetail.length}`).format.numberFormat = "0.0x"; watch.getRange(`H5:H${4+watchDetail.length}`).format.numberFormat = "0.0"; watch.getRange(`I5:I${4+watchDetail.length}`).format.numberFormat = "0.0%";
watch.getRange(`J5:J${4+watchDetail.length}`).conditionalFormats.add("colorScale", { colors: [green, amber, red], thresholds: ["min", "50%", "max"] });
watch.getRange("A13:D13").values = [["Peer benchmark", "Average Debt / EBITDA", "Average interest coverage", "Average risk score"]]; header(watch, "A13:D13");
watch.getRange("A14:D14").values = [["Auto Components", null, null, null]]; watch.getRange("B14:D14").formulas = [["=AVERAGE(E5:E10)", "=AVERAGE(F5:F10)", "=AVERAGE(J5:J10)"]]; watch.getRange("B14:C14").format.numberFormat = "0.0x"; watch.getRange("D14").format.numberFormat = "0.0";
for (const [col, width] of [["A",28],["B",18],["C",14],["D",16],["E",17],["F",19],["G",15],["H",17],["I",17],["J",13],["K",14],["L",38]]) watch.getRange(`${col}1:${col}20`).format.columnWidth = width;
watch.freezePanes.freezeRows(4);

title(data, "Latest credit metrics (pipeline output)");
data.getRange("A3:K3").values = [["Company ID", "Quarter", "Revenue growth", "Debt / EBITDA", "Interest coverage", "Current ratio", "Receivable days", "Cash conversion", "Risk score", "Risk band", "Credit flags"]]; header(data, "A3:K3");
const metricRows = rows.map(r => [r.company_id, r.quarter, Number(r.revenue_growth), Number(r.debt_to_ebitda), Number(r.interest_coverage), Number(r.current_ratio), Number(r.receivable_days), Number(r.cash_conversion), Number(r.risk_score), r.risk_band, r.flags]);
data.getRange(`A4:K${3+metricRows.length}`).values = metricRows; data.getRange(`C4:C${3+metricRows.length}`).format.numberFormat = "0.0%"; data.getRange(`D4:F${3+metricRows.length}`).format.numberFormat = "0.0x"; data.getRange(`G4:G${3+metricRows.length}`).format.numberFormat = "0.0"; data.getRange(`H4:H${3+metricRows.length}`).format.numberFormat = "0.0%";
data.getRange("M3").values = [["Source note"]]; data.getRange("M4").values = [["Synthetic demonstration data. Replace with cited NSE filings and public rating rationales for a live-company version."]]; data.getRange("M4").format.columnWidth = 55; data.getRange("M4").format.wrapText = true; data.freezePanes.freezeRows(3);

title(readme, "Workbook guide");
readme.getRange("A4:B9").values = [["Section", "Purpose"], ["Dashboard", "Credit-surveillance summary and prioritised analyst actions."], ["Watchlist", "Peer metrics, risk flags and company-level review view."], ["Metrics data", "Latest output from the Python scoring pipeline."], ["Method", "The score adds points for leverage, weak interest coverage, tight liquidity, stretched receivables and weak cash conversion."], ["Limitation", "A triage tool for learning. It is not a rating opinion or a substitute for analyst judgement."]]; header(readme, "A4:B4"); readme.getRange("A5:A9").format = { fill: gray, font: { bold: true } }; readme.getRange("B1:B12").format.columnWidth = 85; readme.getRange("B5:B9").format.wrapText = true;

wb.recalculate();
const out = await SpreadsheetFile.exportXlsx(wb);
await out.save(`${root}/artifacts/rating_drift_dashboard.xlsx`);
console.log("Workbook created: artifacts/rating_drift_dashboard.xlsx");
