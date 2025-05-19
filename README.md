# DataAnalytics-Assessment

## Question 1

To identify cross-selling opportunities, I analyzed customers who have both a funded savings and investment plan. I first aggregated data from the plans_plan table to count each customer's investment and savings plans and sum their deposits. Then, I joined this with the savings_savingsaccount table to calculate additional savings deposits from successful transactions. I combined these totals to get each customer's overall deposit amount, joined with user details from users_customuser, and filtered for customers with at least one funded plan of each type. The final results are sorted by total deposits, highlighting the most engaged customers.

## Question 2

To help the finance team segment customers based on how often they transact, I calculated the average number of transactions per customer per month using data from the savings_savingsaccount table. For each customer, I counted successful transactions, determined the active number of months they transacted, and computed their monthly average. Based on this average, I categorized customers into "High Frequency" (≥10 transactions/month), "Medium Frequency" (3–9 transactions/month), and "Low Frequency" (≤2 transactions/month). Finally, I grouped the results by these categories to report the total number of customers and their average transaction frequency.

## Question 3

To help the operations team identify dormant accounts, using data from the plans_plan and savings_savingsaccount tables, I first retrieved each plan’s most recent transaction date (if any) with a positive amount. I then calculated the number of days since that transaction using the current date. Finally, we filtered out all plans with inactivity periods longer than one year, listing their details along with the number of inactive days.

## Question 4

To help the marketing team estimate Customer Lifetime Value (CLV), I first calculated the number of months since each user signed up (tenure) and counted their total successful transactions. Assuming a 0.1% profit per transaction, I estimated CLV using the formula:
CLV = (total_transactions / tenure) × 12 × average profit per transaction.
Finally, I ranked customers by estimated CLV in descending order to highlight the most valuable ones.
