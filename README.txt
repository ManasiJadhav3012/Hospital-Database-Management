We have created our own dataset. Following is the python script to create this dataset.

____________________ PYTHON SCRIPT ________________________

!pip3 install faker pandas
import pandas as pd
from faker import Faker
import random

fake = Faker()

# Number of entries
num_entries = 5000

# Function to generate Phone Number
def generate_phone_number():
      phone_number = f'{fake.random_number(digits=10)}'
      while len(phone_number) < 10:
          phone_number = '0' + phone_number
      return phone_number


# Staff Table
staff = []
for i in range(1, num_entries + 1):
    staff_id = i
    department_id = random.choice(range(1, 8))
    medicine_id = random.choice(range(1, 13))
    phone_number = generate_phone_number()

    staff.append({
        'StaffID': staff_id,
        'DepartmentID': department_id,
        'EmailID': fake.email(),
        'Fname': fake.first_name(),
        'Lname': fake.last_name(),
        'Position': fake.job(),
        'HireDate': fake.date_between(start_date='-5y', end_date='today'),
        'Qualification': 'MD',
        'PhoneNo': phone_number,
        'StaffStreetName': fake.street_name(),
        'StaffCity': fake.city(),
        'StaffZipCode': fake.zipcode()
    })
df_staff = pd.DataFrame(staff)
df_staff.to_csv('staff.csv', index=False)


# Department Table
department_names = [
    'Cardiology', 'Neurology', 'Orthopedics', 'Pediatrics', 'General',
    'Dermatology', 'Emergency'
]

departments = []
for index, name in enumerate(department_names, start=1):
    department = {
        'DepartmentID': index,
        'Name': name,
        'HOD': fake.name()
    }
    departments.append(department)

# for dept in departments:
#     print(dept)

df_departments = pd.DataFrame(departments)
df_departments.to_csv('departments.csv', index=False)


# Patient Table
phone_number = generate_phone_number()

patients = [{
'PatientID': i,
'Fname': fake.first_name(),
'Lname': fake.last_name(),
'EmailID': fake.email(),
'Gender': fake.random_element(['Male', 'Female', 'Other']),
'DateOfBirth': fake.date_of_birth(minimum_age=0, maximum_age=100),
'Age': fake.random_int(min=0, max=100),
'PhoneNumber': generate_phone_number(),
'StreetName': fake.street_name(),
'City': fake.city(),
'ZipCode': fake.zipcode()
} for i in range(1, num_entries + 1)]

df_patients = pd.DataFrame(patients)
df_patients.to_csv('patients.csv', index=False)


# Appointments, Lab Reports, Prescriptions, Pharmacies and Schedules Tables
appointments = []
lab_reports = []
prescriptions = []
pharmacies = []
schedules = []

medicine_names = ['Medicine A', 'Medicine B', 'Medicine C', 'Medicine D', 'Medicine E', 'Medicine F', 'Medicine G', 'Medicine H', 'Medicine I', 'Medicine J', 'Medicine K', 'Medicine L', 'Medicine M']
days_of_week = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday']

for i in range(1, num_entries + 1):
    department_id = random.choice(range(1, 6))
    medicine_id = random.choice(range(1, 13))

    day = random.choice(days_of_week)
    schedules.append({
        'StaffID': staff_id,
        'Day': day,
        'StartTime': fake.time_object().strftime('%H:%M:%S'),
        'EndTime': fake.time_object().strftime('%H:%M:%S'),
        'BreakTime': fake.time_object().strftime('%H:%M:%S')
    })

    patient_id = random.choice(range(1, num_entries + 1))
    appointments.append({
        'AppointmentID': i,
        'PatientID': patient_id,
        'DoctorID': staff_id,
        'DepartmentID': department_id,
        'AppointmentDate': fake.date_this_year(),
        'AppointmentTime': fake.time(),
        'Purpose': fake.sentence(),
        'Status': random.choice(['Scheduled', 'Completed', 'Cancelled'])
    })

    lab_reports.append({
        'ReportID': i,
        'PatientID': patient_id,
        'DoctorID': staff_id,
        'Type': random.choice(['Blood Test', 'X-Ray', 'MRI', 'Urine Test']),
        'Result': random.choice(['Normal', 'Abnormal', 'Critical'])
    })

    prescriptions.append({
        'PrescriptionID': i,
        'MedicineID': medicine_id,
        'PatientID': patient_id,
        'Dosage': random.choice([250, 500, 1000]),
        'Frequency': random.choice([1, 2, 3])
    })

    pharmacies.append({
        'MedicineID': medicine_id,
        'Name': random.choice(medicine_names),
        'Description': fake.text(max_nb_chars=100),
        'PrescriptionRequired': fake.boolean(),
        'StockQuantity': fake.random_int(min=100, max=1000),
        'Price': fake.random_number(digits=2)
    })

df_schedules = pd.DataFrame(schedules)
df_schedules.to_csv('schedules.csv', index=False)

df_appointments = pd.DataFrame(appointments)
df_appointments.to_csv('appointments.csv', index=False)

df_lab_reports = pd.DataFrame(lab_reports)
df_lab_reports.to_csv('labreports.csv', index=False)

df_prescriptions = pd.DataFrame(prescriptions)
df_prescriptions.to_csv('prescriptions.csv', index=False)

df_pharmacies = pd.DataFrame(pharmacies)
df_pharmacies.to_csv('pharmacies.csv', index=False)


# Medical History Table
medical_histories = []
for i in range(1, num_entries + 1):

  medical_histories.append({
          'HistoryID': i,
          'PatientID': patient_id,
          'DoctorID': staff_id,
          'NurseID': staff_id,  # Simplification for the script
          'DateOfVisit': fake.date_this_year(),
          'FollowUpRequired': fake.boolean(),
          'FollowUpDate': fake.date_this_year(),
          'Symptoms': fake.word(),
          'Diagnosis': fake.word(),
          'Treatment': fake.word(),
          'EmergencyContact': phone_number
      })
  
df_medical_histories = pd.DataFrame(medical_histories)
df_medical_histories.to_csv('medical_histories.csv', index=False)

print("Data generation complete and saved to hospital_data.xlsx")
