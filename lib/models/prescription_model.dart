import 'package:cloud_firestore/cloud_firestore.dart';

class PrescriptionModel {
  final String id;
  final String appointmentId;
  final String patientId;
  final String doctorId;
  final String doctorName;
  final DateTime date;
  final List<MedicineItem> medicines;
  final String diagnosis;
  final String? advice;

  PrescriptionModel({
    required this.id,
    required this.appointmentId,
    required this.patientId,
    required this.doctorId,
    required this.doctorName,
    required this.date,
    required this.medicines,
    required this.diagnosis,
    this.advice,
  });

  factory PrescriptionModel.fromMap(Map<String, dynamic> map) {
    return PrescriptionModel(
      id: map['id'] ?? '',
      appointmentId: map['appointmentId'] ?? '',
      patientId: map['patientId'] ?? '',
      doctorId: map['doctorId'] ?? '',
      doctorName: map['doctorName'] ?? '',
      date: (map['date'] as Timestamp).toDate(),
      medicines: (map['medicines'] as List? ?? [])
          .map((item) => MedicineItem.fromMap(item as Map<String, dynamic>))
          .toList(),
      diagnosis: map['diagnosis'] ?? '',
      advice: map['advice'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'appointmentId': appointmentId,
      'patientId': patientId,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'date': Timestamp.fromDate(date),
      'medicines': medicines.map((item) => item.toMap()).toList(),
      'diagnosis': diagnosis,
      'advice': advice,
    };
  }
}

class MedicineItem {
  final String name;
  final String dosage;
  final String frequency;
  final String duration;
  final String? instructions;

  MedicineItem({
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.duration,
    this.instructions,
  });

  factory MedicineItem.fromMap(Map<String, dynamic> map) {
    return MedicineItem(
      name: map['name'] ?? '',
      dosage: map['dosage'] ?? '',
      frequency: map['frequency'] ?? '',
      duration: map['duration'] ?? '',
      instructions: map['instructions'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dosage': dosage,
      'frequency': frequency,
      'duration': duration,
      'instructions': instructions,
    };
  }
}
