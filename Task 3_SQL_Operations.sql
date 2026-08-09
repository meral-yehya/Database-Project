Task 3_SQL_Operations

SELECT Name, Gender, Phone
FROM Patient;

SELECT Appointment.AppointmentID, Patient.Name AS PatientName, Doctor.Specialty
FROM Appointment
JOIN Patient ON Appointment.PatientID = Patient.PatientID
JOIN Doctor ON Appointment.DoctorID = Doctor.DoctorID;

SELECT Name, Phone
FROM Patient
WHERE PatientID IN (
    SELECT PatientID
    FROM Appointment
    WHERE Status = 'Completed'
);

SELECT DoctorID, COUNT(*) AS TotalAppointments
FROM Appointment
GROUP BY DoctorID;

UPDATE Patient
SET Phone = '0553255777'
WHERE PatientID = 1;
SELECT * FROM Patient;

DELETE FROM Treatment
WHERE TreatmentID = 5;
SELECT * FROM Treatment;

CREATE VIEW AppointmentSummary AS
SELECT AppointmentID, AppointmentDate, Status, PatientID, DoctorID
FROM Appointment;
SELECT * FROM AppointmentSummary;

CREATE TRIGGER ReduceStock
AFTER INSERT ON Treatment_Medicine
FOR EACH ROW
UPDATE Medicine
SET StockQuantity = StockQuantity - NEW.Quantity
WHERE MedicineID = NEW.MedicineID;
INSERT INTO Treatment_Medicine (TreatmentID, MedicineID, Quantity, Instructions)
VALUES (2, 4, 5, 'Test trigger');
SELECT * FROM Medicine;