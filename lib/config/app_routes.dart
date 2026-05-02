import 'package:get/get.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/patient/patient_home_screen.dart';
import '../screens/doctor/doctor_home_screen.dart';
import '../screens/admin/admin_dashboard.dart';
import '../screens/pharmacy/pharmacy_home_screen.dart';
import '../screens/splash_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String patientHome = '/patient-home';
  static const String doctorHome = '/doctor-home';
  static const String pharmacyHome = '/pharmacy-home';
  static const String adminDashboard = '/admin-dashboard';
  static const String splash = '/';

  static final routes = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(), 
    ),
    GetPage(
      name: login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: signup,
      page: () => const SignupScreen(),
    ),
    GetPage(
      name: patientHome,
      page: () => const PatientHomeScreen(),
    ),
    GetPage(
      name: doctorHome,
      page: () => const DoctorHomeScreen(),
    ),
    GetPage(
      name: adminDashboard,
      page: () => const AdminDashboard(),
    ),
    GetPage(
      name: pharmacyHome,
      page: () => const PharmacyHomeScreen(),
    ),
  ];
}
