create database `hr analytics`;
use `hr analytics`;

#KPI 1:- Average Attrition Rate for All Department
SELECT 
    Department,
    ROUND((SUM(CASE
                WHEN Attrition = 'Yes' THEN 1
                ELSE 0
            END) * 100.0 / COUNT(*)),
            1) AS `Attrition Rate %`
FROM
    hr1
GROUP BY department
ORDER BY department DESC;

#KPI 2:- Average Hourly Rate for Male Research Scientist
SELECT 
    JobRole,
    Gender,
    ROUND(AVG(HourlyRate), 2) AS `Avg. Hourly Rate`
FROM
    HR1
WHERE
    Gender = 'Male'
        AND JobRole = 'Research Scientist';

#KPI 3:-  AttritionRate VS MonthlyIncomeStats against department
SELECT 
    Department,
    ROUND((SUM(CASE
                WHEN Attrition = 'Yes' THEN 1
                ELSE 0
            END) * 100.0 / COUNT(*)),
            1) AS `Attrition Rate %`,
    ROUND(AVG(hr2.MonthlyIncome), 2) AS `Avg. Monthly Income`
FROM
    hr1
        JOIN
    hr2 ON hr1.EmployeeNumber = hr2.`Employee ID`
GROUP BY hr1.Department;

#KPI 4:- Average working years for each Department
SELECT 
    HR1.Department,
    ROUND(AVG(HR2.TotalWorkingYears), 0) AS `Average Working Years`
FROM
    HR1
        JOIN
    HR2 ON hr1.EmployeeNumber = hr2.`Employee ID`
GROUP BY HR1.Department
ORDER BY `Average Working Years` DESC;

#KPI 5:- Job Role Vs Work life balance
SELECT 
    HR1.JobRole,
    ROUND(AVG(HR2.WorkLifeBalance), 2) AS `Avg. Work Life Balance`
FROM
    HR1
        JOIN
    HR2 ON hr1.EmployeeNumber = hr2.`Employee ID`
GROUP BY HR1.JobRole
ORDER BY `Avg. Work Life Balance` DESC;

#KPI 6:- 
SELECT 
    HR2.YearsSinceLastPromotion,
    ROUND((SUM(CASE
                WHEN Attrition = 'Yes' THEN 1
                ELSE 0
            END) * 100.0 / COUNT(*)),
            1) AS `Yes Attribution Rate %`,
    ROUND((SUM(CASE
                WHEN Attrition = 'No' THEN 1
                ELSE 0
            END) * 100.0 / COUNT(*)),
            1) AS `No Attribution Rate %`
FROM
    HR1
        JOIN
    HR2 ON hr1.EmployeeNumber = hr2.`Employee ID`
GROUP BY HR2.YearsSinceLastPromotion
ORDER BY HR2.YearsSinceLastPromotion;