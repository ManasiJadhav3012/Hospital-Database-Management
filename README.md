# Hospital Management System

**A full-stack web application built with Flask, PostgreSQL, and Bootstrap to manage hospital operations including patient details, appointments, staff, prescriptions, lab reports, pharmacy, and medical history.**

### 💾 Setup Instructions

##### 1. Clone the repository:
```bash
git clone https://github.com/ManasiJadhav3012/Hospital-Database-Management.git
cd Hospital-Database-Management
```

##### 2. Create virtual environment & activate:
```bash
python -m venv venv
source venv/bin/activate  # For Windows: venv\Scripts\activate
```

##### 3. Install dependencies:
```bash
```

##### 4. Setup PostgreSQL database:
- Create a database named hmsdb
- Update the database URI in __init__.py if needed

##### 5. Create tables:
```bash
cd SQL_Queries
psql -U postgres -d hmsdb -f create.sql
```

##### 6. Load initial data:
```bash
psql -U postgres -d hmsdb -f load_client.sql
```

##### 7. Run the app:
```bash
cd ..
python run.py
```

### 📦 Technologies Used

- Backend: Python (Flask), SQLAlchemy
- Database: PostgreSQL
- Frontend: HTML, Bootstrap, DataTables.js

### 🧩 Features

- Patient CRUD (Create, Read, Update, Delete)
- View patient details including address, phone, appointments, prescriptions, lab reports, and medical history
- Add, view, and navigate through staff members and their schedules
- Integrated filtering and search with DataTables
- Styled components with Bootstrap and custom CSS

### 📄 Table Schema Overview

- Patient, PatientAddress, PatientPhoneNumber
- Staff, StaffAddress, StaffPhoneNumber, Schedule
- Department, Appointment, LabReports, Pharmacy
- Prescription (linked to MedicalHistory)
- MedicalHistory (with references to Prescription, Doctor, Nurse)

## 💻 Screenshots & Button Functionality

### 🧾 Main Patient Dashboard
You can view, filter, and search all patient records here.
![Dashboard](images/First_Page.png)

### 🟢 Add Patient Modal
This modal allows users to input all required details about a patient, including their name, contact information, and address.
![Add Patient](images/Add_Patient.png)

### 🟦 Update Patient Modal
Click the blue pencil icon to open this form and update patient information.
![Update Patient](images/Update_Patient.png)

### 📋 Patient Details View
Clicking on a patient row shows their full profile, including:
- Appointments
- Prescriptions
- Lab Reports
![Patient Details 1](images/Patient_Details_1.png)
![Patient Details 2](images/Patient_Details_2.png)
![Patient Details 3](images/Patient_Details_3.png)

### 🧑‍⚕️ Staff Details from Appointment
Clicking on an appointment opens doctor's profile including address, schedule, and department info.
![Staff Details](images/Appointment_Staff_Detail.png)

### 💊 Pharmacy Details
Clicking on any prescription’s medicine name opens the medicine details.
![Pharmacy](images/Pharmacy_Details.png)

### 🏥 Medical History
View a patient’s visit records including symptoms, diagnosis, doctor/nurse, and more.
![Medical History](images/Medical_History.png)