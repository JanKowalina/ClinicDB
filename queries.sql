
-- All visits (Visit_ID, Date, Hour) and (Name, Surname) of doctors who conducted visits on which medications approved for sale before 2010 were issued.
-- Wszystkie wizyty (Visit_ID, Data, Godzina) oraz (Imię, Nazwisko) lekarzy, którzy przeprowadzili wizyty, podczas których wydano leki dopuszczone do sprzedaży przed rokiem 2010.

SELECT V.Visit_ID, V.Date, V.Time, D.Name, D.Surname
	   FROM Visits V, Prescriptions P, Medicaments_Catalog M_C, Medicaments M, Doctors D
	   WHERE D.Doctor_PESEL = V.Doctor_PESEL AND V.Visit_ID = P.Visit_ID AND P.Visit_ID = M.Visit_ID 
	         AND P.No = M.No AND M.Medicament_Name = M_C.Medicament_Name AND M_C.Introduction_Date < '2010-01-01'
	   GROUP BY V.Visit_ID, V.Date, V.Time, D.Name, D.Surname;



-- Display the number of visits conducted by doctors (name, surname) in different years of their work.
-- Wyświetl liczbę wizyt przeprowadzonych przez lekarzy (imię, nazwisko) w różnych latach ich pracy.

SELECT D.Surname, D.Name, 'Number of visits: ' AS "Number of visits: ", COUNT(*) AS Number, 'in Year: ' AS "in Year: ", YEAR(V.Date) AS Year
       FROM Doctors D, Visits V
	   WHERE D.Doctor_PESEL = V.Doctor_PESEL
	   GROUP BY D.Surname, D.Name, YEAR(V.Date)
	   ORDER BY YEAR(V.Date) DESC, Number DESC;



-- Display names and surnames of patients as well as the number of detected chronic diseases. Sort the results in descending order based on the number of chronic diseases detected.
-- Wyświetl imiona i nazwiska pacjentów oraz liczbę wykrytych chorób przewlekłych. Posortuj wyniki malejąco według liczby wykrytych chorób przewlekłych.

SELECT P.Surname, P.Name, ROUND(SUM(CAST (I.Is_Chronic AS INT))/(CAST (COUNT(*) AS FLOAT)), 2) AS "Proportion of chronic illnesses"
	   FROM Patients P, Visits V, illnesses I
	   WHERE P.Patient_PESEL = V.Patient_PESEL AND V.Visit_ID = I.Visit_ID
	   GROUP BY P.Name, P.Surname, P.Patient_PESEL
	   ORDER BY "Proportion of chronic illnesses" DESC , P.Surname DESC, P.Name DESC;




-- Display all referrals and prescriptions that have already expired with a comment indicating whether they have been used, partially used, or not used.
-- Additionally, display the name and surname of the person for whom any of these documents were issued, as well as the visit ID.
-- Order the results according to the expiration date in descending order.

-- Wyświetl wszystkie skierowania i recepty, które już wygasły, z komentarzem informującym, czy zostały wykorzystane, wykorzystane częściowo czy nie.
-- Dodatkowo, wyświetl imię i nazwisko osoby, dla której wypisano któryś z tych dokumentów, oraz identyfikator wizyty.
-- Posortuj wyniki według daty wygaśnięcia w kolejności malejącej.

SELECT P.Surname, P.Name, V.Visit_ID, R.Expiration_Date, R.Status, 'Refferal' AS "Type" 
       FROM Patients P, Visits V, Referrals R
	   WHERE P.Patient_PESEL = V.Patient_PESEL AND V.Visit_ID = R.Visit_ID AND R.Expiration_Date < GETDATE()
UNION ALL	   
SELECT Pat.Surname, Pat.Name, V.Visit_ID, P.Expiration_Date, P.Status, 'Prescription' AS "Type" 
       FROM Patients Pat, Visits V, Prescriptions P
	   WHERE Pat.Patient_PESEL = V.Patient_PESEL AND V.Visit_ID = P.Visit_ID AND P.Expiration_Date < GETDATE()
ORDER BY Expiration_Date DESC;




--Display Surname and Name of the Doctor as well as the Name and Surname of Patient whose name starts at the same letter, and who meet each other during at least one visit
-- Take only first 3 results from data ordered by Doctor surname, name, and later Patient Name, Surname

-- Wyświetl Nazwisko i Imię Lekarza oraz Imię i Nazwisko Pacjenta, których imiona zaczynają się na tę samą literę i którzy spotkali się co najmniej raz podczas jednej wizyty.
-- Wybierz tylko pierwsze 3 wyniki z danych, posortowane według Nazwiska i Imienia Lekarza, a następnie Imienia i Nazwiska Pacjenta.

-- presentation of view usage
--DROP VIEW DocPat; 

CREATE VIEW DocPat AS
SELECT D.Surname AS Doctor_Surname, D.Name AS Doctor_Name, P.Name AS Patient_Name, P.Surname AS Patient_Surname
FROM Doctors D, Patients P
WHERE LEFT(D.Name, 1) = LEFT(P.Name, 1);

-- these two commands needs to be run one after one
SELECT *
FROM DocPat
ORDER BY Doctor_Surname, Doctor_Name, Patient_Name, Patient_Surname;




-- Display prescription (Visit_ID, No, ExpirationDate, and status) for which the average quantity was greater than the overall average of all reimbursed medications.
-- Wyświetl recepty (Visit_ID, No, Data ważności i status), dla których średnia ilość była większa niż ogólna średnia wszystkich refundowanych leków.

SELECT P.Visit_ID, P.No, P.Expiration_Date, AVG(M.Remuneration) AS "Average Renumeration"
       FROM Prescriptions P, Medicaments M
	   WHERE P.No = M.No AND P.Visit_ID = M.Visit_ID
	   GROUP BY P.Visit_ID, P.No, P.Expiration_Date
	   HAVING AVG(M.Remuneration) >
			     (SELECT AVG(M2.Remuneration) AS Total_Avg_Renumeration
				         FROM Medicaments M2);




-- Display information about patients (name, surname) and the number of times they have visited the clinic so far,
-- with a comment indicating whether it was more, equal to, or less than the average number of visits.
-- Group them in descending order.

-- Wyświetl informacje o pacjentach (imię, nazwisko) oraz liczbę razy, jakie dotychczas odwiedzili klinikę,
-- z komentarzem informującym, czy była to liczba większa, równa czy mniejsza od średniej liczby wizyt.
-- Pogrupuj wyniki w kolejności malejącej.

SELECT P.Surname, P.Name, COUNT(*) AS "Number of times they visited the clinic so far."
	   FROM Patients P, Visits V
	   WHERE P.Patient_PESEL = V.Patient_PESEL AND V.Status = 'took place'
	   GROUP BY P.Surname, P.Name, P.Patient_PESEL
	   HAVING COUNT(*) >= 
			  (SELECT AVG(ByGroups.Count_In_Groups) AS average FROM
			          (SELECT (CAST (COUNT(*) AS FLOAT)) AS Count_In_Groups
				              FROM Visits V2, Patients P2
					          WHERE P2.Patient_PESEL = V2.Patient_PESEL AND V2.Status = 'took place'
	                          GROUP BY P2.Patient_PESEL) AS ByGroups) 
	   ORDER BY COUNT(*) DESC, P.Surname DESC, P.Name DESC;


-- Display information about patients (name, surname) and the number of times they have visited the clinic so far,
-- with a comment indicating whether it was more, equal to, or less than the average number of visits.
-- Group them in descending order.

-- Wyświetl informacje o pacjentach (imię, nazwisko) oraz liczbę razy, jakie dotychczas odwiedzili klinikę,
-- z komentarzem informującym, czy była to liczba większa, równa czy mniejsza od średniej liczby wizyt.
-- Pogrupuj wyniki w kolejności malejącej.

DECLARE @average AS FLOAT;

SET @average = (SELECT AVG(ByGroups.Count_In_Groups) FROM 
			           (SELECT (CAST (COUNT(*) AS FLOAT)) AS Count_In_Groups
				               FROM Visits V2, Patients P2
					           WHERE P2.Patient_PESEL = V2.Patient_PESEL AND V2.Status = 'took place'
	                           GROUP BY P2.Patient_PESEL) AS ByGroups);

SELECT P.Surname, P.Name, 'visit clinic so far: ' AS "Visit clinic so far", COUNT(*) AS "Number", 
       CASE 
	       WHEN COUNT(*) > @average THEN 'times, what is greater than avg: '
		   WHEN COUNT(*) = @average THEN 'times, what is equal to avg: '
		   WHEN COUNT(*) < @average THEN 'times, what is smaller than avg: '
	   END AS Comparison, @average AS "Average"

	   FROM Patients P, Visits V
	   WHERE P.Patient_PESEL = V.Patient_PESEL AND V.Status = 'took place'
	   GROUP BY P.Surname, P.Name, P.Patient_PESEL
	   ORDER BY COUNT(*) DESC, P.Surname DESC, P.Name DESC;