import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/pharmacy_home_controller.dart';
import '../../core/constants/app_colors.dart';

class PharmacyHomeScreen extends StatelessWidget {
  const PharmacyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PharmacyHomeController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('MediGo Pharmacy', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: AppColors.secondary,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'New Medicine Orders',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (controller.orders.isEmpty) {
                  return const Center(child: Text('No orders yet.'));
                }
                return ListView.builder(
                  itemCount: controller.orders.length,
                  itemBuilder: (context, index) {
                    final order = controller.orders[index];
                    return _buildOrderCard(order);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(dynamic order) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Order ID: ${order.id.substring(0, 8)}', 
                  style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondary)),
              const Text('Pending', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),
          const Divider(),
          const Text('Medicines:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          ...order.medicines.map((m) => Text('• ${m.name} (${m.dosage})')).toList(),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Accept Order
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondary),
              child: const Text('ACCEPT & SHIP', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
