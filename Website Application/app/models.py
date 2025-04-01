from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class Patient(db.Model):
    __tablename__ = 'patient'
    
    patientid = db.Column(db.Integer, primary_key=True)
    fname = db.Column(db.String(50), nullable=False)
    lname = db.Column(db.String(50), nullable=False)
    emailid = db.Column(db.String(50))
    gender = db.Column(db.String(15), nullable=False)
    dateofbirth = db.Column(db.Date, nullable=False)
    age = db.Column(db.Integer)

class Address(db.Model):
    __tablename__ = 'patientaddress'
    patientid = db.Column(db.Integer, db.ForeignKey('patient.patientid'), primary_key=True)
    streetname = db.Column(db.String(50), nullable=False)
    city = db.Column(db.String(50), nullable=False)
    zipcode = db.Column(db.String(10), nullable=False)

class Phone(db.Model):
    __tablename__ = 'patientphonenumber'
    patientid = db.Column(db.Integer, db.ForeignKey('patient.patientid'), primary_key=True)
    phonenumber = db.Column(db.String(15), primary_key=True)

class Appointment(db.Model):
    __tablename__ = 'appointment'
    appointmentid = db.Column(db.Integer, primary_key=True)
    patientid = db.Column(db.Integer, db.ForeignKey('patient.patientid'), nullable=False)
    doctorid = db.Column(db.Integer, db.ForeignKey('staff.staffid'), nullable=False)
    departmentid = db.Column(db.Integer, db.ForeignKey('department.departmentid'), nullable=False)
    appointmentdate = db.Column(db.Date, nullable=False)
    appointmenttime = db.Column(db.Time, nullable=False)
    purpose = db.Column(db.String(500), nullable=False)
    status = db.Column(db.String(50), nullable=False)

class MedicalHistory(db.Model):
    __tablename__ = 'medicalhistory'
    
    historyid = db.Column(db.Integer, primary_key=True)
    patientid = db.Column(db.Integer, db.ForeignKey('patient.patientid'), nullable=False)
    doctorid = db.Column(db.Integer, db.ForeignKey('staff.staffid'), nullable=False)
    nurseid = db.Column(db.Integer, db.ForeignKey('staff.staffid'), nullable=False)
    dateofvisit = db.Column(db.Date, nullable=False)
    followuprequired = db.Column(db.Boolean, nullable=False)
    followupdate = db.Column(db.Date)
    symptoms = db.Column(db.String(50))
    diagnosis = db.Column(db.String(50))
    treatment = db.Column(db.String(50))
    emergencycontact = db.Column(db.String(15))

class Prescription(db.Model):
    __tablename__ = 'prescription'
    
    prescriptionid = db.Column(db.Integer, primary_key=True)
    medicineid = db.Column(db.Integer, db.ForeignKey('pharmacy.medicineid'), primary_key=True)
    patientid = db.Column(db.Integer, db.ForeignKey('patient.patientid'), primary_key=True)
    dosage = db.Column(db.Integer, nullable=False)
    frequency = db.Column(db.Integer, nullable=False)

class LabReports(db.Model):
    __tablename__ = 'labreports'

    reportid = db.Column(db.Integer, primary_key=True)
    patientid = db.Column(db.Integer, db.ForeignKey('patient.patientid'), nullable=False)
    doctorid = db.Column(db.Integer, db.ForeignKey('staff.staffid'), nullable=False)
    type = db.Column(db.String(50), nullable=False)
    result = db.Column(db.String(128), nullable=False)

class Pharmacy(db.Model):
    __tablename__ = 'pharmacy'

    medicineid = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), nullable=False)
    description = db.Column(db.String(128))
    prescriptionrequired = db.Column(db.Boolean, nullable=False)
    stockquantity = db.Column(db.Integer, nullable=False)
    price = db.Column(db.Float, nullable=False)

class Staff(db.Model):
    __tablename__ = 'staff'

    staffid = db.Column(db.Integer, primary_key=True)
    departmentid = db.Column(db.Integer, db.ForeignKey('department.departmentid', ondelete='RESTRICT'), nullable=False)
    departmentid = db.Column(db.Integer, db.ForeignKey('department.departmentid'), nullable=False)
    emailid = db.Column(db.String(50))
    fname = db.Column(db.String(50), nullable=False)
    lname = db.Column(db.String(50), nullable=False)
    position = db.Column(db.String(100), nullable=False)
    hiredate = db.Column(db.Date, nullable=False)
    qualification = db.Column(db.String(50), nullable=False)

class StaffAddress(db.Model):
    __tablename__ = 'staffaddress'

    staffid = db.Column(db.Integer, db.ForeignKey('staff.staffid'), primary_key=True)
    streetname = db.Column(db.String(50), nullable=False)
    city = db.Column(db.String(50), nullable=False)
    zipcode = db.Column(db.String(10), nullable=False)

class StaffPhoneNumber(db.Model):
    __tablename__ = 'staffphonenumber'

    staffid = db.Column(db.Integer, db.ForeignKey('staff.staffid'), primary_key=True)
    phonenumber = db.Column(db.String(15), primary_key=True)

class Department(db.Model):
    __tablename__ = 'department'
    departmentid = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), nullable=False)
    hod = db.Column(db.String(50), nullable=False)

class Schedule(db.Model):
    __tablename__ = 'schedule'
    staffid = db.Column(db.Integer, db.ForeignKey('staff.staffid', ondelete='CASCADE'), primary_key=True)
    day = db.Column(db.String(15), primary_key=True)
    starttime = db.Column(db.Time, nullable=False)
    endtime = db.Column(db.Time, nullable=False)
    breaktime = db.Column(db.Time, nullable=False)