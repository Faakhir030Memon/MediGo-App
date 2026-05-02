import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/doctor_model.dart';
import '../../models/appointment_model.dart';
import '../../core/constants/app_colors.dart';
import '../../controllers/booking_controller.dart';

class DoctorProfileScreen extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorProfileScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Banner and Back Button
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary.withOpacity(0.8)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, size: 60, color: AppColors.primary),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Dr. ${doctor.firstName} ${doctor.lastName}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        doctor.specialty,
                        style: const TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Details Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatColumn('Experience', '8+ Years'),
                      _buildStatColumn('Rating', '${doctor.rating}'),
                      _buildStatColumn('Reviews', '${doctor.reviewCount}'),
                    ],
                  ),
                  const SizedBox(height: 30),
                  
                  const Text(
                    'About Doctor',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Dr. ${doctor.lastName} is a highly skilled ${doctor.specialty} with over 8 years of experience in providing quality healthcare. Known for a patient-centric approach and expertise in modern medical practices.',
                    style: const TextStyle(color: Colors.black54, height: 1.5),
                  ),
                  const SizedBox(height: 30),
                  
                  const Text(
                    'Clinic Location',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: AppColors.accent),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          doctor.clinicLocation,
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  
                  const Text(
                    'Availability',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildAvailabilityRow('Monday - Friday', '09:00 AM - 05:00 PM'),
                  _buildAvailabilityRow('Saturday', '10:00 AM - 02:00 PM'),
                  const SizedBox(height: 100), // Bottom padding for buttons
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: GetBuilder<BookingController>(
          init: BookingController(),
          builder: (controller) => Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => controller.bookAppointment(
                    doctor: doctor, 
                    type: AppointmentType.clinicVisit
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    side: const BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('CLINIC VISIT', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: ElevatedButton(
                  onPressed: doctor.homeVisitAvailable ? () => controller.bookAppointment(
                    doctor: doctor, 
                    type: AppointmentType.homeVisit
                  ) : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('HOME VISIT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary),
        ),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _buildAvailabilityRow(String day, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(day, style: const TextStyle(color: Colors.black87)),
          Text(time, style: const TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
