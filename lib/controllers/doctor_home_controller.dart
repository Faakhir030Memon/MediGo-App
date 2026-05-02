import 'package:get/get.dart';
import '../models/appointment_model.dart';
import '../models/doctor_model.dart';
import '../controllers/auth_controller.dart';
import '../services/appointment_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorHomeController extends GetxController {
  final AppointmentService _appointmentService = AppointmentService();
  final AuthController _authController = AuthController.instance;

  final RxList<AppointmentModel> appointments = <AppointmentModel>[].obs;
  final RxBool isLoading = false.obs;
  final Rx<DoctorStatus> currentStatus = DoctorStatus.offline.obs;

  @override
  void onInit() {
    super.onInit();
    if (_authController.userModel is DoctorModel) {
      currentStatus.value = (_authController.userModel as DoctorModel).status;
    }
    fetchAppointments();
  }

  void fetchAppointments() {
    appointments.bindStream(
      _appointmentService.getDoctorAppointments(_authController.firebaseUser!.uid)
    );
  }

  Future<void> toggleStatus(DoctorStatus status) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(_authController.firebaseUser!.uid).update({
        'status': status.toString().split('.').last,
      });
      currentStatus.value = status;
      Get.snackbar("Success", "Status updated to ${status.toString().split('.').last}");
    } catch (e) {
      Get.snackbar("Error", "Failed to update status: $e");
    }
  }

  Future<void> updateAppointmentStatus(String id, AppointmentStatus status) async {
    try {
      await _appointmentService.updateAppointmentStatus(id, status);
      Get.snackbar("Success", "Appointment ${status.toString().split('.').last}");
    } catch (e) {
      Get.snackbar("Error", "Failed to update appointment: $e");
    }
  }
}
