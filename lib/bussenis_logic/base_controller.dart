import 'package:get/state_manager.dart';

class BaseController extends GetxController {
  RxBool isLoading = false.obs;

  activateloading() {
    isLoading.value = true;
  }

  deActivateloading() {
    isLoading.value = false;
  }
}
