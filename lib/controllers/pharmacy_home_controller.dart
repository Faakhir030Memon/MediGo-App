import 'package:get/get.dart';
import '../services/pharmacy_service.dart';
import '../models/prescription_model.dart';

class PharmacyHomeController extends GetxController {
  final PharmacyService _pharmacyService = PharmacyService();
  final RxList<PrescriptionModel> orders = <PrescriptionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    orders.bindStream(_pharmacyService.getPharmacyOrders());
  }
}
