import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class DashboardViewModel extends GetxController {
  final RxString name = ''.obs;
  final RxString selectedUserName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Mengambil argumen nama dari First Screen
    name.value = Get.arguments as String? ?? 'Guest';
  }

  Future<void> goToThirdScreen() async {
    // Menunggu hasil ketika kembali dari Third Screen
    final result = await Get.toNamed(AppRoutes.userprofile);
    if (result != null && result is String) {
      selectedUserName.value = result;
    }
  }
}
