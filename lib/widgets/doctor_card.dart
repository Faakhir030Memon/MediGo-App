import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/doctor_model.dart';
import '../core/constants/app_colors.dart';
import '../screens/patient/doctor_profile_screen.dart';

class DoctorCard extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Doctor Image Placeholder
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(Icons.person, size: 40, color: AppColors.primary),
          ),
          const SizedBox(width: 15),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dr. ${doctor.firstName} ${doctor.lastName}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  doctor.specialty,
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.star, size: 16, color: Colors.amber),
                    Text(' ${doctor.rating} (${doctor.reviewCount} reviews)'),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Icon(
                      Icons.circle, 
                      size: 10, 
                      color: doctor.status == DoctorStatus.available ? Colors.green : Colors.grey
                    ),
                    Text(
                      ' ${doctor.status.toString().split('.').last.capitalizeFirst}',
                      style: TextStyle(
                        color: doctor.status == DoctorStatus.available ? Colors.green : Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Fee and Action
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Rs. ${doctor.consultationFee}',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => Get.to(() => DoctorProfileScreen(doctor: doctor)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  minimumSize: Size.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('View', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
