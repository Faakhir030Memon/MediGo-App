import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_model.dart';

class PharmacyModel extends UserModel {
  final String pharmacyName;
  final String licenseNumber;
  final String address;
  final bool providesHomeDelivery;
  final List<String>? availableMedicines;

  PharmacyModel({
    required super.uid,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.phoneNumber,
    required super.age,
    required super.createdAt,
    super.isVerified,
    super.location,
    required this.pharmacyName,
    required this.licenseNumber,
    required this.address,
    this.providesHomeDelivery = true,
    this.availableMedicines,
  }) : super(userType: UserType.pharmacy);

  factory PharmacyModel.fromMap(Map<String, dynamic> map) {
    return PharmacyModel(
      uid: map['uid'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      age: map['age'] ?? 0,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      isVerified: map['isVerified'] ?? false,
      location: map['location'] as GeoPoint?,
      pharmacyName: map['pharmacyName'] ?? '',
      licenseNumber: map['licenseNumber'] ?? '',
      address: map['address'] ?? '',
      providesHomeDelivery: map['providesHomeDelivery'] ?? true,
      availableMedicines: map['availableMedicines'] != null 
          ? List<String>.from(map['availableMedicines']) 
          : null,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'pharmacyName': pharmacyName,
      'licenseNumber': licenseNumber,
      'address': address,
      'providesHomeDelivery': providesHomeDelivery,
      'availableMedicines': availableMedicines,
    });
    return map;
  }
}
