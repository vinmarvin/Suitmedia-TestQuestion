import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intern_technical_test_app/views/dashboard/dashboard_view.dart';
import '../../routes/app_routes.dart';

class AuthenticateViewModel extends GetxController {
  final nameController = TextEditingController();
  final palindromeController = TextEditingController();

  @override
  void onClose() {
    nameController.dispose();
    palindromeController.dispose();
    super.onClose();
  }

  void checkPalindrome() {
    String text = palindromeController.text;
    if (text.isEmpty) {
      Get.defaultDialog(title: 'Error', middleText: 'Please enter a sentence');
      return;
    }

    // Normalisasi: hilangkan spasi & non-alfanumerik, ubah ke lowercase
    String normalized = text
        .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '')
        .toLowerCase();

    // Reverse
    String reversed = normalized.split('').reversed.join('');

    bool isPalindrome = normalized == reversed && normalized.isNotEmpty;

    Get.defaultDialog(
      title: 'Result',
      middleText: isPalindrome ? 'isPalindrome' : 'not palindrome',
      textConfirm: 'OK',
      confirmTextColor: Colors.white,
      onConfirm: () => Get.back(),
    );
  }

  void DashboardView() {
    String name = nameController.text.trim();
    if (name.isEmpty) {
      Get.toNamed(AppRoutes.dashboard, arguments: "John Doe");
    }
    Get.toNamed(AppRoutes.dashboard, arguments: name);
  }
}
