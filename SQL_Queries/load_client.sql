\copy Patient(Fname, Lname, EmailID, Gender, DateOfBirth, Age) FROM '/Users/manasijadhav/Desktop/Hospital-Database-Management/SQL_Queries/Datasets/patient.csv' DELIMITER ',' CSV HEADER;
\copy PatientAddress(PatientID, StreetName, City, ZipCode) FROM '/Users/manasijadhav/Desktop/Hospital-Database-Management/SQL_Queries/Datasets/patientaddress.csv' DELIMITER ',' CSV HEADER;
\copy PatientPhoneNumber(PatientID, PhoneNumber) FROM '/Users/manasijadhav/Desktop/Hospital-Database-Management/SQL_Queries/Datasets/patientphonenumber.csv' DELIMITER ',' CSV HEADER;
\copy Department(Name, HOD) FROM '/Users/manasijadhav/Desktop/Hospital-Database-Management/SQL_Queries/Datasets/department.csv' DELIMITER ',' CSV HEADER;
\copy Staff(DepartmentID, EmailID, Fname, Lname, Position, HireDate, Qualification) FROM '/Users/manasijadhav/Desktop/Hospital-Database-Management/SQL_Queries/Datasets/staff.csv' DELIMITER ',' CSV HEADER;
\copy StaffAddress(StaffID, StreetName, City, ZipCode) FROM '/Users/manasijadhav/Desktop/Hospital-Database-Management/SQL_Queries/Datasets/staffaddress.csv' DELIMITER ',' CSV HEADER;
\copy StaffPhoneNumber(StaffID, PhoneNumber) FROM '/Users/manasijadhav/Desktop/Hospital-Database-Management/SQL_Queries/Datasets/staffphonenumber.csv' DELIMITER ',' CSV HEADER;
\copy Schedule(StaffID, Day, StartTime, EndTime, BreakTime) FROM '/Users/manasijadhav/Desktop/Hospital-Database-Management/SQL_Queries/Datasets/schedule.csv' DELIMITER ',' CSV HEADER;
SET datestyle = 'ISO, DMY';
\copy Appointment(PatientID, DoctorID, DepartmentID, AppointmentDate, AppointmentTime, Purpose, Status) FROM '/Users/manasijadhav/Desktop/Hospital-Database-Management/SQL_Queries/Datasets/appointment.csv' DELIMITER ',' CSV HEADER;
\copy LabReports(PatientID, DoctorID, Type, Result) FROM '/Users/manasijadhav/Desktop/Hospital-Database-Management/SQL_Queries/Datasets/labreports.csv' DELIMITER ',' CSV HEADER;
\copy Pharmacy(Name, Description, PrescriptionRequired, StockQuantity, Price) FROM '/Users/manasijadhav/Desktop/Hospital-Database-Management/SQL_Queries/Datasets/pharmacy.csv' DELIMITER ',' CSV HEADER;
\copy Prescription(MedicineID, PatientID, Dosage, Frequency) FROM '/Users/manasijadhav/Desktop/Hospital-Database-Management/SQL_Queries/Datasets/prescription.csv' DELIMITER ',' CSV HEADER;
SET datestyle = 'ISO, DMY';
\copy MedicalHistory(PatientID, DoctorID, NurseID, DateOfVisit, FollowUpRequired, FollowUpDate, Symptoms, Diagnosis, Treatment, EmergencyContact) FROM '/Users/manasijadhav/Desktop/Hospital-Database-Management/SQL_Queries/Datasets/medicalhistory.csv' DELIMITER ',' CSV HEADER;