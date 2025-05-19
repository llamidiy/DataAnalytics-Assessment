SELECT *
FROM (
  SELECT 
    owner_id, 
    name, 
    savings_count, 
    investment_count, 
    total_deposit
  FROM (
    SELECT 
      p.owner_id, 
      savings_count, 
      investment_count, 
      plans_deposit, 
      savings_deposit, 
      (plans_deposit + savings_deposit) AS total_deposit
    FROM (
      SELECT 
        owner_id, 
        SUM(is_a_fund) AS investment_count, 
        SUM(is_regular_savings) AS savings_count, 
        SUM(amount) AS plans_deposit
      FROM plans_plan
      WHERE amount > 0
      GROUP BY 1
    ) p
    INNER JOIN (
      SELECT 
        owner_id, 
        SUM(confirmed_amount) AS savings_deposit
      FROM savings_savingsaccount
      WHERE transaction_status = 'success' AND amount > 0
      GROUP BY 1
    ) s
    ON p.owner_id = s.owner_id
  ) a
  LEFT JOIN (
    SELECT 
      id, 
      CONCAT(first_name, ' ', last_name) AS name
    FROM users_customuser
  ) b
  ON a.owner_id = b.id
) c
WHERE savings_count > 0 AND investment_count > 0
ORDER BY 5 DESC;

	


