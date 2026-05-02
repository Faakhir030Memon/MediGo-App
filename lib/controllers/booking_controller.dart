import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../models/appointment_model.dart';
import '../models/doctor_model.dart';
import '../controllers/auth_controller.dart';
import '../services/appointment_service.dart';

class BookingController extends GetxController {
  final AppointmentService _appointmentService = AppointmentService();
  final AuthController _authController = AuthController.instance;

  final RxBool isLoading = false.obs;

  Future<void> bookAppointment({
    required DoctorModel doctor,
    required AppointmentType type,
    String? notes,
  }) async {
    try {
      isLoading.value = true;
      final patient = _authController.userModel!;
      
      final appointment = AppointmentModel(
        id: const Uuid().v4(),
        patientId: patient.uid,
        patientName: patient.fullName,
        doctorId: doctor.uid,
        doctorName: 'Dr. ${doctor.firstName} ${doctor.lastName}',
        type: type,
        dateTime: DateTime.now(), // For instant requests, or allow selecting time
        patientLocation: type == AppointmentType.homeVisit ? patient.location : null,
        estimatedFee: doctor.consultationFee,
        notes: notes,
      );

      await _appointmentService.createAppointment(appointment);
      
      Get.back(); // Close screen
      Get.snackbar(
        "Success", 
        "Your ${type.toString().split('.').last} request has been sent to the doctor.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar("Error", "Booking failed: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
