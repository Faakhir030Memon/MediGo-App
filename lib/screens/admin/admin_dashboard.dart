import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/admin_controller.dart';
import '../../core/constants/app_colors.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('MediGo Admin', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: AppColors.textPrimary,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pending Doctor Verifications',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (controller.pendingDoctors.isEmpty) {
                  return const Center(child: Text('No pending verifications.'));
                }
                return ListView.builder(
                  itemCount: controller.pendingDoctors.length,
                  itemBuilder: (context, index) {
                    final doctor = controller.pendingDoctors[index];
                    return _buildDoctorApprovalCard(controller, doctor);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorApprovalCard(AdminController controller, dynamic doctor) {
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
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: const Icon(Icons.medical_services_outlined, color: AppColors.primary),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${doctor.firstName} ${doctor.lastName}', 
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(doctor.email, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => controller.verifyDoctor(doctor.uid, false),
                child: const Text('REJECT', style: TextStyle(color: Colors.red)),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => controller.verifyDoctor(doctor.uid, true),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                child: const Text('APPROVE', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
