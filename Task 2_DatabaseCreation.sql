Task 2_DatabaseCreation.sql

USE smart_clinic;
SHOW DATABASES;
CREATE TABLE Employee (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    HireDate DATE NOT NULL
);
SHOW TABLES;
CREATE TABLE Doctor (
    DoctorID INT PRIMARY KEY,
    Specialty VARCHAR(100) NOT NULL,
    RoomNumber VARCHAR(10),
    ConsultationFee DECIMAL(8,2) NOT NULL,
    CONSTRAINT fk_doctor_employee
        FOREIGN KEY (DoctorID) REFERENCES Employee(EmployeeID)
        ON DELETE CASCADE ON UPDATE CASCADE
);
SHOW TABLES;
CREATE TABLE Patient (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Gender ENUM('Male','Female','Other') NOT NULL,
    DateOfBirth DATE NOT NULL,
    Phone VARCHAR(20) NOT NULL
);
CREATE TABLE Appointment (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    AppointmentDate DATE NOT NULL,
    AppointmentTime TIME NOT NULL,
    Duration INT,
    Status ENUM('Scheduled','Completed','Cancelled') NOT NULL,
    Reason VARCHAR(255),
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    CONSTRAINT fk_appointment_patient
        FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_appointment_doctor
        FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
        ON DELETE CASCADE ON UPDATE CASCADE
);
SHOW TABLES;
CREATE TABLE Treatment (
    TreatmentID INT AUTO_INCREMENT PRIMARY KEY,
    Diagnosis VARCHAR(255) NOT NULL,
    TreatmentDescription VARCHAR(255) NOT NULL,
    Notes VARCHAR(255),
    AppointmentID INT NOT NULL,
    CONSTRAINT fk_treatment_appointment
        FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID)
        ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Medicine (
    MedicineID INT AUTO_INCREMENT PRIMARY KEY,
    MedicineName VARCHAR(100) NOT NULL,
    DosageForm VARCHAR(50),
    Strength VARCHAR(50),
    UnitPrice DECIMAL(8,2) NOT NULL,
    StockQuantity INT NOT NULL
);
SHOW TABLES;
CREATE TABLE Treatment_Medicine (
    TreatmentID INT NOT NULL,
    MedicineID INT NOT NULL,
    Quantity INT NOT NULL,
    Instructions VARCHAR(255),
    PRIMARY KEY (TreatmentID, MedicineID),
    CONSTRAINT fk_tm_treatment
        FOREIGN KEY (TreatmentID) REFERENCES Treatment(TreatmentID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_tm_medicine
        FOREIGN KEY (MedicineID) REFERENCES Medicine(MedicineID)
        ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Payment (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    AppointmentID INT NOT NULL,
    Amount DECIMAL(8,2) NOT NULL,
    PaymentDate DATE NOT NULL,
    PaymentMethod ENUM('Cash','Card','Online') NOT NULL,
    CONSTRAINT fk_payment_appointment
        FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID)
        ON DELETE CASCADE ON UPDATE CASCADE
);
SHOW TABLES;
INSERT INTO Employee (Name, Phone, Email, HireDate) VALUES
('Nawar Yehya', '0551000001', 'nawar.yehya@clinic.com', '2022-01-10'),
('Sarah Alturki', '0551000002', 'sarah.alturki@clinic.com', '2023-03-15'),
('Rama Ali', '0551000003', 'rama.ali@clinic.com', '2021-11-01'),
('Leen Khalil', '0551000004', 'leen.khalil@clinic.com', '2020-06-20'),
('Omar Khalid', '0551000005', 'omar.khalid@clinic.com', '2019-09-05');
SELECT * FROM Employee;
INSERT INTO Doctor (DoctorID, Specialty, RoomNumber, ConsultationFee) VALUES
(1, 'Cardiology', '101', 250.00),
(2, 'Dermatology', '202', 220.00),
(3, 'Pediatrics', '303', 150.00),
(4, 'Orthopedics', '404', 300.00),
(5, 'Internal Medicine', '505', 120.00);
SELECT * FROM Doctor;
INSERT INTO Receptionist (ReceptionistID, DeskNumber, Shift) VALUES
(1, 'Front-1', 'Morning'),
(2, 'Front-2', 'Evening'),
(3, 'Front-3', 'Night'),
(4, 'Front-4', 'Morning'),
(5, 'Front-5', 'Evening');
SELECT * FROM Receptionist;
INSERT INTO Patient (Name, Gender, DateOfBirth, Phone) VALUES
('Munirah Al-Mansour', 'Female', '2006-05-20', '0551234567'),
('Nasser Al-Harbi', 'Male', '2003-06-12', '0559876543'),
('Nada Al-Qahtani', 'Female', '2001-03-08', '0551122334'),
('Fahad Al-Otaibi', 'Male', '1997-12-15', '0555566778'),
('Sara Al-Johani', 'Female', '2012-07-7', '0559988776');
SELECT * FROM Patient;
INSERT INTO Appointment (AppointmentDate, AppointmentTime, Duration, Status, Reason, PatientID, DoctorID) VALUES
('2026-01-10', '10:00:00', 30, 'Scheduled', 'Routine checkup', 1, 1),
('2026-01-11', '11:30:00', 45, 'Completed', 'Skin rash', 2, 2),
('2026-01-12', '09:15:00', 20, 'Scheduled', 'Follow-up', 3, 3),
('2026-01-13', '06:30:00', 45, 'Cancelled', 'Back pain', 4, 4),
('2026-01-14', '08:45:00', 30, 'Completed', 'Flu symptoms', 5, 5);
SELECT * FROM Appointment;
INSERT INTO Treatment (Diagnosis, TreatmentDescription, Notes, AppointmentID) VALUES
('Hypertension', 'Lifestyle changes + medication', 'Monitor weekly', 1),
('Dermatitis', 'Topical cream prescribed', 'Avoid irritants', 2),
('Seasonal allergies', 'Antihistamines', 'Follow-up in 2 weeks', 3),
('Muscle strain', 'Physical therapy recommended', 'Rest for 5 days', 4),
('Influenza', 'Antiviral medication', 'Stay hydrated', 5);
SELECT * FROM Treatment;
INSERT INTO Medicine (MedicineName, DosageForm, Strength, UnitPrice, StockQuantity) VALUES
('Paracetamol', 'Tablet', '500mg', 5.00, 200),
('Ibuprofen', 'Tablet', '200mg', 8.00, 150),
('Amoxicillin', 'Capsule', '250mg', 12.00, 100),
('Cetirizine', 'Tablet', '10mg', 6.00, 180),
('Vitamin D', 'Softgel', '1000IU', 10.00, 250);
SELECT * FROM Medicine;
INSERT INTO Treatment_Medicine (TreatmentID, MedicineID, Quantity, Instructions) VALUES
(1, 1, 20, 'Take twice daily'),
(2, 2, 15, 'Apply as needed'),
(3, 4, 10, 'Take once daily'),
(4, 3, 30, 'Take after meals'),
(5, 5, 25, 'Take every morning');
SELECT * FROM Treatment_Medicine;
INSERT INTO Payment (AppointmentID, Amount, PaymentDate, PaymentMethod) VALUES
(1, 250.00, '2026-01-10', 'Card'),
(2, 220.00, '2026-01-11', 'Cash'),
(3, 150.00, '2026-01-12', 'Online'),
(4, 300.00, '2026-01-13', 'Card'),
(5, 120.00, '2026-01-14', 'Card');
SELECT * FROM Payment;