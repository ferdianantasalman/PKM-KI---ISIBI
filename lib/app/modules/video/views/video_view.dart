import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:isibi/app/shared/theme.dart';
import 'package:isibi/app/widgets/chewie_list_item.dart';
import 'package:video_player/video_player.dart';

import '../controllers/video_controller.dart';
import 'package:chewie/chewie.dart';
// import 'package:video_player/video_player.dart';

class VideoView extends GetView<VideoController> {
  final videoC = Get.find<VideoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        // asdasd
        title: Text('Belajar Bahasa Isyarat',
            style: bold.copyWith(fontSize: 20, color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GetBuilder<VideoController>(
            init: VideoController(),
            builder: (controller) {
              return AspectRatio(
                aspectRatio: 16 / 9,
                child: controller.chewieController != null &&
                        controller.chewieController!.videoPlayerController.value
                            .isInitialized
                    ? Chewie(controller: controller.chewieController!)
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Loading",
                            style: regular.copyWith(
                                color: Colors.black, fontSize: 15),
                          )
                        ],
                      ),
              );
            }),
      ),
      // Obx(() => ListView.builder(
      //       itemCount: videoC.data.length,
      //       itemBuilder: (context, index) {
      //         final videoItem = videoC.data[index];
      //         print(videoItem['kamus_title']);
      //         return Padding(
      //             padding: const EdgeInsets.all(10.0),
      //             child: GetBuilder<VideoController>(
      //               init: VideoController(),
      //               builder: (controller) {
      //                 return AspectRatio(
      //                     aspectRatio: 16 / 9,
      //                     child: videoItem != null
      //                         ? ChewieListItem(
      //                             videoPlayerController:
      //                                 VideoPlayerController.networkUrl(
      //                                     Uri.parse(videoItem['kamus_url'])),
      //                             looping: true,
      //                             kamus_title: videoItem['kamus_title'])
      //                         : Center(
      //                             child: CircularProgressIndicator(),
      //                           ));
      //               },
      //             ));
      //       },
      //     ))
      // ListView.builder(
      //     itemCount: videoC.dataVideoKata.length,
      //     itemBuilder: (context, index) {
      //       final videoItem = videoC.dataVideoKata[index];
      //       return Padding(
      //         padding: const EdgeInsets.all(10.0),
      //         child: GetBuilder<VideoController>(
      //             init: VideoController(),
      //             builder: (controller) {
      //               return AspectRatio(
      //                 aspectRatio: 16 / 9,
      //                 child: controller.chewieController != null &&
      //                         controller.chewieController!
      //                             .videoPlayerController.value.isInitialized
      //                     ? Chewie(controller: controller.chewieController!)
      //                     : Column(
      //                         mainAxisAlignment: MainAxisAlignment.center,
      //                         children: [
      //                           const CircularProgressIndicator(),
      //                           const SizedBox(
      //                             height: 10,
      //                           ),
      //                           Text(
      //                             "Loading",
      //                             style: GoogleFonts.poppins(
      //                                 color: Colors.black, fontSize: 15),
      //                           )
      //                         ],
      //                       ),
      //               );
      //             }),
      //       );
      //     })

      // Center(
      //   child: Column(
      //     children: [
      //       Padding(
      //         padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
      //         child: TextField(
      //           controller: videoC.textEditingController,
      //           onSubmitted: (value) {
      //             videoC.data.value = videoC.textEditingController.text;
      //             print(videoC.data.value);
      //           },
      //           decoration: InputDecoration(
      //               contentPadding: const EdgeInsets.symmetric(
      //                   vertical: 10.0, horizontal: 15),
      //               hintText: "Seacrh",
      //               suffixIcon: const Icon(Icons.search),
      //               border: OutlineInputBorder(
      //                   borderRadius: BorderRadius.circular(20.0),
      //                   borderSide: const BorderSide())),
      //         ),
      //       ),
      //       Obx(
      //         () => Text(
      //           'Bahasa Isyarat dari  ${videoC.data.value}',
      //           // 'Bahasa Isyarat dari ${videoC.data.value} ',
      //           style: GoogleFonts.poppins(color: Colors.black, fontSize: 15),
      //         ),
      //       ),
    );
  }
}
