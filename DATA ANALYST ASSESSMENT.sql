-- Account Inactivity Alert--
-- THE SAVINGS ACCT WAS UNION ALL WITH INVESTMNET ACCT SO AS TO CONFIRM THE EACH TABLE ALSO CONFIRM THE
SELECT DISTINCT transaction_status FROM savings_savingsaccount;
SELECT DISTINCT status_id FROM plans_plan;
SELECT 
    p.id AS plan_id,
    p.owner_id,
    'Investment' AS type,
    MAX(p.last_charge_date) AS last_transaction_date,
    DATEDIFF(CURRENT_DATE, MAX(p.last_charge_date)) AS inactivity_days
FROM plans_plan p
WHERE p.status_id = '1'  -- assuming '1' is active/funded
GROUP BY p.id, p.owner_id
HAVING inactivity_days > 365;

SELECT 
    s.id AS plan_id,
    s.owner_id,
    'Savings' AS type,
    MAX(s.transaction_date) AS last_transaction_date,
    DATEDIFF(CURRENT_DATE, MAX(s.transaction_date)) AS inactivity_days
FROM savings_savingsaccount s
WHERE s.transaction_status IN ('success', 'successful', 'monnify_success')
GROUP BY s.id, s.owner_id
HAVING inactivity_days > 365

UNION ALL

SELECT 
    p.id AS plan_id,
    p.owner_id,
    'Investment' AS type,
    MAX(p.last_charge_date) AS last_transaction_date,
    DATEDIFF(CURRENT_DATE, MAX(p.last_charge_date)) AS inactivity_days
FROM plans_plan p
WHERE p.status_id = '1'
GROUP BY p.id, p.owner_id
HAVING inactivity_days > 365;