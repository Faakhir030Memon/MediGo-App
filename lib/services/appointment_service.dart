import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/appointment_model.dart';

class AppointmentService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create a new appointment
  Future<void> createAppointment(AppointmentModel appointment) async {
    await _db.collection('appointments').doc(appointment.id).set(appointment.toMap());
  }

  // Get appointments for a patient
  Stream<List<AppointmentModel>> getPatientAppointments(String patientId) {
    return _db.collection('appointments')
        .where('patientId', isEqualTo: patientId)
        .orderBy('dateTime', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AppointmentModel.fromMap(doc.data()))
            .toList());
  }

  // Get appointments for a doctor
  Stream<List<AppointmentModel>> getDoctorAppointments(String doctorId) {
    return _db.collection('appointments')
        .where('doctorId', isEqualTo: doctorId)
        .orderBy('dateTime', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AppointmentModel.fromMap(doc.data()))
            .toList());
  }

  // Update appointment status
  Future<void> updateAppointmentStatus(String id, AppointmentStatus status) async {
    await _db.collection('appointments').doc(id).update({
      'status': status.toString().split('.').last,
    });
  }
}
