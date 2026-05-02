import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/doctor_model.dart';
import 'location_service.dart';

class DoctorService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final LocationService _locationService = LocationService();

  // Get all verified and available doctors
  Future<List<DoctorModel>> getNearbyDoctors(double userLat, double userLon, {double radiusInKm = 2.0}) async {
    try {
      final snapshot = await _db.collection('users')
          .where('userType', isEqualTo: 'doctor')
          .where('isVerified', isEqualTo: true)
          .where('status', isEqualTo: 'available')
          .get();

      List<DoctorModel> nearbyDoctors = [];

      for (var doc in snapshot.docs) {
        final doctor = DoctorModel.fromMap(doc.data());
        if (doctor.location != null) {
          double distance = _locationService.calculateDistance(
            userLat, 
            userLon, 
            doctor.location!.latitude, 
            doctor.location!.longitude
          );
          
          if (distance <= radiusInKm) {
            nearbyDoctors.add(doctor);
          }
        }
      }

      // Sort by distance (optional)
      // nearbyDoctors.sort((a, b) => ...)

      return nearbyDoctors;
    } catch (e) {
      rethrow;
    }
  }

  // Get doctor details
  Future<DoctorModel?> getDoctorDetails(String docId) async {
    final doc = await _db.collection('users').doc(docId).get();
    if (doc.exists && doc.data() != null) {
      return DoctorModel.fromMap(doc.data()!);
    }
    return null;
  }
}
