# credit-card-fraud
Credit Card Fraud Analytics | End-to-End Data Analytics Project

1. Project Overview

Credit card fraud is a major challenge for financial institutions. Fraudulent transactions can cause financial losses, reduce customer trust, and increase investigation costs.

In this project, I analyzed historical credit card transaction data to understand fraudulent transaction patterns, compare fraudulent and legitimate transactions, examine transaction amounts, and explore how fraud varies across time intervals.

I used Excel, Python (Pandas), MySQL, and Power BI to perform data analysis, answer business questions, and build an interactive dashboard.

Project type: Data Analytics / Business Intelligence
Domain: Banking and Financial Services
Focus: Fraud pattern analysis, transaction monitoring, business insights, and decision support
Machine Learning: Not used

2. Business Problem

A financial institution needs to understand:

- How frequently does credit card fraud occur?
- How do fraudulent transactions differ from normal transactions?
- What is the financial value associated with detected fraud?
- Do transaction amounts show different patterns for fraud and normal transactions?
- How does the observed fraud rate vary across time intervals?
- What actions could help a fraud investigation team prioritize its resources?

The goal was to convert transaction-level data into useful insights that could support fraud monitoring and investigation decisions.

3. Dataset Overview

The project uses the Credit Card Fraud Detection dataset commonly known as the ULB dataset.

- Total transactions: 284,807
- Legitimate transactions: 284,315
- Fraudulent transactions: 492
- Total columns in the original dataset: 31
- Target column: "Class"
- Transaction amount column: "Amount"
- Time column: "Time"

Important columns

Column| Description
"Time"| Elapsed time in seconds from the dataset's reference point
"Amount"| Transaction amount
"V1"–"V28"| Anonymized numerical features
"Class"| Target label: 0 = legitimate, 1 = fraud

Important: The "V1"–"V28" features are anonymized. Their real-world meanings cannot be reliably inferred from their column names alone. The currency or unit of "Amount" is also not assumed to be INR.

4. Tools and Technologies

- Excel: Initial data inspection and basic calculations
- Python: Pandas for data analysis and data-quality checks
- MySQL: SQL queries, aggregations, and business-question analysis
- Power BI: Interactive dashboard, KPI cards, measures, and visualizations
- DAX: Calculated measures for fraud KPIs and time-interval analysis
- GitHub: Project documentation and portfolio presentation

5. Project Workflow

Step 1: Data inspection and initial analysis

I inspected the dataset, reviewed its structure, checked transaction counts, and calculated the distribution of fraudulent and legitimate transactions.

I also examined transaction amounts and explored how fraud appeared across time intervals.

Step 2: Python analysis using Pandas

I used Pandas to:

- Inspect the dataset structure and summary statistics.
- Check missing values.
- Identify duplicate rows.
- Separate fraudulent and legitimate transactions for comparison.
- Analyze transaction amount distributions.
- Calculate fraud counts and percentages.
- Explore fraud counts within six-hour intervals.

Data-quality findings:

- Missing values: 0
- Duplicate rows identified by the duplicate check: 1,081

Duplicate records require careful interpretation. Some may be legitimate repeated-looking transactions, so duplicates should be investigated before deleting them. I did not assume that every duplicate was fraudulent.

Step 3: MySQL analysis

I imported the transaction data into MySQL and used SQL to answer business questions through:

- Transaction counts and aggregations
- Fraud versus legitimate transaction comparisons
- Transaction amount analysis
- Grouping transactions into categories or time intervals
- CTEs and window functions for more advanced analysis where applicable

The purpose of SQL was to turn raw transaction records into structured, business-relevant findings.

Step 4: Power BI dashboard

I created a dashboard to present the main findings through KPI cards, charts, and interactive filtering.

The dashboard covers:

- Total transactions
- Fraudulent transactions
- Legitimate transactions
- Fraud rate
- Total fraudulent transaction amount
- Fraud versus legitimate transaction comparisons
- Transaction amount analysis by class
- Fraud-rate analysis across time intervals
- Additional fraud amount and transaction-level comparisons

I also worked on slicers and formatting to make the dashboard easier to explore.

6. Key Business Insights

Insight 1: Fraud represents a very small proportion of transactions

Out of 284,807 transactions, 492 were classified as fraudulent.

Fraud rate:

"(492 / 284807) × 100 = approximately 0.173%"

Approximately 99.827% of transactions were classified as legitimate.

Business implication: Fraud is a rare event in this dataset. A monitoring system should be able to investigate suspicious transactions without overwhelming analysts with unnecessary alerts.

Insight 2: Fraudulent transaction amounts differ from normal transactions

Metric| Fraud| Legitimate
Transaction count| 492| 284,315
Total transaction amount| 60,127.97| 25,102,462.04
Average transaction amount| 122.21| 88.29
Median transaction amount| 9.25| 22.00

The average fraudulent transaction amount was higher than the average legitimate transaction amount, while the median fraudulent amount was lower.

Business implication: The difference between average and median suggests that some larger transactions may influence the fraud average. Therefore, transaction monitoring should not rely only on a fixed high-amount threshold.

A low-value transaction can also be fraudulent.

Insight 3: Fraud accounts for a small share of total transaction value

The total amount associated with fraudulent transactions was 60,127.97, compared with 25,102,462.04 for legitimate transactions.

The fraudulent transaction amount represented approximately 0.239% of the combined transaction amount in this dataset.

Business implication: Fraud monitoring should consider both the number of suspicious transactions and their financial value. However, this percentage represents the value associated with transactions labelled as fraud in the dataset; it should not automatically be treated as a confirmed accounting loss or recovered amount.

Insight 4: Some fraudulent transactions have very low or zero amounts

I found 27 fraudulent records with an "Amount" of zero. The minimum positive fraudulent transaction amount was 0.01.

Business implication: A fraud monitoring process should not automatically ignore low-value transactions. Small transactions may deserve investigation when combined with other suspicious signals.

The zero-amount records should also be reviewed to understand their context before making assumptions about them.

Insight 5: Fraud rates can vary across time intervals

I grouped the "Time" column into six-hour intervals to compare fraud activity over time.

In the first interval, from 0 to 21,599 elapsed seconds:

- Total transactions: 12,338
- Fraudulent transactions: 55
- Fraud rate: approximately 0.446%

This is higher than the overall dataset fraud rate of approximately 0.173%. However, this single interval alone does not establish a recurring fraud pattern. Other intervals and the dataset's time limitations must also be considered.

Business implication: Time-based monitoring may help identify periods that deserve closer investigation, but operational rules should be based on validated patterns rather than one interval's result.

7. Business Decisions and Recommendations

The analysis supports the following recommendations. These are proposed actions, not proof that a fraud prevention system has already reduced losses.

Decision 1: Use risk-based transaction monitoring

Do not flag transactions solely because their amounts are high or low. Consider multiple available signals and investigate transactions that show unusual combinations of characteristics.

Decision 2: Prioritize investigation using both frequency and value

Maintain separate views of:

- Number of detected fraud transactions
- Total amount associated with detected fraud
- Average and median transaction amounts
- Individual high-value fraud cases

This helps an investigation team understand both the frequency and potential financial importance of cases.

Decision 3: Investigate suspicious low-value transactions

Avoid treating small transactions as automatically safe. Review low-value and zero-value fraud records to understand whether they have useful investigative patterns.

Decision 4: Monitor fraud rates over time

Use time-interval reporting to identify potential changes in fraud activity. Compare multiple intervals and account for differences in transaction volume before changing staffing or monitoring rules.

Decision 5: Establish a duplicate-review process

Investigate duplicate records before removing them. Confirm whether they are genuine duplicate entries, repeated legitimate transactions, or another type of data issue.

Decision 6: Build a fraud investigation dashboard

Give fraud analysts a view of fraud counts, amounts, time patterns, and transaction details. This can support prioritization and make historical patterns easier to review.

8. Project Limitations

- The analysis is based on historical labelled transactions and does not prove how a new transaction will behave.
- The project does not include a trained machine learning model or real-time fraud detection system.
- The dataset's "V1"–"V28" features are anonymized, limiting direct business interpretation.
- Duplicate records require context before removal.
- The time column represents elapsed seconds, not a verified time of day or calendar timestamp.
- A transaction labelled as fraud is not necessarily equal to a confirmed financial loss.
- The findings may not generalize to other banks, regions, time periods, or transaction populations.
- The analysis does not measure the effect of implementing the recommended actions.

9. Future Improvements

Improvement 1: Develop stronger SQL analysis

Add reusable queries for fraud trends, transaction amount bands, time-based comparisons, and investigation summaries. Validate each result against the source data.

Improvement 2: Improve dashboard usability

Add clearly defined filters, tooltips, transaction-level detail, and comparisons between fraud counts, fraud rates, and transaction amounts.

Improvement 3: Investigate anomalies and data quality

Review duplicate records, zero-value transactions, unusual amounts, and unexpected changes in transaction patterns before turning them into business rules.

Improvement 4: Add statistical validation

Compare fraud rates across all time intervals, account for transaction volume, and test whether observed differences are meaningful rather than relying on a single high rate.

Improvement 5: Develop a machine learning model as a separate future project

A future extension could train and evaluate a fraud classification model using a separate, clearly documented workflow. Because fraud is rare, evaluation should consider precision, recall, PR-AUC, and the operational cost of false alerts rather than accuracy alone.

This would be a future enhancement; it is not part of the current analytics project.

Improvement 6: Explore near-real-time monitoring

With access to an appropriate data pipeline and transaction feed, a future version could refresh fraud monitoring metrics more frequently and send suspicious cases for review. This would require additional infrastructure, validation, and security controls.

10. Conclusion

This project demonstrates how Excel, Python, MySQL, and Power BI can be combined to analyze a large transaction dataset and communicate findings through business-focused reporting.

The analysis identified 492 fraudulent transactions out of 284,807 records, examined transaction amount differences, reviewed duplicate and missing-value checks, and explored fraud activity across time intervals.

The most important takeaway is that fraud analysis should not depend on a single threshold or metric. Transaction frequency, financial value, time patterns, data quality, and investigation priorities should be considered together.

The project delivers descriptive analytics and decision-support recommendations, not an automated fraud prediction system.

11. Repository Structure

A suggested GitHub repository structure:

credit-card-fraud-analytics/
│
├── README.md
├── data/
│   └── README.md
├── python/
│   └── fraud_analysis.ipynb
├── sql/
│   └── fraud_analysis.sql
├── powerbi/
│   └── credit_card_fraud_dashboard.pbix
└── screenshots/
    └── dashboard_overview.png

Update the filenames to match the files actually included in your repository.

Dataset and privacy note

The original dataset is publicly available through the ULB credit card fraud detection dataset. Follow its applicable terms and attribution requirements when redistributing it. If the dataset is large or redistribution is restricted, include instructions for obtaining it rather than committing the raw CSV.

How to reproduce the analysis

1. Obtain the dataset from its original source.
2. Run the Python notebook to inspect the data and reproduce the documented checks.
3. Import the dataset into MySQL and run the SQL analysis.
4. Open the Power BI file and refresh the data source if required.
5. Compare the reproduced KPI values with those documented in this README.

The project should be considered reproducible only after the notebook, SQL file, and Power BI file have been saved and tested in the repository.
