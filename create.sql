DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'patient') THEN
		-- Patient Details Table
		CREATE TABLE Patient (
			PatientID SERIAL PRIMARY KEY,
			Fname VARCHAR(50) NOT NULL,
			Lname VARCHAR(50) NOT NULL,
			EmailID VARCHAR(50),
			Gender VARCHAR(15) NOT NULL,
			DateOfBirth DATE NOT NULL,
			Age INT
		);
		RAISE NOTICE 'Table Patient was created successfully.';
    ELSE
        RAISE NOTICE 'Table Patient already exists.';
    END IF;
END $$;


DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'patientaddress') THEN
		-- Patient Address Table 
		CREATE TABLE PatientAddress (
			PatientID INT PRIMARY KEY,
			StreetName VARCHAR(50) NOT NULL,
			City VARCHAR(50) NOT NULL,
			ZipCode VARCHAR(10) NOT NULL,
			CONSTRAINT fk_patient
				FOREIGN KEY (PatientID)
				REFERENCES Patient (PatientID)
				ON DELETE CASCADE
		);
		RAISE NOTICE 'Table PatientAddress was created successfully.';
    ELSE
        RAISE NOTICE 'Table PatientAddress already exists.';
    END IF;
END $$;


DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'patientphonenumber') THEN
		-- Patient Phone Number Table
		CREATE TABLE PatientPhoneNumber (
			PatientID INT NOT NULL,
			PhoneNumber VARCHAR(15) NOT NULL,
			PRIMARY KEY (PatientID, PhoneNumber),
			CONSTRAINT fk_patient_phone
				FOREIGN KEY (PatientID)
				REFERENCES Patient (PatientID)
				ON DELETE CASCADE
		);
		RAISE NOTICE 'Table PatientPhoneNumber was created successfully.';
    ELSE
        RAISE NOTICE 'Table PatientPhoneNumber already exists.';
    END IF;
END $$;


DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'department') THEN
		-- Department Table
		CREATE TABLE Department (
			DepartmentID SERIAL PRIMARY KEY,
			Name VARCHAR(50) NOT NULL,
			HOD VARCHAR(50) NOT NULL
		);
		RAISE NOTICE 'Table Department was created successfully.';
    ELSE
        RAISE NOTICE 'Table Department already exists.';
    END IF;
END $$;


DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'staff') THEN
		-- Staff Table
		CREATE TABLE Staff (
			StaffID SERIAL PRIMARY KEY,
			DepartmentID INT NOT NULL,
			EmailID VARCHAR(50),
			Fname VARCHAR(50) NOT NULL,
			Lname VARCHAR(50) NOT NULL,
			Position VARCHAR(100) NOT NULL,
			HireDate DATE NOT NULL,
			Qualification VARCHAR(50) NOT NULL,
			CONSTRAINT fk_staff_department
				FOREIGN KEY (DepartmentID)
				REFERENCES Department (DepartmentID)
				ON DELETE RESTRICT
		);
		RAISE NOTICE 'Table Staff was created successfully.';
    ELSE
        RAISE NOTICE 'Table Staff already exists.';
    END IF;
END $$;


DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'staffaddress') THEN
		-- Staff Address Table
		CREATE TABLE StaffAddress (
			StaffID INT NOT NULL,
			StreetName VARCHAR(50) NOT NULL,
			City VARCHAR(50) NOT NULL,
			ZipCode VARCHAR(10) NOT NULL,
			PRIMARY KEY (StaffID),
			CONSTRAINT fk_staff_address
				FOREIGN KEY (StaffID)
				REFERENCES Staff (StaffID)
				ON DELETE CASCADE
		);
		RAISE NOTICE 'Table StaffAddress was created successfully.';
    ELSE
        RAISE NOTICE 'Table StaffAddress already exists.';
    END IF;
END $$;


DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'staffphonenumber') THEN
		-- Staff Phone Number Table
		CREATE TABLE StaffPhoneNumber (
			StaffID INT NOT NULL,
			PhoneNumber VARCHAR(15) NOT NULL,
			PRIMARY KEY (StaffID, PhoneNumber),
			CONSTRAINT fk_staff_phone
				FOREIGN KEY (StaffID)
				REFERENCES Staff (StaffID)
				ON DELETE CASCADE
		);
		RAISE NOTICE 'Table StaffPhoneNumber was created successfully.';
    ELSE
        RAISE NOTICE 'Table StaffPhoneNumber already exists.';
    END IF;
END $$;


DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'schedule') THEN
		-- Schedule Table
		CREATE TABLE Schedule (
			StaffID INT NOT NULL,
			Day VARCHAR(15) NOT NULL,
			StartTime TIME NOT NULL,
			EndTime TIME NOT NULL,
			BreakTime TIME NOT NULL,
			PRIMARY KEY (StaffID, Day),
			CONSTRAINT fk_schedule_staff
				FOREIGN KEY (StaffID)
				REFERENCES Staff (StaffID)
				ON DELETE CASCADE
		);
		RAISE NOTICE 'Table Schedule was created successfully.';
    ELSE
        RAISE NOTICE 'Table Schedule already exists.';
    END IF;
END $$;


DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'appointment') THEN
		-- Appointment Table
		CREATE TABLE Appointment (
			AppointmentID SERIAL PRIMARY KEY,
			PatientID INT NOT NULL,
			DoctorID INT NOT NULL,
			DepartmentID INT NOT NULL,
			AppointmentDate DATE NOT NULL,
			AppointmentTime TIME NOT NULL,
			Purpose VARCHAR(500) NOT NULL,
			Status VARCHAR(50) NOT NULL,
			CONSTRAINT fk_appointment_patient
				FOREIGN KEY (PatientID)
				REFERENCES Patient (PatientID)
				ON DELETE CASCADE,
			CONSTRAINT fk_appointment_doctor
				FOREIGN KEY (DoctorID)
				REFERENCES Staff (StaffID)
				ON DELETE CASCADE,
			CONSTRAINT fk_appointment_department
				FOREIGN KEY (DepartmentID)
				REFERENCES Department (DepartmentID)
				ON DELETE CASCADE
		);
		RAISE NOTICE 'Table Appointment was created successfully.';
    ELSE
        RAISE NOTICE 'Table Appointment already exists.';
    END IF;
END $$;


DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'labreports') THEN
		-- Lab Reports Table
		CREATE TABLE LabReports (
			ReportID SERIAL PRIMARY KEY,
			PatientID INT NOT NULL,
			DoctorID INT NOT NULL,
			Type VARCHAR(50) NOT NULL,
			Result VARCHAR(128) NOT NULL,
			CONSTRAINT fk_labreports_patient
				FOREIGN KEY (PatientID)
				REFERENCES Patient (PatientID)
				ON DELETE CASCADE,
			CONSTRAINT fk_labreports_doctor
				FOREIGN KEY (DoctorID)
				REFERENCES Staff (StaffID)
				ON DELETE RESTRICT
		);
		RAISE NOTICE 'Table LabReports was created successfully.';
    ELSE
        RAISE NOTICE 'Table LabReports already exists.';
    END IF;
END $$;


DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'pharmacy') THEN
		-- Pharmacy Table
		CREATE TABLE Pharmacy (
			MedicineID SERIAL PRIMARY KEY,
			Name VARCHAR(50) NOT NULL,
			Description VARCHAR(128),
			PrescriptionRequired BOOLEAN NOT NULL,
			StockQuantity INT NOT NULL,
			Price FLOAT NOT NULL
		);
		RAISE NOTICE 'Table Pharmacy was created successfully.';
    ELSE
        RAISE NOTICE 'Table Pharmacy already exists.';
    END IF;
END $$;


DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'prescription') THEN
		-- Prescription Table
		CREATE TABLE Prescription (
			PrescriptionID INT NOT NULL,
			MedicineID INT NOT NULL,
			PatientID INT NOT NULL,
			Dosage INT NOT NULL,
			Frequency INT NOT NULL,
			PRIMARY KEY (PrescriptionID, MedicineID, PatientID),
			CONSTRAINT fk_prescription_pharmacy
				FOREIGN KEY (MedicineID)
				REFERENCES Pharmacy (MedicineID)
				ON DELETE RESTRICT,
			CONSTRAINT fk_prescription_patient
				FOREIGN KEY (PatientID)
				REFERENCES Patient (PatientID)
				ON DELETE CASCADE
		);
		RAISE NOTICE 'Table Prescription was created successfully.';
    ELSE
        RAISE NOTICE 'Table Prescription already exists.';
    END IF;
END $$;


DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'medicalhistory') THEN
		-- Medical History Table
		CREATE TABLE MedicalHistory (
			HistoryID SERIAL PRIMARY KEY,
			PatientID INT NOT NULL,
			DoctorID INT NOT NULL,
			NurseID INT NOT NULL,
			DateOfVisit DATE NOT NULL,
			FollowUpRequired BOOLEAN NOT NULL,
			FollowUpDate DATE,
			Symptoms VARCHAR(50),
			Diagnosis VARCHAR(50),
			Treatment VARCHAR(50),
			EmergencyContact VARCHAR(15),
			CONSTRAINT fk_medicalhistory_patient
				FOREIGN KEY (PatientID)
				REFERENCES Patient (PatientID)
				ON DELETE CASCADE,
			CONSTRAINT fk_medicalhistory_doctor
				FOREIGN KEY (DoctorID)
				REFERENCES Staff (StaffID)
				ON DELETE CASCADE,
			CONSTRAINT fk_medicalhistory_nurse
				FOREIGN KEY (NurseID)
				REFERENCES Staff (StaffID)
				ON DELETE CASCADE
		);
		RAISE NOTICE 'Table MedicalHistory was created successfully.';
    ELSE
        RAISE NOTICE 'Table MedicalHistory already exists.';
    END IF;
END $$;
