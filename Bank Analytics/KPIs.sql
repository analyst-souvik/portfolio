USE `Bank Loan of Customers`;
select * from finance limit 2;

## KPI 1
SELECT 
    YEAR(`issue dates`) AS `Issued Year`,
    CONCAT(ROUND(SUM(`loan amount`) / 1000000, 2),
            'M') AS `Total Loan Amount`
FROM
    Finance
GROUP BY `Issued Year`
ORDER BY `Issued Year`;

## KPI 2
SELECT 
    grade,
    `sub grade`,
    CONCAT(ROUND(SUM(`revolve balance`) / 1000000, 2),
            'M') AS `Revolve Balance`
FROM
    finance
GROUP BY 1 , 2
ORDER BY 1 , 2 ASC;

## KPI 3
SELECT 
    `verification status`,
    CONCAT(ROUND(SUM(`total payments`) / 1000000, 2),
            'M') AS `Total Payments`
FROM
    finance
GROUP BY 1;

## KPI 4
SELECT 
    state, `last credit pull dates`, `loan status`
FROM
    finance
GROUP BY 1 , 2 , 3
ORDER BY 2;

## KPI 5
select `home ownership`,
`last payment dates`,
CONCAT(ROUND(SUM(`revolve balance`) / 1000, 2),'K') AS `Revolving Balance`
            from finance
            group by 1,2
            order by 1,2;