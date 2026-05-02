import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/prescription_model.dart';

class PharmacyService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get orders/prescriptions for a pharmacy
  Stream<List<PrescriptionModel>> getPharmacyOrders() {
    return _db.collection('prescriptions')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PrescriptionModel.fromMap(doc.data()))
            .toList());
  }

  // Update order status (optional logic for pharmacy)
}
