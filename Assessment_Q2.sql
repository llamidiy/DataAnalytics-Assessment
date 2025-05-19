WITH monthly_transactions AS (
    SELECT
        owner_id,
        DATE_FORMAT(transaction_date, '%Y-%m') AS month,
        COUNT(*) AS transactions_in_month
    FROM savings_savingsaccount
    GROUP BY owner_id, DATE_FORMAT(transaction_date, '%Y-%m')
),
average_transactions AS (
    SELECT
        owner_id,
        AVG(transactions_in_month) AS avg_tx_per_month
    FROM monthly_transactions
    GROUP BY owner_id
),
categorized_owners AS (
    SELECT
        CASE 
            WHEN avg_tx_per_month >= 10 THEN 'High Frequency'
            WHEN avg_tx_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category,
        avg_tx_per_month
    FROM average_transactions
)
SELECT
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_tx_per_month), 1) AS avg_transactions_per_month
FROM categorized_owners
GROUP BY frequency_category
ORDER BY 3 DESC;
 