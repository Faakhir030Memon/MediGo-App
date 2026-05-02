import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/doctor_home_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../models/doctor_model.dart';
import '../../models/appointment_model.dart';

class DoctorHomeScreen extends StatelessWidget {
  const DoctorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DoctorHomeController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('MediGo Doctor', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: AppColors.primary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => Get.find<AuthController>().logout(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Availability Toggle Section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                const Text(
                  'Set Your Availability',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 15),
                Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _statusChip(controller, DoctorStatus.available, Colors.green, Icons.check_circle),
                    _statusChip(controller, DoctorStatus.busy, Colors.orange, Icons.access_time_filled),
                    _statusChip(controller, DoctorStatus.offline, Colors.grey, Icons.do_not_disturb_on),
                  ],
                )),
              ],
            ),
          ),

          // Requests List
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Appointment Requests',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: Obx(() {
                      if (controller.appointments.isEmpty) {
                        return const Center(child: Text('No appointments yet.'));
                      }
                      return ListView.builder(
                        itemCount: controller.appointments.length,
                        itemBuilder: (context, index) {
                          final appointment = controller.appointments[index];
                          return _buildAppointmentCard(controller, appointment);
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusChip(DoctorHomeController controller, DoctorStatus status, Color color, IconData icon) {
    bool isSelected = controller.currentStatus.value == status;
    return GestureDetector(
      onTap: () => controller.toggleStatus(status),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white24,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? Colors.white : Colors.transparent),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: isSelected ? color : Colors.white),
            const SizedBox(width: 5),
            Text(
              status.toString().split('.').last.toUpperCase(),
              style: TextStyle(
                color: isSelected ? color : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentCard(DoctorHomeController controller, AppointmentModel appointment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.secondary.withOpacity(0.1),
                child: const Icon(Icons.person, color: AppColors.secondary),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(appointment.patientName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(appointment.type.toString().split('.').last.capitalizeFirst!, 
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: _getStatusColor(appointment.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  appointment.status.toString().split('.').last.toUpperCase(),
                  style: TextStyle(color: _getStatusColor(appointment.status), fontWeight: FontWeight.bold, fontSize: 10),
                ),
              ),
            ],
          ),
          if (appointment.status == AppointmentStatus.pending) ...[
            const Divider(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => controller.updateAppointmentStatus(appointment.id, AppointmentStatus.rejected),
                    child: const Text('REJECT', style: TextStyle(color: Colors.red)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => controller.updateAppointmentStatus(appointment.id, AppointmentStatus.accepted),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text('ACCEPT', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Color _getStatusColor(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.pending: return Colors.orange;
      case AppointmentStatus.accepted: return Colors.green;
      case AppointmentStatus.rejected: return Colors.red;
      case AppointmentStatus.completed: return Colors.blue;
      case AppointmentStatus.cancelled: return Colors.grey;
    }
  }
}

// Add necessary imports to AuthController check for Logout or move logic
