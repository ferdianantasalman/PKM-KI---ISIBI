import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

class TranslatorController extends GetxController {
  late CameraController cameraController;

  late List<CameraDescription> cameras;

  late CameraImage cameraImage;

  var isCameraInitialized = false.obs;
  var cameraCount = 0;

  final webViewController = WebViewController()
    ..loadRequest(Uri.parse("https://handsign-tensorflow.vercel.app/"));

  final count = 0.obs;
  @override
  void onInit() {
    initCamera() async {
      if (await Permission.camera.request().isGranted) {
        cameras = await availableCameras();

        cameraController = CameraController(cameras[0], ResolutionPreset.max);

        await cameraController.initialize().then((value) {
          cameraController.startImageStream((image) {
            cameraCount++;

            if (cameraCount % 10 == 0) {
              cameraCount = 0;
              // objectDetector(image);
            }
            update();
          });
        });
        isCameraInitialized(true);
        update();
      } else {
        print("Permission denied");
      }
    }

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
