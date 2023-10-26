import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

class VideoController extends GetxController {
  var category;
  late VideoPlayerController videoPlayerController;
  TextEditingController textEditingController = TextEditingController();
  ChewieController? chewieController;

  var data = [].obs;
  var dataVideoKata = [].obs;
  var urlVideo = [].obs;

  final count = 0.obs;
  @override
  void onInit() {
    category = Get.arguments;

    initializedPlayer();

    // if (category == "abjad") {
    //   fetchVideoAbjad();
    // } else if (category == "angka") {
    //   fetchVideoAngka();
    // } else if (category == "kata") {
    //   fetchVideoKata();
    // }

    // print(category);
    super.onInit();
    // fetchVideoKata();
    // checkhData();
    // textEditingController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    // videoPlayerController.dispose();
    // chewieController?.dispose();
    // textEditingController.dispose();
  }

  void increment() => count.value++;

  // Future fetchVideoKata() async {
  //   Uri url = Uri.parse("https://api.isibi.web.id/kata");

  //   final response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     final ready = json.decode(response.body)['data'];

  //     // print(ready);
  //     data.addAll(ready);
  //     // urlVideo.add(ready['kamus_url']);
  //     print(data);

  //     // print(ready['kamus_url']);
  //   } else {
  //     throw Exception('Failed to load news');
  //   }

  //   // news.assignAll(data.map((item) => DetailNews.fromJson(item)).toList());
  // }

  // Future fetchVideoAngka() async {
  //   Uri url = Uri.parse("https://api.isibi.web.id/angka");

  //   final response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     final ready = json.decode(response.body)['data'];

  //     // print(ready);
  //     data.addAll(ready);
  //     print(data);
  //   } else {
  //     throw Exception('Failed to load news');
  //   }

  //   // news.assignAll(data.map((item) => DetailNews.fromJson(item)).toList());
  // }

  // Future fetchVideoAbjad() async {
  //   Uri url = Uri.parse("https://api.isibi.web.id/abjad");

  //   final response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     final ready = json.decode(response.body)['data'];

  //     // print(ready);
  //     data.addAll(ready);

  //     print(data);
  //   } else {
  //     throw Exception('Failed to load news');
  //   }

  //   // news.assignAll(data.map((item) => DetailNews.fromJson(item)).toList());
  // }

  Future<void> initializedPlayer() async {
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(category["kamus_url"]));

    await Future.wait([videoPlayerController.initialize()]);

    // await videoPlayerController.initialize();

    chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: true,
        aspectRatio: 16 / 9,
        materialProgressColors: ChewieProgressColors(
            playedColor: Colors.lightBlue,
            handleColor: Colors.blue,
            backgroundColor: Colors.white,
            bufferedColor: Colors.grey),
        // placeholder: Container(
        //   height: 50,
        //   width: 50,
        // ),
        // AspectRatio(
        //   aspectRatio: videoPlayerController.value.aspectRatio,
        //   child: VideoPlayer(videoPlayerController),
        // ),
        autoInitialize: true);
    update();
  }

  // checkhData() {
  //   if (data.value.isEmpty) {
  //     data.value = "https://pmpk.kemdikbud.go.id/sibi/SIBI/katadasar/Aku.webm";
  //   } else if (data.value.isNotEmpty) {
  //     data.value =
  //         "https://pmpk.kemdikbud.go.id/sibi/SIBI/katadasar/${data.value}.webm";
  //   }

  //   print(data.value);
  // }
}
