UPDATE w_users SET password = '$2y$10$cMli0FX/KVWn4ewJpkeN7uO8TquFJeROCWxodK/22mbrn7c/URgVm' WHERE username IN ('admin', 'agent', 'distributor', 'manager', 'cashier');
SELECT id, username, LENGTH(password) as pwd_length FROM w_users WHERE username = 'admin';
