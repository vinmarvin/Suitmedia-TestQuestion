import 'package:get/get.dart';
import 'app_routes.dart';
import '../views/authenticate/authenticate_view.dart';
import '../views/dashboard/dashboard_view.dart';
import '../views/userprofile/userprofile_view.dart';
import '../viewmodels/authenticate_viewmodel.dart';
import '../viewmodels/dashboard_viewmodel.dart';
import '../viewmodels/userprofile_viewmodel.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.authenticate,
      page: () => AuthenticateView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AuthenticateViewModel());
      }),
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => DashboardView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => DashboardViewModel());
      }),
    ),
    GetPage(
      name: AppRoutes.userprofile,
      page: () => UserprofileView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => UserprofileViewModel());
      }),
    ),
  ];
}
