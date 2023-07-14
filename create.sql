
-- I decided to remove relationship take_action and prescribe_referral
-- as I realized they wasn't necessary, as these relations served only clarity purpose

CREATE DATABASE clinic;

USE clinic;


--DROP TABLE Doctors;
CREATE TABLE Doctors (Doctor_PESEL CHAR(11) PRIMARY KEY,
					  Name VARCHAR(20) NOT NULL,
                      Surname VARCHAR(40) NOT NULL,
                      Employment_Date DATE NOT NULL,
                      Position VARCHAR(30) NOT NULL,
					  CONSTRAINT chk_Doctor_PESEL CHECK (Doctor_PESEL NOT LIKE '%[^0-9]%'));
--SELECT * FROM Doctors;


--DROP TABLE Patients;
CREATE TABLE Patients (Patient_PESEL CHAR(11) PRIMARY KEY,
                       Name VARCHAR(20) NOT NULL,
                       Surname VARCHAR(40) NOT NULL,
					   Phone_Number CHAR(9) UNIQUE,
					   Email VARCHAR(40) UNIQUE CHECK (Email LIKE '%@%'),
					   CONSTRAINT chk_Phone_Number CHECK (Phone_Number NOT LIKE '%[^0-9]%'),
					   CONSTRAINT chk_Patient_PESEL CHECK (Patient_PESEL NOT LIKE '%[^0-9]%'));
--SELECT * FROM Patients; 


--DROP TABLE Visits;
CREATE TABLE Visits (Visit_ID INT PRIMARY KEY IDENTITY(1,1),
					 Date DATE NOT NULL,
                     Time CHAR(5) NOT NULL CHECK (Time LIKE '%[0-2][0-9][:][[0-5][0-9]%'),
                     Remark VARCHAR(1000),
					 Status VARCHAR(20) NOT NULL,
					 Patient_PESEL CHAR(11) REFERENCES Patients ON DELETE CASCADE,
					 Doctor_PESEL CHAR(11) REFERENCES Doctors ON DELETE SET NULL,
					 CONSTRAINT chk_Status CHECK (Status IN ('took place', 'will take place', 'absence')));
--SELECT * FROM Visits;                     


--DROP TABLE illnesses_Catalog;
CREATE TABLE illnesses_Catalog (illness_Name VARCHAR(60) PRIMARY KEY, 
                                Type VARCHAR(60) NOT NULL, 
							    Symptoms_Description VARCHAR(1000) NOT NULL,
								Recommendation VARCHAR(1000) NOT NULL, 
							    Contraindication VARCHAR(1000) NOT NULL);                      
--SELECT * FROM illnesses_Catalog; 


--DROP TABLE illnesses;
CREATE TABLE illnesses (Visit_ID INT REFERENCES Visits ON DELETE CASCADE, 
                        illness_Name VARCHAR(60) REFERENCES illnesses_Catalog ON UPDATE CASCADE, 
						Detected_Symptoms VARCHAR(1000) NOT NULL, 
                        --Patient_PESEL CHAR(11) NULL REFERENCES Patients ON DELETE NO ACTION, 
						--I decided I will resign from implementing this relationship as it was making me troubles
						--Instead I decided to implement new column in order to distinguish between illnesses which were detected as chronic
						Is_Chronic BIT,
						PRIMARY KEY (Visit_ID, illness_Name));
--SELECT * FROM illnesses; 


--DROP TABLE Actions_Catalog;
CREATE TABLE Actions_Catalog (Action_Name VARCHAR(60) PRIMARY KEY,
                              Type VARCHAR(60) NOT NULL, 
							  Recommendation VARCHAR(1000) NOT NULL, 
							  Contraindication VARCHAR(1000) NOT NULL);


--DROP TABLE Actions;
CREATE TABLE Actions (Action_Name VARCHAR(60) REFERENCES Actions_Catalog ON UPDATE CASCADE,
					  Visit_ID INT References Visits ON DELETE CASCADE,
                      Description VARCHAR(1000) NOT NULL,
					  Effect VARCHAR(1000),
					  Patient_Reaction VARCHAR(1000),
					  PRIMARY KEY (Action_Name, Visit_ID));
--SELECT * FROM Actions;


--DROP TABLE Clinics_Catalog;
CREATE TABLE Clinics_Catalog (Clinic_Type_Name VARCHAR(60) PRIMARY KEY, 
                             Contraindication VARCHAR(1000) NOT NULL, 
							 Recommendation VARCHAR(1000) NOT NULL);
--SELECT * FROM Clinics_Catalog;


--DROP TABLE Referrals;
CREATE TABLE Referrals (Referral_ID INT PRIMARY KEY IDENTITY(1,1), 
                        Priority VARCHAR(8) NOT NULL, 
						Status VARCHAR(13) NOT NULL,
						Expiration_Date DATE NOT NULL,
						CONSTRAINT chk_Priority CHECK (Priority IN ('regular', 'priority')),
						CONSTRAINT chk_Ref_Status CHECK (Status IN ('fulfilled', 'not fulfilled')),
						Visit_ID INT REFERENCES Visits ON DELETE CASCADE, 
                        Clinic_Type_Name VARCHAR(60) REFERENCES Clinics_Catalog ON DELETE SET NULL);
--SELECT * FROM Clinics_Catalog;


--DROP TABLE Prescriptions;
CREATE TABLE Prescriptions (Visit_ID INT REFERENCES Visits ON DELETE CASCADE, 
                            No INT,
                            Expiration_Date DATE NOT NULL,
							Status VARCHAR(16) NOT NULL, 
							CONSTRAINT chk_Presc_Status CHECK (Status IN ('realized', 'partly realized', 'not realized')),
							PRIMARY KEY (Visit_ID, No));
--SELECT * FROM Prescriptions;


--DROP TABLE Medicaments_Catalog;
CREATE TABLE Medicaments_Catalog (Medicament_Name VARCHAR(60) PRIMARY KEY, 
                                  Manufacturer VARCHAR(60) NOT NULL, 
								  Introduction_Date VARCHAR(60) NOT NULL, 
								  Composition VARCHAR(2000) NOT NULL, 
                                  Contraindication VARCHAR(1000) NOT NULL, 
								  Recommendation VARCHAR(1000) NOT NULL);
--SELECT * FROM Medicaments_Catalog;


-- I decided to artificially divide initial prmiary key of Medicaments so in order to be
-- able to present how to reference table with composite key

--DROP TABLE Medicaments;
CREATE TABLE Medicaments (Medicament_Name VARCHAR(60) REFERENCES Medicaments_Catalog ON UPDATE CASCADE, 
                          Visit_ID INT,
						  No INT,
						  Quantity INT CHECK (Quantity BETWEEN 1 AND 9) NOT NULL, 
						  Dosage VARCHAR(500) NOT NULL,
						  Remuneration INT CHECK (Remuneration BETWEEN 0 AND 100) NOT NULL,
						  FOREIGN KEY (Visit_ID, No) REFERENCES Prescriptions ON DELETE CASCADE,
						  PRIMARY KEY (Visit_ID, No, Medicament_Name));
--SELECT * FROM Medicaments;





