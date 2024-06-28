--Convert Name column to proper case

UPDATE healthcare
SET Name = 
    UPPER(SUBSTRING(Name, 1, 1)) + 
    LOWER(SUBSTRING(Name, 2, LEN(Name)))
WHERE Name IS NOT NULL;

--round off the billing amounts decimal

UPDATE healthcare
SET billing_amount = ROUND(billing_amount, 2);

--Check the datatype for all the values

SELECT 
    COLUMN_NAME, 
    DATA_TYPE, 
    CHARACTER_MAXIMUM_LENGTH, 
    NUMERIC_PRECISION, 
    NUMERIC_SCALE
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME = 'healthcare';

--change billing amount data type

ALTER TABLE healthcare
ALTER COLUMN Billing_Amount DECIMAL(10, 2);



--delete unwanted columns

ALTER TABLE healthcare
DROP COLUMN Date_of_Admission, Room_Number, Discharge_Date ;

--check the age of people in specific age intervals and count the number of people in each interval

SELECT 
    CASE 
        WHEN Age BETWEEN 0 AND 17 THEN '0-17'
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Age BETWEEN 46 AND 55 THEN '46-55'
        WHEN Age BETWEEN 56 AND 65 THEN '56-65'
        ELSE '66 and above'
    END AS Age_interval,
    COUNT(*) AS count
FROM 
    healthcare
GROUP BY 
    CASE 
        WHEN Age BETWEEN 0 AND 17 THEN '0-17'
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Age BETWEEN 46 AND 55 THEN '46-55'
        WHEN Age BETWEEN 56 AND 65 THEN '56-65'
        ELSE '66 and above'
    END
ORDER BY 
    Age_interval;

--Count 

SELECT 
    Gender,
    Blood_Type,
    Medical_Condition,
    Insurance_Provider,
    Admission_Type,
    Medication,
    Test_Results,
    COUNT(*) AS count
FROM 
    healthcare
GROUP BY 
    Gender,
    Blood_Type,
    Medical_Condition,
    Insurance_Provider,
    Admission_Type,
    Medication,
    Test_Results;


--Count Gender

SELECT
    Gender,
	COUNT (*) AS count
FROM
	healthcare
GROUP BY
	Gender;

--Count bloodtype

SELECT 
    Blood_Type,
    COUNT(*) AS count
FROM
    healthcare
GROUP BY
    Blood_Type;

--Count for the medical condition

SELECT
    Medical_Condition,
	COUNT (*) AS count
FROM
	healthcare
GROUP BY
	Medical_Condition;

--count insurance provider

SELECT
    Insurance_Provider,
	COUNT (*) AS count
FROM
	healthcare
GROUP BY
	Insurance_Provider;

--Count admission type

SELECT
    Admission_Type,
	COUNT (*) AS count
FROM
	healthcare
GROUP BY
	Admission_type;

--Count Medication

SELECT
    Medication,
	COUNT (*) AS count
FROM
	healthcare
GROUP BY
	Medication;

--count test results

SELECT
    Test_Results,
	COUNT (*) AS count
FROM
	healthcare
GROUP BY
	Test_Results;

--Count for the hospital


SELECT
    Hospital,
	COUNT (*) AS count
FROM
	healthcare
GROUP BY
	Hospital;


--check which doctor comes up the most 

SELECT 
    Doctor, 
    COUNT(*) AS count
FROM 
    healthcare
GROUP BY 
    Doctor
HAVING 
    COUNT(*) > 1;

--show more details about doctors who come up the most

WITH DuplicateDoctors AS (
    SELECT 
        Doctor, 
        COUNT(*) AS count
    FROM 
        healthcare
    GROUP BY 
        Doctor
    HAVING 
        COUNT(*) > 1
)
SELECT 
    h.*
FROM 
    healthcare h
JOIN 
    DuplicateDoctors d
ON 
    h.Doctor = d.Doctor;

--Average billing by Medical condition

SELECT 
    Medical_Condition, 
    AVG(Billing_Amount) AS Average_Billing_Amount
FROM 
    healthcare
GROUP BY 
    Medical_Condition;






SELECT *
FROM healthcare