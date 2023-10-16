import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isibi/app/shared/theme.dart';
import 'package:video_player/video_player.dart';

class ChewieListItem extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;
  final String kamus_title;

  const ChewieListItem(
      {Key? key,
      required this.videoPlayerController,
      required this.looping,
      required this.kamus_title})
      : super(key: key);

  @override
  State<ChewieListItem> createState() => _ChewieListItemState();
}

class _ChewieListItemState extends State<ChewieListItem> {
  ChewieController? _chewieController;

  @override
  void initState() {
    _chewieController = ChewieController(
        videoPlayerController: widget.videoPlayerController,
        aspectRatio: 16 / 9,
        autoInitialize: true,
        looping: widget.looping,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
              style: semibold.copyWith(fontSize: 20, color: Colors.white),
            ),
          );
        });
    super.initState();
  }

  @override
  void dispose() {
    widget.videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(7),
      child: Column(
        children: [
          Text("asdas"),
          SizedBox(
            height: 10,
          ),
          Chewie(controller: _chewieController!)
        ],
      ),
    );
  }
}
