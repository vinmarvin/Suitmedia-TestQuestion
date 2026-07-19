import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      middleText: isPalindrome
          ? 'Input Termasuk Palindrome'
          : 'Input Bukan Palindrome',
      textConfirm: 'OK',
      confirmTextColor: Colors.white,
      onConfirm: () => Get.back(),
    );
  }

  void goToSecondScreen() {
    String name = nameController.text.trim();
    if (name.isEmpty) {
      Get.defaultDialog(title: 'Error', middleText: 'Please enter your name');
      return;
    }
    Get.toNamed(AppRoutes.dashboard, arguments: name);
  }
}
