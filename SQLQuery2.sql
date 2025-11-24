CREATE DATABASE EmployeeData;

USE EmployeeData;

SELECT TOP 10 * FROM EmployeeData;

CREATE VIEW vw_EmployeeAttrition AS
SELECT 
    EmployeeNumber AS EmployeeID,
    Age,
    CASE 
        WHEN Age < 30 THEN 'Young'
        WHEN Age BETWEEN 30 AND 45 THEN 'Mid'
        ELSE 'Senior'
    END AS AgeGroup,
    Department,
    Attrition,
    MonthlyIncome
FROM EmployeeData;

CREATE TABLE DimEmployee (
    EmployeeID INT PRIMARY KEY,
    Gender NVARCHAR(20),
    MaritalStatus NVARCHAR(20),
    Education INT,
    YearsAtCompany INT
);

INSERT INTO DimEmployee
SELECT DISTINCT EmployeeNumber, Gender, MaritalStatus, Education, YearsAtCompany
FROM EmployeeData;



CREATE VIEW DimDepartment AS
SELECT DISTINCT Department FROM EmployeeData;

INSERT INTO DimDepartment (Department)
SELECT DISTINCT Department FROM EmployeeData;


CREATE VIEW DimJobRole AS
SELECT DISTINCT JobRole FROM EmployeeData;

CREATE VIEW DimAgeGroup AS
SELECT DISTINCT 
    CASE 
        WHEN Age < 30 THEN 'Young'
        WHEN Age BETWEEN 30 AND 45 THEN 'Mid'
        ELSE 'Senior'
    END AS AgeGroup
FROM EmployeeData;

CREATE VIEW FactEmployeeAttrition AS
SELECT 
    E.EmployeeNumber AS EmployeeID,
    CASE WHEN E.Attrition = 'Yes' THEN 1 ELSE 0 END AS AttritionFlag,
    E.MonthlyIncome,
    E.Department,
    E.JobRole,
    CASE 
        WHEN E.Age < 30 THEN 'Young'
        WHEN E.Age BETWEEN 30 AND 45 THEN 'Mid'
        ELSE 'Senior'
    END AS AgeGroup
FROM EmployeeData E;

SELECT name 
FROM sys.views 
WHERE name LIKE 'Dim%';

SELECT EmployeeNumber, COUNT(*)
FROM EmployeeData
GROUP BY EmployeeNumber
HAVING COUNT(*) > 1;