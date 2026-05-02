  import 'package:cloud_firestore/cloud_firestore.dart';

enum UserType { patient, doctor, pharmacy, admin }

class UserModel {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final int age;
  final UserType userType;
  final GeoPoint? location;
  final DateTime createdAt;
  final bool isVerified;

  UserModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.age,
    required this.userType,
    this.location,
    required this.createdAt,
    this.isVerified = false,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String? ?? '',
      firstName: map['firstName'] as String? ?? '',
      lastName: map['lastName'] as String? ?? '',
      email: map['email'] as String? ?? '',
      phoneNumber: map['phoneNumber'] as String? ?? '',
      age: (map['age'] as num?)?.toInt() ?? 0,
      userType: UserType.values.firstWhere(
        (e) => e.name == map['userType'],
        orElse: () => UserType.patient,
      ),
      location: map['location'] as GeoPoint?,
      createdAt: map['createdAt'] is Timestamp 
          ? (map['createdAt'] as Timestamp).toDate() 
          : DateTime.now(),
      isVerified: map['isVerified'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'age': age,
      'userType': userType.toString().split('.').last,
      'location': location,
      'createdAt': Timestamp.fromDate(createdAt),
      'isVerified': isVerified,
    };
  }

  String get fullName => '$firstName $lastName';
}
