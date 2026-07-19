import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../viewmodels/userprofile_viewmodel.dart';

class UserprofileView extends GetView<UserprofileViewModel> {
  final ScrollController _scrollController = ScrollController();

  UserprofileView({super.key}) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        controller.fetchUsers();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF554AF0)),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Third Screen',
          style: GoogleFonts.poppins(
            color: AppColors.primaryText,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value && controller.users.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.users.isEmpty) {
            return Center(
              child: Text(
                'Empty',
                style: GoogleFonts.poppins(
                  color: AppColors.primaryText,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => controller.fetchUsers(isRefresh: true),
            child: ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.all(20),
              itemCount: controller.users.length + (controller.isLoadMore.value ? 1 : 0),
              separatorBuilder: (context, index) => const Divider(
                color: Color(0xFFE2E3E4),
                thickness: 1,
                height: 32,
              ),
              itemBuilder: (context, index) {
                if (index == controller.users.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final user = controller.users[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey[200],
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: user.avatar,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => CachedNetworkImage(
                          // Fallback ke picsum jika avatar asli gagal diload
                          imageUrl: 'https://picsum.photos/seed/${user.id}/200',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    '${user.firstName} ${user.lastName}',
                    style: GoogleFonts.poppins(
                      color: AppColors.primaryText,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    user.email,
                    style: GoogleFonts.poppins(
                      color: AppColors.secondaryText,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () => controller.selectUser(user),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
