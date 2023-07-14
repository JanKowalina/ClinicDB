--presentation of cascade update 
SELECT * FROM Medicaments;
SELECT * FROM Medicaments_Catalog;

UPDATE Medicaments_Catalog
SET Medicament_Name = 'New Name'
WHERE Medicament_Name = 'Medicament Name 12';
SELECT * FROM Medicaments;
SELECT * FROM Medicaments_Catalog;


--presentation of cascade delete
SELECT * FROM Patients;
SELECT * FROM Visits;
SELECT * FROM Referrals;
SELECT * FROM Actions;
SELECT * FROM Medicaments;
SELECT * FROM Prescriptions;

--after executing this commands all of the informations about patinet with PESEL = 01026209021 will be removed
DELETE FROM Patients WHERE Patient_PESEL = '01026209021';
SELECT * FROM Patients;
SELECT * FROM Visits;
SELECT * FROM Referrals;
SELECT * FROM Actions;
SELECT * FROM Medicaments;
SELECT * FROM Prescriptions;


