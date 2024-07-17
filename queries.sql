-- Insert Queries
-- Insert Query 1
INSERT INTO Patient (Fname, Lname, EmailID, Gender, DateOfBirth, Age)
VALUES ('Manasi', 'Jadhav', 'manasi.jadhav@gmail.com', 'Female', '1998-12-30', 25);

SELECT *
FROM Patient
WHERE PatientID > 5000;


-- Insert Query 2
INSERT INTO Staff (DepartmentID, EmailID, Fname, Lname, Position, HireDate, Qualification)
VALUES (1, 'manasi.jadhav@example.com', 'Manasi', 'Jadhav', 'Doctor', '2022-01-15', 'MD');

SELECT * 
FROM Staff 
WHERE EmailID = 'manasi.jadhav@example.com' 
AND HireDate = '2022-01-15';



-- Delete Queries
-- Delete Query 1
DELETE FROM Patient 
WHERE PatientID > 5000;

SELECT *
FROM Patient
WHERE PatientID > 5000;


-- Delete Query 2
DELETE FROM Pharmacy
WHERE StockQuantity < 10
AND MedicineID NOT IN (SELECT MedicineID FROM Prescription);

SELECT *
FROM Pharmacy
WHERE StockQuantity < 10
AND MedicineID NOT IN (SELECT MedicineID FROM Prescription);



-- Update Queries
-- Update Query 1
UPDATE Patient SET EmailID = 'updated.email@gmail.com' 
WHERE PatientID = 3;

SELECT * FROM Patient
WHERE PatientID = 3;


-- Update Query 2
UPDATE Department SET HOD = 'Manasi'
WHERE DepartmentID = 1;

UPDATE Department SET HOD = 'Manasi'
WHERE DepartmentID = 1;



-- Select Queries
-- Select Query 1
SELECT p.Fname, p.Lname, a.AppointmentDate, a.Purpose
FROM Patient p
JOIN Appointment a ON p.PatientID = a.PatientID
WHERE p.PatientID = 1;


-- Select Query 2
SELECT Name, StockQuantity FROM Pharmacy
ORDER BY StockQuantity DESC;


-- Select Query 3
SELECT d.Name, COUNT(a.AppointmentID) AS NumAppointments
FROM Department d
JOIN Appointment a ON d.DepartmentID = a.DepartmentID
GROUP BY d.Name;


-- Select Query 4
SELECT Fname, Lname FROM Staff
WHERE StaffID NOT IN (SELECT DoctorID FROM Appointment);



-- Indexing
-- Issue with join query
CREATE INDEX idx_patient_id ON Patient (PatientID);
CREATE INDEX idx_appointment_patient_id ON Appointment (PatientID);

-- Select Query 1
SELECT p.Fname, p.Lname, a.AppointmentDate, a.Purpose
FROM Patient p
JOIN Appointment a ON p.PatientID = a.PatientID
WHERE p.PatientID = 1;


-- Issue with groupby query
CREATE INDEX idx_department_id ON Department (DepartmentID);
CREATE INDEX idx_appointment_department_id ON Appointment (DepartmentID);

-- Select Query 3
SELECT d.Name, COUNT(a.AppointmentID) AS NumAppointments
FROM Department d
JOIN Appointment a ON d.DepartmentID = a.DepartmentID
GROUP BY d.Name;


-- Issue with subquery
CREATE INDEX idx_appointment_doctor_id ON Appointment (DoctorID);

-- Select Query 4
SELECT Fname, Lname 
FROM Staff
WHERE StaffID NOT IN (SELECT DoctorID FROM Appointment);

-- Select Query 4 with join and indexing
SELECT s.Fname, s.Lname 
FROM Staff s 
LEFT JOIN Appointment a ON s.StaffID = a.DoctorID 
WHERE a.DoctorID IS NULL

-- Select Query 4 with not exists and indexing
SELECT Fname, Lname 
FROM Staff s 
WHERE NOT EXISTS (SELECT 1 FROM Appointment a WHERE s.StaffID = a.DoctorID);
