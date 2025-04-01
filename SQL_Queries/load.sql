-- Patient Table
COPY Patient(Fname, Lname, EmailID, Gender, DateOfBirth, Age)
FROM 'Datasets/patient.csv'
DELIMITER ','
CSV HEADER;

-- Patient Address Table
COPY PatientAddress(PatientID, StreetName, City, ZipCode)
FROM 'Datasets/patientaddress.csv'
DELIMITER ','
CSV HEADER;

-- Patient Phone Number Table
COPY PatientPhoneNumber(PatientID, PhoneNumber)
FROM 'Datasets/patientphonenumber.csv'
DELIMITER ','
CSV HEADER;

-- Department Table
COPY Department(Name, HOD)
FROM 'Datasets/department.csv'
DELIMITER ','
CSV HEADER;

-- Staff Table
COPY Staff(DepartmentID, EmailID, Fname, Lname, Position, HireDate, Qualification)
FROM 'Datasets/staff.csv'
DELIMITER ','
CSV HEADER;

-- Staff Address Table
COPY StaffAddress(StaffID, StreetName, City, ZipCode)
FROM 'Datasets/staffaddress.csv'
DELIMITER ','
CSV HEADER;

-- Staff Phone Number Table
COPY StaffPhoneNumber(StaffID, PhoneNumber)
FROM 'Datasets/staffphonenumber.csv'
DELIMITER ','
CSV HEADER;

-- Schedule Table
COPY Schedule(StaffID, Day, StartTime, EndTime, BreakTime)
FROM 'Datasets/schedule.csv'
DELIMITER ','
CSV HEADER;

-- Appointment Table
COPY Appointment(PatientID, DoctorID, DepartmentID, AppointmentDate, AppointmentTime, Purpose, Status)
FROM 'Datasets/appointment.csv'
DELIMITER ','
CSV HEADER;

-- Lab Reports Table
COPY LabReports(PatientID, DoctorID, Type, Result)
FROM 'Datasets/labreports.csv'
DELIMITER ','
CSV HEADER;

-- Pharmacy Table
COPY Pharmacy(Name, Description, PrescriptionRequired, StockQuantity, Price)
FROM 'Datasets/pharmacy.csv'
DELIMITER ','
CSV HEADER;

-- Prescription Table
COPY Prescription(PrescriptionID, MedicineID, PatientID, Dosage, Frequency)
FROM 'Datasets/prescription.csv'
DELIMITER ','
CSV HEADER;

-- Medical History Table
COPY MedicalHistory(PatientID, DoctorID, NurseID, DateOfVisit, FollowUpRequired, FollowUpDate, Symptoms, Diagnosis, Treatment, EmergencyContact)
FROM 'Datasets/medicalhistory.csv'
DELIMITER ','
CSV HEADER;
