import 'package:cloud_firestore/cloud_firestore.dart';

enum AppointmentType { clinicVisit, homeVisit, emergency }
enum AppointmentStatus { pending, accepted, rejected, completed, cancelled }

class AppointmentModel {
  final String id;
  final String patientId;
  final String patientName;
  final String doctorId;
  final String doctorName;
  final AppointmentType type;
  final AppointmentStatus status;
  final DateTime dateTime;
  final GeoPoint? patientLocation; // For home visits
  final double estimatedFee;
  final String? notes;

  AppointmentModel({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.doctorId,
    required this.doctorName,
    required this.type,
    this.status = AppointmentStatus.pending,
    required this.dateTime,
    this.patientLocation,
    required this.estimatedFee,
    this.notes,
  });

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      id: map['id'] ?? '',
      patientId: map['patientId'] ?? '',
      patientName: map['patientName'] ?? '',
      doctorId: map['doctorId'] ?? '',
      doctorName: map['doctorName'] ?? '',
      type: AppointmentType.values.firstWhere(
        (e) => e.toString() == 'AppointmentType.${map['type']}',
        orElse: () => AppointmentType.clinicVisit,
      ),
      status: AppointmentStatus.values.firstWhere(
        (e) => e.toString() == 'AppointmentStatus.${map['status']}',
        orElse: () => AppointmentStatus.pending,
      ),
      dateTime: (map['dateTime'] as Timestamp).toDate(),
      patientLocation: map['patientLocation'] as GeoPoint?,
      estimatedFee: (map['estimatedFee'] ?? 0.0).toDouble(),
      notes: map['notes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'patientId': patientId,
      'patientName': patientName,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'type': type.toString().split('.').last,
      'status': status.toString().split('.').last,
      'dateTime': Timestamp.fromDate(dateTime),
      'patientLocation': patientLocation,
      'estimatedFee': estimatedFee,
      'notes': notes,
    };
  }
}
