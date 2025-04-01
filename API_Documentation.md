# API Documentation for Hospital Management System

**All routes are server-side rendered using Flask.**

### 🔄 Base URL
```bash
http://localhost:5000
```

### 📋 Endpoints

##### 1. GET /

- Description: View all patients
- Template: patients.html

##### 2. POST /add

- Description: Add a new patient
- Form fields:
    - fname, lname, emailid, gender, dateofbirth, age
    - streetname, city, zipcode
    - phone
- Redirects to: /

##### 3. POST /update

- Description: Update existing patient information
- Form fields:
    - patientid, fname, lname, emailid, gender, dateofbirth, age
- Redirects to: /

##### 4. POST /delete/int:patient_id

- Description: Delete a patient by ID
- Redirects to: /

##### 5. GET /patient/int:patient_id

- Description: View patient full profile
- Includes:
    - Basic details, address, phone
    - Appointments (linked to doctor details)
    - Prescriptions (linked to pharmacy and doctor)
    - Lab Reports (linked to doctor)
    - Medical history button
- Template: patient_details.html

##### 6. GET /staff/int:staff_id?patient_id=...

- Description: View staff profile
- Includes:
    - Address, phones, schedule
    - Back button to originating patient (if provided)
- Template: staff_details.html

##### 7. GET /pharmacy/int:medicine_id?patient_id=...

- Description: View medicine details
- Includes:
    - Name, Description, Stock, Price
    - Back button to patient profile
- Template: pharmacy_details.html

##### 8. GET /patient/int:patient_id/history

- Description: View complete medical history of a patient
- Table includes:
    - Date of Visit, Symptoms, Diagnosis, Treatment
    - Follow-Up info, Prescription ID
    - Doctor and Nurse names
- Template: medical_history.html

### ⚙️ Notes

- All data interactions happen via SQLAlchemy ORM or raw SQL queries.
- Bootstrap modals are used for insert and update operations.
- DataTables is used for column-level filtering on patient and medical history pages.

