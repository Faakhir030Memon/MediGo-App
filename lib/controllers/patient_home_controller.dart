import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import '../services/doctor_service.dart';
import '../services/location_service.dart';
import '../models/doctor_model.dart';

class PatientHomeController extends GetxController {
  final DoctorService _doctorService = DoctorService();
  final LocationService _locationService = LocationService();

  final RxList<DoctorModel> nearbyDoctors = <DoctorModel>[].obs;
  final RxBool isLoading = false.obs;
  final Rx<Position?> currentPosition = Rx<Position?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchNearbyDoctors();
  }

  Future<void> fetchNearbyDoctors() async {
    try {
      isLoading.value = true;
      
      // 1. Get Location
      Position position = await _locationService.getCurrentLocation();
      currentPosition.value = position;

      // 2. Fetch Doctors within 2km
      List<DoctorModel> doctors = await _doctorService.getNearbyDoctors(
        position.latitude, 
        position.longitude
      );
      
      nearbyDoctors.assignAll(doctors);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
