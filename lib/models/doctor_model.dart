import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_model.dart';

enum DoctorStatus { available, busy, offline }

class DoctorModel extends UserModel {
  final String specialty;
  final String licenseNumber;
  final double consultationFee;
  final bool homeVisitAvailable;
  final DoctorStatus status;
  final double rating;
  final int reviewCount;
  final String clinicLocation;
  final List<String>? education;

  DoctorModel({
    required super.uid,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.phoneNumber,
    required super.age,
    required super.createdAt,
    super.isVerified,
    super.location,
    required this.specialty,
    required this.licenseNumber,
    required this.consultationFee,
    required this.homeVisitAvailable,
    this.status = DoctorStatus.offline,
    this.rating = 0.0,
    this.reviewCount = 0,
    required this.clinicLocation,
    this.education,
  }) : super(userType: UserType.doctor);

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      uid: map['uid'] as String? ?? '',
      firstName: map['firstName'] as String? ?? '',
      lastName: map['lastName'] as String? ?? '',
      email: map['email'] as String? ?? '',
      phoneNumber: map['phoneNumber'] as String? ?? '',
      age: (map['age'] as num?)?.toInt() ?? 0,
      createdAt: map['createdAt'] is Timestamp 
          ? (map['createdAt'] as Timestamp).toDate() 
          : DateTime.now(),
      isVerified: map['isVerified'] as bool? ?? false,
      location: map['location'] as GeoPoint?,
      specialty: map['specialty'] as String? ?? 'General Physician',
      licenseNumber: map['licenseNumber'] as String? ?? 'N/A',
      consultationFee: (map['consultationFee'] as num?)?.toDouble() ?? 0.0,
      homeVisitAvailable: map['homeVisitAvailable'] as bool? ?? false,
      status: DoctorStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => DoctorStatus.offline,
      ),
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: (map['reviewCount'] as num?)?.toInt() ?? 0,
      clinicLocation: map['clinicLocation'] as String? ?? 'Location not provided',
      education: map['education'] != null ? List<String>.from(map['education']) : null,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'specialty': specialty,
      'licenseNumber': licenseNumber,
      'consultationFee': consultationFee,
      'homeVisitAvailable': homeVisitAvailable,
      'status': status.toString().split('.').last,
      'rating': rating,
      'reviewCount': reviewCount,
      'clinicLocation': clinicLocation,
      'education': education,
    });
    return map;
  }
}
