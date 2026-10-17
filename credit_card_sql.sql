select count(*) from creditcard;

select Class, count(*) as transaction_count from creditcard group by Class;

select Class,  round(sum(Amount),2) as total_amount, round(avg(Amount),2) as average_amount from creditcard group by Class;

-- 1 Overall Fraud KPIS
select count(*) as total_transactions, sum(case when Class = 1 then 1 else 0 end )
as fraud_transaction,
sum(case when Class = 0 then 1 else 0 end ) as normal_transactions, 
round(100.0 * sum(case when Class = 1 then 1 else 0 end ) / count(*), 4)as fraud_rate_percent from creditcard;

-- 2 Fraud vs Normal Amount Comparison
select Class, count(*) as transaction_count, round(sum(Amount),2) as total_amount, 
round(avg(Amount),2) as average_amount, 
round(min(Amount),2) as minimum_amount,
round(max(Amount),2) as maximum_amount 
from creditcard group by Class order by Class;

-- 3 Low - Value Fraud transactions 
select case when Amount <= 100 then '100 or less' 
else 'Above 100'
end as amount_group, 
count(*) as fraud_transactions, round(100.0*count(*) / 492,2) as percent_of_fraud
from creditcard where Class=1 group by amount_group;

-- 4 Six - Hour Interval Analysis 
select floor(time / 21600) as six_hour_interval, count(*) as total_transactions, sum(case when Class = 1 then 1 else 0 end)
as fraud_transactions, 
round(100.0* sum(case when Class = 1 then 2 else 0 end )/ count(*),4) as fraud_rate_percent from creditcard group by floor(Time/21600)
order by six_hour_interval;

-- 5 Duplicate Data Quality Check
select count(*) as duplicate_rows from ( select Time, V1,V2,V3,V4,V5,V6,V7,V8,V9,V10,V11,V12,
V13,V14,V15,V16,V17,V18,V19,V20,V21,V22,V23,V24,V25,V26,V27,V28,Amount,Class, count(*) as row_count from creditcard
group by Time,V1,V2,V3,V4,V5,V6,V7,V8,V9,V10,V11,V12,
V13,V14,V15,V16,V17,V18,V19,V20,V21,V22,V23,V24,V25,V26,V27,V28,Amount,Class having count(*) > 1 ) as duplicates;

--  6 CTE Fraud Summary
with transaction_summary as (select Class, count(*) as transaction_count, 
sum(Amount) as total_amount, avg(Amount) as average_amount from creditcard
group by Class
)
select case when Class = 1 then 'Fraud' else 'Normal' end as transaction_type, transaction_count, 
round(total_amount,2) as total_amount ,round(average_amount,2) as average_amount from transaction_summary
order by Class;

-- 7 Window Function Overall fraud Share 
with class_counts as (
select Class, count(*) as transaction_count from creditcard group by Class 
)
select Class, transaction_count, round(100.0 * transaction_count / sum(transaction_count)over (),4) 
as percentage_of_all_transactions from class_counts;

-- 8 highest Fraud Amounts Ranks
select Time, Amount,rank() over(order by Amount desc ) as amount_rank from creditcard
where Class =1 order by Amount desc limit 10;

-- Find Six Hours Fraud Rate on Rank 
with interval_summary as (
select floor(Time / 21600) as  interval_id, count(*) as total_transactions, 
sum(case when Class = 1 then 1 else 0 end) as fraud_count from creditcard 
group by floor(Time / 21600)
), 
interval_rates as (
select interval_id, total_transactions, fraud_count, 100.0 * fraud_count / total_transactions
 as fraud_rate from interval_summary
)
select interval_id, total_transactions,fraud_count, round(fraud_rate,4) as fraud_rate_percent, 
rank() over(order by fraud_rate desc) as fraud_rate_rank from interval_rates order by fraud_rate_rank;

-- Fraud aur Noraml Median Amount 
with ranked_amounts as (
select Class,Amount,ROW_NUMBER() over(partition by Class order by Amount ) as row_num,
count(*) over (partition by Class ) as total_rows
from creditcard 
)
select Class, round(avg(Amount),2) as median_amount from ranked_amounts where row_num in (
floor((total_rows + 1) / 2), 
floor((total_rows + 2) / 2))
group by Class order by Class;