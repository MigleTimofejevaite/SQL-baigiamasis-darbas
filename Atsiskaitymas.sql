USE hrcompany;

-- 1. Pasirinkite visus darbuotojus: parašykite SQL užklausą, kuri gautų visus darbuotojų
-- įrašus iš Employees lentelės.

SELECT * 
FROM employees;

-- 2. Pasirinkite tam tikrus stulpelius: parodykite visus vardus ir pavardes iš Employees lentelės.

SELECT FirstName, LastName 
FROM employees;

-- 3. Filtruokite pagal skyrius: gaukite darbuotojų sąrašą, kurie dirba HR skyriuje
-- (department lentelė).

SELECT 
	FirstName, 
    LastName, 
    DepartmentName
FROM departments AS d
LEFT JOIN employees AS e
	ON d.DepartmentID = e.DepartmentID
WHERE DepartmentName = 'HR';

-- 4. Surikiuokite darbuotojus: gaukite darbuotojų sąrašą, surikiuotą pagal jų įdarbinimo
-- datą didėjimo tvarka.

SELECT * 
FROM employees
ORDER BY HireDate ASC;

-- 5. Suskaičiuokite darbuotojus: raskite kiek iš viso įmonėje dirba darbuotojų.

SELECT 
	COUNT(*) AS total_employees 
FROM employees;

-- 6. Sujunkite darbuotojus su skyriais: išveskite bendrą darbuotojų sąrašą, šalia
-- kiekvieno darbuotojo nurodant skyrių kuriame dirba.

SELECT FirstName, LastName, DepartmentName
FROM departments AS d
JOIN employees AS e
	ON d.DepartmentID = e.DepartmentID;

-- 7. Apskaičiuokite vidutinį atlyginimą: suraskite koks yra vidutinis atlyginimas
-- įmonėje tarp visų darbuotojų.

SELECT AVG(SalaryAmount)
FROM salaries;

-- 8. Išfiltruokite ir suskaičiuokite: raskite kiek darbuotojų dirba IT skyriuje.

SELECT 
	DepartmentName,
    COUNT(*) AS kiekis
FROM departments AS d
LEFT JOIN employees AS e
	ON d.DepartmentID = e.DepartmentID
WHERE DepartmentName = 'IT'
GROUP BY DepartmentName;

-- 9. Išrinkite unikalias reikšmes: gaukite unikalių siūlomų darbo pozicijų sąrašą iš
-- jobpositions lentelės.

SELECT DISTINCT PositionTitle
FROM jobpositions;

-- 10. Išrinkite pagal datos rėžį: gaukite darbuotojus, kurie buvo nusamdyti tarp 2020-02-
-- 01 ir 2020-11-01.

SELECT FirstName, LastName, HireDate
FROM employees
WHERE HireDate BETWEEN '2020-02-01' AND '2020-11-01';

-- 11. Darbuotojų amžius: gaukite kiekvieno darbuotojo amžių pagal tai kada jie yra gimę.

SELECT 
	FirstName, 
    LastName, 
    DateOfBirth, 
    ROUND((DATEDIFF(CURDATE(), DateOfBirth)/365.25), 0) AS amzius
FROM employees;

-- 12. Darbuotojų el. pašto adresų sąrašas: gaukite visų darbuotojų el. pašto adresų sąrašą
-- abėcėline tvarka.

SELECT Email
FROM employees
ORDER BY Email;

-- 13. Darbuotojų skaičius pagal skyrių: suraskite kiek kiekviename skyriuje dirba
-- darbuotojų.

SELECT 
	Departments.DepartmentName,
    COUNT(*) AS kiek
FROM Employees 
JOIN Departments 
	ON Employees.DepartmentID = Departments.DepartmentID
GROUP BY Departments.DepartmentName;

-- 14. Darbštus darbuotojas: išrinkite visus darbuotojus, kurie turi daugiau nei 3 įgūdžius
-- (skills).

SELECT *
FROM employees AS e
LEFT JOIN employeeskills AS es
	ON e.EmployeeID = es.EmployeeID
LEFT JOIN skills AS s
	ON es.SkillID = s.SkillID;
    
SELECT 
	e.EmployeeID,
	COUNT(SkillName) AS kiek_igudziu
FROM employees AS e
LEFT JOIN employeeskills AS es
	ON e.EmployeeID = es.EmployeeID
LEFT JOIN skills AS s
	ON es.SkillID = s.SkillID
GROUP BY e.EmployeeID
HAVING COUNT(SkillName) > 3;

-- 15. Vidutinė papildomos naudos kaina: apskaičiuokite vidutines papildomų naudų
-- išmokų (benefits lentelė) išlaidas darbuotojams.

SELECT AVG(Cost)
FROM benefits;

-- 16. Jaunausias ir vyriausias darbuotojai: suraskite jaunausią ir vyriausią darbuotoją
-- įmonėje.

SELECT *
FROM employees
ORDER BY DateOfBirth DESC
LIMIT 1;

SELECT *
FROM employees
ORDER BY DateOfBirth ASC
LIMIT 1;

-- 17. Skyrius su daugiausiai darbuotojų: suraskite kuriame skyriuje dirba daugiausiai
-- darbuotojų.

SELECT 
	DepartmentID, 
	COUNT(*) AS kiek
FROM employees
GROUP BY departmentid
ORDER BY kiek DESC;

SELECT *
FROM (SELECT 
	DepartmentID,
    COUNT(*) AS kiek
FROM employees 
GROUP BY departmentid
ORDER BY kiek DESC) AS employees
JOIN departments AS d
	ON d.DepartmentID = employees.DepartmentID
ORDER BY kiek;

-- 18. Tekstinė paieška: suraskite visus darbuotojus su žodžiu “excellent” jų darbo
-- atsiliepime (performancereviews lentelė).

SELECT *
FROM performancereviews
WHERE ReviewText LIKE '%excellent%';

SELECT *
FROM performancereviews AS p
LEFT JOIN employees AS e
	ON e.EmployeeID = p.EmployeeID;
    
SELECT
	FirstName, 
    LastName,
    ReviewText
FROM performancereviews AS p
LEFT JOIN employees AS e
	ON e.EmployeeID = p.EmployeeID 
WHERE ReviewText LIKE '%excellent%';

-- 19. Darbuotojų telefono numeriai: išveskite visų darbuotojų ID su jų telefono
-- numeriais.

SELECT 
	EmployeeID,
    Phone
FROM employees;

-- 20. Darbuotojų samdymo mėnesis: suraskite kurį mėnesį buvo nusamdyta daugiausiai
-- darbuotojų.

SELECT
	MONTH(HireDate) AS menesis,
	COUNT(MONTH(HireDate)) AS kiek
FROM employees
GROUP BY MONTH(HireDate)
LIMIT 1;

-- 21. Darbuotojų įgūdžiai: išveskite visus darbuotojus, kurie turi įgūdį “Communication”.

SELECT 
	FirstName, 
    LastName,
    SkillName
FROM employees AS e
LEFT JOIN employeeskills AS es
	ON e.EmployeeID = es.EmployeeID
LEFT JOIN skills AS s
	ON es.SkillID = s.SkillID
WHERE SkillName LIKE '%communication%';

-- 22. Sub-užklausos: suraskite kuris darbuotojas įmonėje uždirba daugiausiai ir išveskite
-- visą jo informaciją.

SELECT MAX(SalaryAmount) FROM salaries;

SELECT *
FROM employees AS e
LEFT JOIN salaries AS s
	ON e.EmployeeID = s.EmployeeID
WHERE SalaryAmount = (SELECT MAX(SalaryAmount) FROM salaries);

-- 23. Grupavimas ir agregacija: apskaičiuokite visas įmonės išmokų (benefits lentelė)
-- išlaidas.

SELECT SUM(Cost)
FROM benefits;

-- 24. Įrašų atnaujinimas: atnaujinkite telefono numerį darbuotojo, kurio id yra 1.

UPDATE employees
SET Phone = '555-555-5554'
WHERE EmployeeID = 1;

-- 25. Atostogų užklausos: išveskite sąrašą atostogų prašymų (leaverequests), kurie laukia
-- patvirtinimo.

SELECT *
FROM leaverequests
WHERE Status = 'Pending' and LeaveType = 'Vacation';

-- 26. Darbo atsiliepimas: išveskite darbuotojus, kurie darbo atsiliepime yra gavę 5 balus.

SELECT
	FirstName, 
    LastName,
    Rating
FROM performancereviews AS p
LEFT JOIN employees AS e
	ON e.EmployeeID = p.EmployeeID 
WHERE Rating = 5;

-- 27. Papildomų naudų registracijos: išveskite visus darbuotojus, kurie yra užsiregistravę
-- į “Health Insurance” papildomą naudą (benefits lentelė).

SELECT 
	FirstName, 
    LastName,
    BenefitName
FROM employees AS e
JOIN employeebenefits AS eb
	ON e.EmployeeID = eb.EmployeeID
JOIN benefits AS b
	ON eb.BenefitID = b.BenefitID
WHERE BenefitName = 'Health Insurance';

-- 28. Atlyginimų pakėlimas: parodykite kaip atrodytų atlyginimai darbuotojų, dirbančių
-- “Finance” skyriuje, jeigu jų atlyginimus pakeltume 10 %.

SELECT 
	FirstName, 
    LastName,
    SalaryAmount,
    SalaryAmount * 1.10 AS '+10%',
    DepartmentName
FROM departments AS d
JOIN employees AS e
	ON d.DepartmentID = e.DepartmentID
JOIN salaries AS s
	ON e.EmployeeID = s.EmployeeID
WHERE DepartmentName = 'Finance';

-- 29. Efektyviausi darbuotojai: raskite 5 darbuotojus, kurie turi didžiausią darbo
-- vertinimo (performance lentelė) reitingą.

SELECT
	FirstName, 
    LastName,
    Rating
FROM performancereviews AS p
LEFT JOIN employees AS e
	ON e.EmployeeID = p.EmployeeID
ORDER BY Rating DESC
LIMIT 5;

-- 30. Atostogų užklausų istorija: gaukite visą atostogų užklausų istoriją (leaverequests
-- lentelė) darbuotojo, kurio id yra 1.

SELECT * 
FROM leaverequests
WHERE EmployeeID = 1;

-- 31. Atlyginimų diapozono analizė: nustatykite atlyginimo diapazoną (minimalų ir
-- maksimalų) kiekvienai darbo pozicijai.

SELECT *
FROM departments AS d
LEFT JOIN employees AS e
	ON d.DepartmentID = e.DepartmentID
LEFT JOIN salaries AS s
	ON e.EmployeeID = s.EmployeeID;
    
SELECT 
	DepartmentName,
	MIN(SalaryAmount) AS minimalus_atlyginimas,
    MAX(SalaryAmount) AS maksimalus_atlyginimas
FROM departments AS d
LEFT JOIN employees AS e
	ON d.DepartmentID = e.DepartmentID
LEFT JOIN salaries AS s
	ON e.EmployeeID = s.EmployeeID
GROUP BY DepartmentName;

-- 32. Darbo atsiliepimo istorija: gaukite visą istoriją apie darbo atsiliepimus
-- (performancereviews lentelė), darbuotojo, kurio id yra 2.

SELECT * 
FROM performancereviews
WHERE EmployeeID = 2;

-- 33. Papildomos naudos kaina vienam darbuotojui: apskaičiuokite bendras papildomų
-- naudų išmokų išlaidas vienam darbuotojui (benefits lentelė).

SELECT *
FROM employees AS e
JOIN employeebenefits AS eb
	ON e.EmployeeID = eb.EmployeeID
JOIN benefits AS b
	ON eb.BenefitID = b.BenefitID;
    
SELECT 
	e.EmployeeID,
    e.FirstName,
    e.LastName,
    SUM(b.Cost) AS bendros_islaidos
FROM employees AS e
JOIN employeebenefits AS eb
	ON e.EmployeeID = eb.EmployeeID
JOIN benefits AS b
	ON eb.BenefitID = b.BenefitID
GROUP BY 
	e.EmployeeID,
    e.FirstName,
    e.LastName;

-- 34. Geriausi įgūdžiai pagal skyrių: išvardykite dažniausiai pasitaikančius įgūdžius
-- kiekviename skyriuje.

SELECT *
FROM skills AS s
LEFT JOIN employeeskills AS es
	ON es.SkillID = s.SkillID
LEFT JOIN employees AS e
	ON e.EmployeeID = es.EmployeeID
LEFT JOIN departments AS d
	ON e.DepartmentID = d.DepartmentID;

SELECT 
	d.DepartmentName,
    s.SkillName,
	COUNT(SkillName) AS kiek
FROM skills AS s
LEFT JOIN employeeskills AS es
	ON es.SkillID = s.SkillID
LEFT JOIN employees AS e
	ON e.EmployeeID = es.EmployeeID
LEFT JOIN departments AS d
	ON e.DepartmentID = d.DepartmentID
GROUP BY 
    s.SkillName,
    d.DepartmentName
ORDER BY d.DepartmentName, s.SkillName;

-- 35. Atlyginimo augimas: apskaičiuokite procentinį atlyginimo padidėjimą kiekvienam
-- darbuotojui, lyginant su praėjusiais metais.

-- New Salary
SELECT * FROM salaries WHERE YEAR(SalaryStartDate) = 2023;
    
SELECT 
	CONCAT(FirstName, " ", LastName) AS Darbuotojas,
    SalaryAmount
FROM (SELECT * FROM salaries WHERE YEAR(SalaryStartDate) = 2023) AS new_salary
LEFT JOIN employees AS e
	ON e.EmployeeID = new_salary.EmployeeID;

-- Old Salary 
SELECT * FROM salaries WHERE YEAR(SalaryStartDate) = 2022;
   
SELECT *
FROM (SELECT * FROM salaries WHERE YEAR(SalaryStartDate) = 2022) AS old_salary
LEFT JOIN employees AS e
	ON e.EmployeeID = old_salary.EmployeeID;
    
SELECT 
	SalaryAmount
FROM (SELECT * FROM salaries WHERE YEAR(SalaryStartDate) = 2022) AS old_salary
LEFT JOIN employees AS e
	ON e.EmployeeID = old_salary.EmployeeID;

-- Procentinis alyginimo augimas
SELECT
 	naujas.Darbuotojas,
	ROUND((naujas.SalaryAmount - senas.SalaryAmount) / senas.SalaryAmount * 100, 2) AS 'SalaryIncreasePercentage'
FROM (SELECT 
	CONCAT(FirstName, " ", LastName) AS Darbuotojas,
    SalaryAmount
FROM (SELECT * FROM salaries WHERE YEAR(SalaryStartDate) = 2023) AS new_salary
LEFT JOIN employees AS e
	ON e.EmployeeID = new_salary.EmployeeID) AS naujas
JOIN (SELECT 
	CONCAT(FirstName, " ", LastName) AS Darbuotojas,
    SalaryAmount
FROM (SELECT * FROM salaries WHERE YEAR(SalaryStartDate) = 2022) AS old_salary
LEFT JOIN employees AS e
	ON e.EmployeeID = old_salary.EmployeeID) AS senas
    ON naujas.Darbuotojas = senas.Darbuotojas;

-- 36. Darbuotojų išlaikymas: raskite darbuotojus, kurie įmonėje dirba daugiau nei 5 metai
-- ir kuriems per tą laiką nebuvo pakeltas atlyginimas.

SELECT *
FROM employees AS e
LEFT JOIN salaries AS s
	ON e.EmployeeID = s.EmployeeID;

-- Daugiau nei 5m lentele    
SELECT 
	s.SalaryAmount,
	e.EmployeeID,
 	CONCAT(FirstName, " ", LastName) AS Darbuotojas,
    HireDate <= DATE_SUB(CURDATE(), INTERVAL 5 YEAR) AS daugiau_nei_5m
FROM employees AS e
LEFT JOIN salaries AS s
	ON e.EmployeeID = s.EmployeeID
WHERE YEAR(SalaryEndDate) = 2023 AND HireDate <= DATE_SUB(CURDATE(), INTERVAL 5 YEAR) > 0;

-- Pradinis atlyginimas lentele
SELECT 
	CONCAT(FirstName, " ", LastName) AS Darbuotojas,
    SalaryAmount
FROM (SELECT * FROM salaries WHERE YEAR(SalaryStartDate) = 2022) AS old_salary
LEFT JOIN employees AS e
	ON e.EmployeeID = old_salary.EmployeeID;

-- Darbuotojai su tokiu paciu alyginimu per 5m nuo idarbinimo    
SELECT *
FROM (SELECT 
	s.SalaryAmount,
    e.EmployeeID,
 	CONCAT(FirstName, " ", LastName) AS Darbuotojas,
    HireDate <= DATE_SUB(CURDATE(), INTERVAL 5 YEAR) AS daugiau_nei_5m
FROM employees AS e
LEFT JOIN salaries AS s
	ON e.EmployeeID = s.EmployeeID
WHERE YEAR(SalaryEndDate) = 2023 AND HireDate <= DATE_SUB(CURDATE(), INTERVAL 5 YEAR) > 0) AS daugiau
JOIN (SELECT 
	CONCAT(FirstName, " ", LastName) AS Darbuotojas,
    SalaryAmount
FROM (SELECT * FROM salaries WHERE YEAR(SalaryStartDate) = 2022) AS old_salary
LEFT JOIN employees AS e
	ON e.EmployeeID = old_salary.EmployeeID) AS pradinis
 	ON daugiau.Darbuotojas = pradinis.Darbuotojas
WHERE daugiau.SalaryAmount = pradinis.SalaryAmount;

-- 37. Darbuotojų atlyginimų analizė: suraskite kiekvieno darbuotojo atlygį (atlyginimas
-- (salaries lentelė) + išmokos už papildomas naudas (benefits lentelė)) ir surikiuokite
-- darbuotojus pagal bendrą atlyginimą mažėjimo tvarka.

-- naujas atlyginimas
SELECT 
	CONCAT(FirstName, " ", LastName) AS Darbuotojas,
    SalaryAmount
FROM (SELECT * FROM salaries WHERE YEAR(SalaryStartDate) = 2023) AS new_salary
LEFT JOIN employees AS e
	ON e.EmployeeID = new_salary.EmployeeID;
    
-- susumuotos naudos
SELECT 
	CONCAT(FirstName, " ", LastName) AS Darbuotojas,
    SUM(b.Cost) AS bendros_islaidos
FROM employees AS e
JOIN employeebenefits AS eb
	ON e.EmployeeID = eb.EmployeeID
JOIN benefits AS b
	ON eb.BenefitID = b.BenefitID
GROUP BY Darbuotojas;

-- atlygis bendrai
SELECT 
	salary.Darbuotojas,
	SalaryAmount + bendros_islaidos AS Bendras_atlygis
FROM (SELECT 
	CONCAT(FirstName, " ", LastName) AS Darbuotojas,
    SalaryAmount
FROM (SELECT * FROM salaries WHERE YEAR(SalaryStartDate) = 2023) AS new_salary
LEFT JOIN employees AS e
	ON e.EmployeeID = new_salary.EmployeeID) AS salary
JOIN (SELECT 
	CONCAT(FirstName, " ", LastName) AS Darbuotojas,
    SUM(b.Cost) AS bendros_islaidos
FROM employees AS e
JOIN employeebenefits AS eb
	ON e.EmployeeID = eb.EmployeeID
JOIN benefits AS b
	ON eb.BenefitID = b.BenefitID
GROUP BY Darbuotojas) AS benefits
 	ON salary.Darbuotojas = benefits.Darbuotojas
GROUP BY Bendras_atlygis, salary.Darbuotojas
ORDER BY Bendras_atlygis DESC;

-- 38. Darbuotojų darbo atsiliepimų tendencijos: išveskite kiekvieno darbuotojo vardą ir
-- pavardę, nurodant ar jo darbo atsiliepimas (performancereviews lentelė) pagerėjo ar
-- sumažėjo.

-- old reviews
SELECT 
	EmployeeID,
    Rating,
    ReviewID <= 10 AS old_review
FROM performancereviews
WHERE (ReviewID <= 10) > 0;

-- new reviews
SELECT 
	EmployeeID,
    Rating,
    ReviewID > 10 AS new_review
FROM performancereviews
WHERE (ReviewID > 10) > 0;

-- old reviews sujungta su employee duomenim
SELECT
	CONCAT(FirstName, " ", LastName) AS Darbuotojas,
    e.EmployeeID,
    Rating AS old_rating
FROM employees AS e
JOIN (SELECT 
	EmployeeID,
    Rating,
    ReviewID <= 10 AS old_review
FROM performancereviews
WHERE (ReviewID <= 10) > 0) AS senas
	ON e.EmployeeID = senas.EmployeeID;

-- new reviews sujungta su employee duomenim
SELECT
	CONCAT(FirstName, " ", LastName) AS Darbuotojas,
    e.EmployeeID,
    Rating AS new_rating
FROM employees AS e
JOIN (SELECT 
	EmployeeID,
    Rating,
    ReviewID > 10 AS new_review
FROM performancereviews
WHERE (ReviewID > 10) > 0) AS naujas
	ON e.EmployeeID = naujas.EmployeeID;

-- darbo atsiliepimų tendencijos    
SELECT 
	nauji_ivertinimai.Darbuotojas,
	CASE
		WHEN old_rating = new_rating THEN 'Nepakito'
        WHEN old_rating < new_rating THEN 'Padidėjo'
        WHEN old_rating > new_rating THEN 'Sumažėjo'
	END AS darbo_atsiliepimo_pakitimai
FROM (SELECT
	CONCAT(FirstName, " ", LastName) AS Darbuotojas,
    e.EmployeeID,
    Rating AS old_rating
FROM employees AS e
JOIN (SELECT 
	EmployeeID,
    Rating,
    ReviewID <= 10 AS old_review
FROM performancereviews
WHERE (ReviewID <= 10) > 0) AS senas
	ON e.EmployeeID = senas.EmployeeID) AS seni_ivertinimai
JOIN (SELECT
	CONCAT(FirstName, " ", LastName) AS Darbuotojas,
    e.EmployeeID,
    Rating AS new_rating
FROM employees AS e
JOIN (SELECT 
	EmployeeID,
    Rating,
    ReviewID > 10 AS new_review
FROM performancereviews
WHERE (ReviewID > 10) > 0) AS naujas
	ON e.EmployeeID = naujas.EmployeeID) AS nauji_ivertinimai
	ON seni_ivertinimai.EmployeeID = nauji_ivertinimai.EmployeeID; 