-- Patient Table
COPY Patient(Fname, Lname, EmailID, Gender, DateOfBirth, Age)
FROM 'patient.csv'
DELIMITER ','
CSV HEADER;

-- Patient Address Table
COPY PatientAddress(PatientID, StreetName, City, ZipCode)
FROM 'patientaddress.csv'
DELIMITER ','
CSV HEADER;

-- Patient Phone Number Table
COPY PatientPhoneNumber(PatientID, PhoneNumber)
FROM 'patientphonenumber.csv'
DELIMITER ','
CSV HEADER;

-- Department Table
COPY Department(Name, HOD)
FROM 'department.csv'
DELIMITER ','
CSV HEADER;

-- Staff Table
COPY Staff(DepartmentID, EmailID, Fname, Lname, Position, HireDate, Qualification)
FROM 'staff.csv'
DELIMITER ','
CSV HEADER;

-- Staff Address Table
COPY StaffAddress(StaffID, StreetName, City, ZipCode)
FROM 'staffaddress.csv'
DELIMITER ','
CSV HEADER;

-- Staff Phone Number Table
COPY StaffPhoneNumber(StaffID, PhoneNumber)
FROM 'staffphonenumber.csv'
DELIMITER ','
CSV HEADER;

-- Schedule Table
COPY Schedule(StaffID, Day, StartTime, EndTime, BreakTime)
FROM 'schedule.csv'
DELIMITER ','
CSV HEADER;

-- Appointment Table
COPY Appointment(PatientID, DoctorID, DepartmentID, AppointmentDate, AppointmentTime, Purpose, Status)
FROM 'appointment.csv'
DELIMITER ','
CSV HEADER;

-- Lab Reports Table
COPY LabReports(PatientID, DoctorID, Type, Result)
FROM 'labreports.csv'
DELIMITER ','
CSV HEADER;

-- Pharmacy Table
COPY Pharmacy(Name, Description, PrescriptionRequired, StockQuantity, Price)
FROM 'pharmacy.csv'
DELIMITER ','
CSV HEADER;

-- Prescription Table
COPY Prescription(PrescriptionID, MedicineID, PatientID, Dosage, Frequency)
FROM 'prescription.csv'
DELIMITER ','
CSV HEADER;

-- Medical History Table
COPY MedicalHistory(PatientID, DoctorID, NurseID, DateOfVisit, FollowUpRequired, FollowUpDate, Symptoms, Diagnosis, Treatment, EmergencyContact)
FROM 'medicalhistory.csv'
DELIMITER ','
CSV HEADER;
