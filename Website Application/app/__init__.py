from flask import Flask, render_template, request, redirect, url_for
from .models import db, Patient, Address, Phone, Appointment, MedicalHistory, Prescription, LabReports, Pharmacy, Staff, StaffAddress, StaffPhoneNumber, Department, Schedule
from sqlalchemy import text

def create_app():
    app = Flask(__name__)
    app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:India30121998$@localhost/hmsdb'
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.config['WTF_CSRF_ENABLED'] = False
    db.init_app(app)

    @app.route('/')
    def home():
        patients = Patient.query.all()
        return render_template('patients.html', patients=patients)
    
    @app.route('/update', methods=['GET', 'POST'])
    def update_patient():
        pid = request.form['patientid']
        patient = Patient.query.get(pid)
        if patient:
            patient.fname = request.form['fname']
            patient.lname = request.form['lname']
            patient.emailid = request.form['emailid']
            patient.gender = request.form['gender']
            patient.dateofbirth = request.form['dateofbirth']
            patient.age = request.form['age']
            db.session.commit()
        return redirect(url_for('home'))
    
    @app.route('/delete/<int:patient_id>', methods=['POST'])
    def delete_patient(patient_id):
        patient = Patient.query.get_or_404(patient_id)
        db.session.delete(patient)
        db.session.commit()
        return redirect(url_for('home'))
    
    @app.route('/add', methods=['POST'])
    def add_patient():
        fname = request.form['fname']
        lname = request.form['lname']
        emailid = request.form['emailid']
        gender = request.form['gender']
        dob = request.form['dateofbirth']
        age = request.form['age']
        
        streetname = request.form['streetname']
        city = request.form['city']
        zipcode = request.form['zipcode']
        
        phone = request.form['phone']

        new_patient = Patient(fname=fname, lname=lname, emailid=emailid, gender=gender, dateofbirth=dob, age=age)
        db.session.add(new_patient)
        db.session.commit()

        patient_id = new_patient.patientid

        new_address = Address(patientid=patient_id, streetname=streetname, city=city, zipcode=zipcode)
        db.session.add(new_address)

        new_phone = Phone(patientid=patient_id, phonenumber=phone)
        db.session.add(new_phone)

        db.session.commit()
        return redirect(url_for('home'))
    
    @app.route('/patient/<int:patient_id>')
    def patient_detail(patient_id):
        patient = Patient.query.get_or_404(patient_id)
        address = Address.query.filter_by(patientid=patient_id).first()
        phone = Phone.query.filter_by(patientid=patient_id).first()
        
        appointments = db.session.execute(text("""
            SELECT a.appointmentdate, a.appointmenttime, a.purpose, a.status,
                a.doctorid, s.fname AS doctor_fname, s.lname AS doctor_lname
            FROM Appointment a
            JOIN Staff s ON a.doctorid = s.staffid
            WHERE a.patientid = :pid
        """), {'pid': patient_id}).fetchall()

        
        medical_history = db.session.execute(
            text("SELECT * FROM MedicalHistory WHERE PatientID = :pid"), {'pid': patient_id}
        ).fetchall()
        
        prescriptions = db.session.execute(text("""
            SELECT 
                p.prescriptionid,
                p.medicineid,
                ph.name,
                p.dosage,
                p.frequency,
                s.fname AS doctor_fname,
                s.lname AS doctor_lname
            FROM Prescription p
            JOIN Pharmacy ph ON p.medicineid = ph.medicineid
            LEFT JOIN MedicalHistory mh ON mh.prescriptionid = p.prescriptionid
            LEFT JOIN Staff s ON mh.doctorid = s.staffid
            WHERE p.patientid = :pid
            ORDER BY p.prescriptionid ASC
        """), {'pid': patient_id}).fetchall()
        
        lab_reports = db.session.execute(text("""
            SELECT lr.type, lr.result, s.fname AS doctor_fname, s.lname AS doctor_lname
            FROM LabReports lr
            JOIN Staff s ON lr.doctorid = s.staffid
            WHERE lr.patientid = :pid
        """), {'pid': patient_id}).fetchall()


        return render_template(
            'patient_details.html',
            patient=patient,
            address=address,
            phone=phone,
            appointments=appointments,
            medical_history=medical_history,
            prescriptions=prescriptions,
            lab_reports=lab_reports
        )
    
    @app.route('/pharmacy/<int:medicine_id>')
    def pharmacy_detail(medicine_id):
        patient_id = request.args.get('patient_id', type=int)

        query = text("SELECT * FROM Pharmacy WHERE MedicineID = :medicine_id")
        result = db.session.execute(query, {'medicine_id': medicine_id}).fetchone()

        if result is None:
            return "Medicine not found", 404

        return render_template('pharmacy_details.html', medicine=result, patient_id=patient_id)
    
    @app.route('/staff/<int:staff_id>')
    def staff_detail(staff_id):
        staff = Staff.query.get_or_404(staff_id)
        address = StaffAddress.query.get(staff_id)
        phones = StaffPhoneNumber.query.filter_by(staffid=staff_id).all()
        department = Department.query.get(staff.departmentid)
        schedule = Schedule.query.filter_by(staffid=staff_id).all()

        previous_patient_id = request.args.get('patient_id')

        return render_template(
            'staff_details.html',
            staff=staff,
            address=address,
            phones=phones,
            department=department,
            schedule=schedule,
            previous_patient_id=previous_patient_id
        )
    
    @app.route('/patient/<int:patient_id>/history')
    def medical_history(patient_id):
        patient = Patient.query.get_or_404(patient_id)

        history = db.session.execute(text("""
            SELECT 
                mh.dateofvisit,
                mh.symptoms,
                mh.diagnosis,
                mh.treatment,
                mh.followuprequired,
                mh.followupdate,
                mh.emergencycontact,
                s1.fname AS doctor_fname,
                s1.lname AS doctor_lname,
                s2.fname AS nurse_fname,
                s2.lname AS nurse_lname,
                mh.prescriptionid
            FROM MedicalHistory mh
            JOIN Staff s1 ON mh.doctorid = s1.staffid
            JOIN Staff s2 ON mh.nurseid = s2.staffid
            WHERE mh.patientid = :pid
        """), {'pid': patient_id}).fetchall()

        return render_template("medical_history.html", history=history, patient=patient)


    return app
