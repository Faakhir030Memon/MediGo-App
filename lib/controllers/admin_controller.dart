import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AdminController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final RxList<UserModel> pendingDoctors = <UserModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPendingDoctors();
  }

  void fetchPendingDoctors() {
    _db.collection('users')
      .where('userType', isEqualTo: 'doctor')
      .where('isVerified', isEqualTo: false)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => UserModel.fromMap(doc.data()))
          .toList())
      .listen((doctors) {
        pendingDoctors.assignAll(doctors);
      });
  }

  Future<void> verifyDoctor(String uid, bool approve) async {
    try {
      if (approve) {
        await _db.collection('users').doc(uid).update({'isVerified': true});
        Get.snackbar("Success", "Doctor verified successfully");
      } else {
        // Optionally delete or keep as rejected
        await _db.collection('users').doc(uid).delete();
        Get.snackbar("Success", "Doctor registration rejected");
      }
    } catch (e) {
      Get.snackbar("Error", "Action failed: $e");
    }
  }
}
