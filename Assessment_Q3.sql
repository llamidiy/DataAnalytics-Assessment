SELECT * 
FROM (
    SELECT 
        a.plan_id, 
        a.owner_id, 
        a.type, 
        DATE(b.last_transaction_date) AS last_transaction_date, 
        DATEDIFF(CURDATE(), b.last_transaction_date) AS inactivity_days  
    FROM (
        SELECT 
            id AS plan_id,
            owner_id,
            description AS type
        FROM plans_plan
    ) a
    LEFT JOIN (
        SELECT
            plan_id,
            MAX(transaction_date) AS last_transaction_date
        FROM savings_savingsaccount
        WHERE amount > 0 
        GROUP BY plan_id
    ) b ON a.plan_id = b.plan_id
) c  
WHERE inactivity_days > 365;
