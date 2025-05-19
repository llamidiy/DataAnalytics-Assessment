SELECT 
    a.id AS customer_id, 
    a.name, 
    a.tenure_months, 
    b.total_transactions, 
    ROUND(
        (b.total_transactions / NULLIF(a.tenure_months, 0)) * 12 * b.avg_profit_per_transaction
    ) AS estimated_clv
FROM (
    SELECT 
        id, 
        CONCAT(first_name, ' ', last_name) AS name, 
        TIMESTAMPDIFF(MONTH, date_joined, CURDATE()) AS tenure_months
    FROM users_customuser
) a
LEFT JOIN (
    SELECT 
        owner_id, 
        COUNT(savings_id) AS total_transactions, 
        AVG(confirmed_amount) * 0.001 AS avg_profit_per_transaction
    FROM savings_savingsaccount
    GROUP BY owner_id
) b ON a.id = b.owner_id
GROUP BY 
    a.id, 
    a.name, 
    a.tenure_months, 
    b.total_transactions
ORDER BY 5 DESC;