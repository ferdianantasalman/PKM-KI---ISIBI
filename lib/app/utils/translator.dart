import 'dart:isolate';

import 'package:camera/camera.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isibi/app/utils/classes.dart';
import 'package:isibi/app/utils/classifier.dart';
import 'package:isibi/app/utils/image_utils.dart';
import 'package:isibi/app/shared/theme.dart';

import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../shared/page_index_controller.dart';
import 'isolate.dart';

class Translator extends StatefulWidget {
  @override
  State<Translator> createState() => _TranslatorState();
}

class _TranslatorState extends State<Translator> {
  late CameraController cameraController;
  late Interpreter interpreter;
  final classifier = Classifier();
  final isolateUtils = IsolateUtils();
  final pageC = Get.find<PageIndexController>();

  bool initialized = false;
  bool isWorking = false;
  DetectionClasses detected = DetectionClasses.nothing;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    // Load main isolate Interpreter
    await classifier.loadModel();

    if (await Permission.camera.request().isGranted) {
      final cameras = await availableCameras();
      // Create a CameraController object
      cameraController = CameraController(
        cameras[0], // Choose the first camera in the list
        ResolutionPreset.medium, // Choose a resolution preset
      );

      // Start Inference isolate
      await isolateUtils.start();

      // Initialize the CameraController and start the camera preview
      await cameraController.initialize();
      // Listen for image frames
      await cameraController.startImageStream((image) {
        // Make predictions only if not busy
        if (!isWorking) {
          processCameraImage(image);
        }
      });
    }
    ;

    setState(() {
      initialized = true;
    });
  }

  Future<void> processCameraImage(CameraImage cameraImage) async {
    setState(() {
      isWorking = true;
    });

    final result = await inference(cameraImage);

    if (detected != result) {
      detected = result;
    }

    setState(() {
      isWorking = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final bodyHeight = size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          centerTitle: true,
          title: Text(
            "Penerjemah",
            style: bold.copyWith(fontSize: 20, color: Colors.black),
          ),
        ),
        body: initialized
            ? Column(
                children: [
                  Container(
                      // color: Colors.amber,
                      width: double.infinity,
                      height: bodyHeight * 0.7,
                      child: CameraPreview(cameraController)),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: Colors.white),
                    width: size.width,
                    height: bodyHeight * 0.1,
                    child: Center(
                        child: Column(
                      children: [
                        Text(
                          "Terjemahan",
                          style:
                              bold.copyWith(fontSize: 20, color: Colors.black),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            "${detected.label}",
                            style: regular.copyWith(
                                fontSize: 15, color: Colors.black),
                          ),
                        )
                      ],
                    )),
                  )

                  // SizedBox(
                  //   height: Get.height,
                  //   width: double.infinity,
                  //   child: CameraPreview(cameraController),
                  // ),
                  // Text(
                  //   "Detected: ${detected.label}",
                  //   style: const TextStyle(
                  //     fontSize: 28,
                  //     color: Colors.blue,
                  //   ),
                  // ),
                ],
              )
            : const Center(child: CircularProgressIndicator()),
        bottomNavigationBar: CurvedNavigationBar(
          height: 60,
          index: 0,
          color: Color(0xff034A9E),
          animationCurve: Curves.bounceInOut,
          animationDuration: Duration(milliseconds: 300),
          backgroundColor: Colors.white,
          // style: TabStyle.fixedCircle,
          items: [
            Icon(
              Icons.home,
              size: 40,
              color: Colors.white,
            ),
            Icon(
              Icons.camera_alt_outlined,
              size: 40,
              color: Colors.white,
            ),
            Icon(
              Icons.newspaper,
              size: 40,
              color: Colors.white,
            )
          ],
          onTap: (index) {
            pageC.changePage(index);
          },
        ));
  }

  Future<DetectionClasses> inference(CameraImage cameraImage) async {
    ReceivePort responsePort = ReceivePort();
    final isolateData = IsolateData(
      cameraImage: cameraImage,
      interpreterAddress: classifier.interpreter.address,
      responsePort: responsePort.sendPort,
    );

    isolateUtils.sendPort.send(isolateData);
    var result = await responsePort.first;

    return result;
  }

  @override
  void dispose() {
    cameraController.dispose();
    isolateUtils.dispose();
    super.dispose();
  }
}
