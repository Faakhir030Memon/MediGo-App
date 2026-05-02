import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';
import '../config/app_routes.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();
  
  final AuthService _authService = AuthService();
  final Rx<User?> _firebaseUser = Rx<User?>(null);
  final Rx<UserModel?> _userModel = Rx<UserModel?>(null);
  final RxBool isLoading = false.obs;

  User? get firebaseUser => _firebaseUser.value;
  UserModel? get userModel => _userModel.value;

  @override
  void onReady() {
    super.onReady();
    _firebaseUser.bindStream(_authService.user);
    ever(_firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) async {
    if (user == null) {
      // Navigate to Login
      Get.offAllNamed(AppRoutes.login);
    } else {
      // Fetch profile and navigate to Dashboard
      await fetchUserProfile(user.uid);
      if (_userModel.value != null) {
        switch (_userModel.value!.userType) {
          case UserType.patient:
            Get.offAllNamed(AppRoutes.patientHome);
            break;
          case UserType.doctor:
            Get.offAllNamed(AppRoutes.doctorHome);
            break;
          case UserType.pharmacy:
            Get.offAllNamed(AppRoutes.pharmacyHome);
            break;
          case UserType.admin:
            Get.offAllNamed(AppRoutes.adminDashboard);
            break;
        }
      } else {
        // Profile not found, maybe redirect to complete profile
        // For now, redirect to login if profile missing
        Get.offAllNamed(AppRoutes.login);
      }
    }
  }

  Future<void> fetchUserProfile(String uid) async {
    try {
      _userModel.value = await _authService.getUserProfile(uid);
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch user profile: $e");
    }
  }

  Future<void> signUp(String email, String password, UserModel user) async {
    try {
      isLoading.value = true;
      UserCredential? cred = await _authService.signUp(email, password);
      if (cred != null && cred.user != null) {
        // Create profile in Firestore
        final newUser = UserModel(
          uid: cred.user!.uid,
          firstName: user.firstName,
          lastName: user.lastName,
          email: user.email,
          phoneNumber: user.phoneNumber,
          age: user.age,
          userType: user.userType,
          createdAt: DateTime.now(),
        );
        await _authService.saveUserProfile(newUser);
        _userModel.value = newUser;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      await _authService.login(email, password);
    } catch (e) {
      Get.snackbar("Error", "Login failed: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    _authService.logout();
    _userModel.value = null;
  }
}
