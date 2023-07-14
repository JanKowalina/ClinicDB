
INSERT INTO Doctors
    (Doctor_PESEL, Surname, Name, Employment_Date, Position)
	VALUES('13039423185', 'Nowak', 'Boles�aw', '1980-10-18', 'Family Medicine Physician'),
		  ('21231468290', 'Michalska', 'Stanis�awa', '1967-11-08', 'Family Medicine Physician'),
		  ('12012212937', 'Kami�ska', 'Ma�gorzata', '1980-10-18', 'Optometrist'),
		  ('17022425189', 'Ko�odziej', 'Mateusz', '1985-01-21', 'Pediatritian'),
		  ('13672345279', 'Rybacki', 'Jan', '1971-01-01', 'Allergist'),
	      ('21022255914', 'Kowalska', 'Barbara', '1972-03-02', 'Dermatologist');


INSERT INTO Patients
	(Patient_PESEL, Name, Surname, Phone_Number, Email)
	 VALUES('01156289021', 'Jan', 'Warcho�', '234910233', 'jan.warchol@gmail.com'),
	       ('01126279023', 'Ireneusz', 'Wyspia�ski', '436913283', 'irek.wyspa@gmail.com'),
		   ('11103189051', 'Tadeusz', 'Ko�ciuszko', '137900293', 'tadeusz.kosc@wp.pl'),
		   ('01026209021', 'Adam', 'Mickiewicz', '211910071', 'adam.mickiewicz@onet.pl'),
		   ('12216259005', 'Boles�aw', 'Krzywousty', '234560132', 'boleslaw.krzywousty@gmail.com');


INSERT INTO Visits
	(Date, Time, Remark, Status, Doctor_PESEL, Patient_PESEL)
	 VALUES('2021-10-02', '12:45', NULL, 'absence', '13039423185', '01156289021'),
	       ('2020-11-12', '12:10', NULL, 'took place', '13039423185', '01126279023'),
		   ('2021-11-10', '10:45', NULL, 'will take place', '21231468290', '01026209021'),
		   ('2021-01-30', '09:00', 'Remark 1', 'absence', '17022425189', '01156289021'),
		   ('2020-03-12', '15:00', NULL, 'took place', '21231468290', '01026209021'),
		   ('2021-07-28', '13:10', 'Remark 2', 'took place', '13672345279', '01026209021'),
		   ('2021-10-23', '07:20', NULL, 'will take place', '13672345279', '01126279023'),
		   ('2021-08-19', '09:45', 'Remark 3', 'took place', '13672345279', '11103189051');


INSERT INTO illnesses_Catalog 
    (illness_Name, Type, Symptoms_Description, Recommendation, Contraindication)
	 VALUES('illness Name 1', 'Type 1', 'Symptoms 1', 'Recommendations 1', 'Contraindication 1'),
	       ('illness Name 2', 'Type 2', 'Symptoms 2', 'Recommendations 2', 'Contraindication 2'),
		   ('illness Name 3', 'Type 3', 'Symptoms 3', 'Recommendations 3', 'Contraindication 3'),
		   ('illness Name 4', 'Type 4', 'Symptoms 4', 'Recommendations 4', 'Contraindication 4'),
		   ('illness Name 5', 'Type 5', 'Symptoms 5', 'Recommendations 5', 'Contraindication 5'),
		   ('illness Name 6', 'Type 6', 'Symptoms 6', 'Recommendations 6', 'Contraindication 6'),
		   ('illness Name 7', 'Type 7', 'Symptoms 7', 'Recommendations 7', 'Contraindication 7'),
		   ('illness Name 8', 'Type 8', 'Symptoms 8', 'Recommendations 8', 'Contraindication 8'),
		   ('illness Name 9', 'Type 9', 'Symptoms 9', 'Recommendations 9', 'Contraindication 9'),
		   ('illness Name 10', 'Type 10', 'Symptoms 10', 'Recommendations 10', 'Contraindication 10');


INSERT INTO illnesses
	(Visit_ID, illness_Name, Detected_Symptoms, Is_Chronic)
	 VALUES(2,'illness Name 10', 'Detected Symptoms', 1),
	       (2,'illness Name 1', 'Detected Symptoms', 1),
		   (5,'illness Name 7', 'Detected Symptoms', 0),
		   (6,'illness Name 7', 'Detected Symptoms', 0),
		   (6,'illness Name 3', 'Detected Symptoms', 0),
		   (6,'illness Name 2', 'Detected Symptoms', 0),
		   (8,'illness Name 3', 'Detected Symptoms', 1);


INSERT INTO Actions_Catalog
    (Action_Name, Type, Recommendation, Contraindication)
	 VALUES('Action Name 1', 'Type 2', 'Recommendations', 'Contrindications'),
	       ('Action Name 2', 'Type 2', 'Recommendations', 'Contrindications'),
		   ('Action Name 3', 'Type 1', 'Recommendations', 'Contrindications'),
		   ('Action Name 4', 'Type 2', 'Recommendations', 'Contrindications'),
		   ('Action Name 5', 'Type 3', 'Recommendations', 'Contrindications'),
		   ('Action Name 6', 'Type 4', 'Recommendations', 'Contrindications'),
		   ('Action Name 7', 'Type 6', 'Recommendations', 'Contrindications'),
		   ('Action Name 8', 'Type 5', 'Recommendations', 'Contrindications');


INSERT INTO Actions
    (Action_Name, Visit_ID, Description, Effect, Patient_Reaction)
	 VALUES('Action Name 1', 2, 'Description', NULL, NULL),
	       ('Action Name 3', 2, 'Description', 'Effect', 'Patient Reaction'),
		   ('Action Name 5', 2, 'Description', 'Effect', 'Patient Reaction'),
		   ('Action Name 8', 6, 'Description', NULL, 'Patient Reaction'),
		   ('Action Name 3', 8, 'Description', 'Effect', NULL),
		   ('Action Name 5', 8, 'Description', NULL, NULL);


INSERT INTO Clinics_Catalog
    (Clinic_Type_Name, Recommendation, Contraindication)
	 VALUES('Clinic Type Name 1', 'Recommendation', 'Contraindication'),
		   ('Clinic Type Name 2', 'Recommendation', 'Contraindication'),
		   ('Clinic Type Name 3', 'Recommendation', 'Contraindication'),
		   ('Clinic Type Name 4', 'Recommendation', 'Contraindication'),
		   ('Clinic Type Name 5', 'Recommendation', 'Contraindication'),
		   ('Clinic Type Name 6', 'Recommendation', 'Contraindication'),
		   ('Clinic Type Name 7', 'Recommendation', 'Contraindication');


INSERT INTO Referrals
    (Priority, Status, Expiration_Date, Visit_ID, Clinic_Type_Name)
	 VALUES('priority', 'fulfilled', '2021-06-12', 2, 'Clinic Type Name 2'),
		   ('regular', 'fulfilled', '2020-07-19', 5, 'Clinic Type Name 3'),
		   ('regular', 'fulfilled', '2020-12-30', 6, 'Clinic Type Name 6'),
		   ('priority', 'not fulfilled', '2022-04-01', 8, 'Clinic Type Name 6'),
		   ('regular', 'not fulfilled', '2022-02-01', 8, 'Clinic Type Name 4');


INSERT INTO Prescriptions
    (Visit_ID, No, Expiration_Date, Status)
	 VALUES(2, 1, '2021-03-01', 'realized'),
		   (2, 2, '2021-04-13', 'realized'),
		   (2, 3, '2021-02-24', 'partly realized'),
		   (5, 1, '2020-10-07', 'partly realized'),
		   (6, 1, '2022-02-27', 'not realized'),
		   (6, 2, '2022-03-10', 'realized');


INSERT INTO Medicaments_Catalog
    (Medicament_Name, Manufacturer, Introduction_Date, Composition, Contraindication, Recommendation)
	 VALUES('Medicament Name 1', 'Manufacturer 1', '2014-11-09', 'Composition', 'Contraindication', 'Recommendation'),
	       ('Medicament Name 2', 'Manufacturer 2', '2010-10-09', 'Composition', 'Contraindication', 'Recommendation'),
		   ('Medicament Name 3', 'Manufacturer 1', '2011-12-31', 'Composition', 'Contraindication', 'Recommendation'),
		   ('Medicament Name 4', 'Manufacturer 4', '2004-01-12', 'Composition', 'Contraindication', 'Recommendation'),
		   ('Medicament Name 5', 'Manufacturer 3', '2014-07-19', 'Composition', 'Contraindication', 'Recommendation'),
		   ('Medicament Name 6', 'Manufacturer 5', '2017-12-03', 'Composition', 'Contraindication', 'Recommendation'),
		   ('Medicament Name 7', 'Manufacturer 2', '2009-11-29', 'Composition', 'Contraindication', 'Recommendation'),
		   ('Medicament Name 8', 'Manufacturer 1', '2001-10-12', 'Composition', 'Contraindication', 'Recommendation'),
		   ('Medicament Name 9', 'Manufacturer 6', '2000-11-23', 'Composition', 'Contraindication', 'Recommendation'),
		   ('Medicament Name 10', 'Manufacturer 7', '2012-04-27', 'Composition', 'Contraindication', 'Recommendation'),
		   ('Medicament Name 11', 'Manufacturer 7', '2010-10-25', 'Composition', 'Contraindication', 'Recommendation'),
		   ('Medicament Name 12', 'Manufacturer 1', '2019-02-04', 'Composition', 'Contraindication', 'Recommendation'),
		   ('Medicament Name 13', 'Manufacturer 8', '2015-01-01', 'Composition', 'Contraindication', 'Recommendation');



INSERT INTO Medicaments
    (Medicament_Name, Visit_ID, No, Quantity, Dosage, Remuneration)
	 VALUES('Medicament Name 13', 2, 1, 3, 'Dosage', 51),
	       ('Medicament Name 1', 2, 1, 1, 'Dosage', 12),
		   ('Medicament Name 3', 2, 1, 2, 'Dosage', 0),
		   ('Medicament Name 6', 2, 2, 5, 'Dosage', 0),
		   ('Medicament Name 2', 2, 2, 1, 'Dosage', 28),
		   ('Medicament Name 12', 2, 3, 6, 'Dosage', 0),
		   ('Medicament Name 12', 5, 1, 2, 'Dosage', 0),
		   ('Medicament Name 4', 5, 1, 1, 'Dosage', 12),
		   ('Medicament Name 12', 6, 1, 1, 'Dosage', 51),
		   ('Medicament Name 4', 6, 1, 2, 'Dosage', 0),
		   ('Medicament Name 8', 6, 1, 1, 'Dosage', 0),
		   ('Medicament Name 9', 6, 2, 3, 'Dosage', 70);
 



