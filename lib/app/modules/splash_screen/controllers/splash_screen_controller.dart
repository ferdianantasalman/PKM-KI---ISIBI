import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:isibi/app/routes/app_pages.dart';

class SplashScreenController extends GetxController {
  final getStorage = GetStorage();

  final count = 0.obs;
  @override
  void onInit() {
    // Future.delayed(Duration(milliseconds: 2000), () {
    //   getStorage.read("status")
    //       ? Get.offAllNamed(Routes.HOME)
    //       : Get.offAllNamed(Routes.INTRODUCTION);
    // });
    // if (getStorage.read("status") == true) {
    //   Future.delayed(Duration(microseconds: 2000), () {
    //     Get.offAllNamed(Routes.HOME);
    //   });
    // } else if (getStorage.read("status") == null) {
    //   Get.offAllNamed(Routes.INTRODUCTION);
    // }

    // Future.delayed(Duration(microseconds: 2000), () {
    //   Get.offAllNamed(Routes.HOME);
    // });
    super.onInit();

    // if (getStorage.read("status") != true) {
    //   Future.delayed(Duration(microseconds: 2000), () {
    //     Get.offAllNamed(Routes.HOME);
    //   });
    // } else {
    //   Get.offAllNamed(Routes.INTRODUCTION);
    // }

    print(getStorage.read("status"));
  }

  @override
  void onReady() {
    super.onReady();
    print(getStorage.read("status"));
    // Future.delayed(Duration(microseconds: 2000), () {
    //   getStorage.read("status")
    //       ? Get.offAllNamed(Routes.HOME)
    //       : Get.offAllNamed(Routes.INTRODUCTION);
    // });
    // if (getStorage.read("status") == true) {
    //   Future.delayed(Duration(microseconds: 2000), () {
    //     Get.offAllNamed(Routes.HOME);
    //   });
    // } else if (getStorage.read("status") == null) {
    //   Get.offAllNamed(Routes.INTRODUCTION);
    // }

    print(getStorage.read("status"));
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
