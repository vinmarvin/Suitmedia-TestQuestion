import 'package:get/get.dart';
import '../data/models/user_model.dart';
import '../data/repositories/user_repository.dart';

class UserprofileViewModel extends GetxController {
  final UserRepository _repository = UserRepository();
  
  final RxList<UserModel> users = <UserModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadMore = false.obs;
  final RxBool hasMoreData = true.obs;
  
  int _currentPage = 1;
  final int _perPage = 10;

  @override
  void onInit() {
    super.onInit();
    fetchUsers(isRefresh: true);
  }

  Future<void> fetchUsers({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPage = 1;
      hasMoreData.value = true;
      isLoading.value = true;
    } else {
      if (!hasMoreData.value || isLoadMore.value) return;
      isLoadMore.value = true;
    }

    try {
      final newUsers = await _repository.getUsers(page: _currentPage, perPage: _perPage);
      
      if (isRefresh) {
        users.assignAll(newUsers);
      } else {
        users.addAll(newUsers);
      }

      if (newUsers.length < _perPage) {
        hasMoreData.value = false;
      } else {
        _currentPage++;
      }
    } catch (e) {
      if (isRefresh) {
        Get.snackbar('Error', 'Failed to fetch users: $e');
      }
    } finally {
      isLoading.value = false;
      isLoadMore.value = false;
    }
  }

  void selectUser(UserModel user) {
    String fullName = '${user.firstName} ${user.lastName}';
    Get.back(result: fullName);
  }
}
