import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:video_player/video_player.dart';

class VideoWidgat extends StatefulWidget {
  const VideoWidgat({super.key});

  @override
  State<VideoWidgat> createState() => _VideoWidgatState();
}

class _VideoWidgatState extends State<VideoWidgat> {
   late final player ;
   late VideoPlayerController _videoPlayerController;
  void initState() {
    super.initState();
    player=Player();
    _videoPlayerController = VideoPlayerController.asset('assets/chat.mp4');

    _videoPlayerController.initialize().then((_){
      setState(() {
        _videoPlayerController.play();
      });
    });
  }

   String formatDuration(Duration duration) {
     String twoDigits(int n) => n.toString().padLeft(2, '0');
     final hours = twoDigits(duration.inHours);
     final minutes = twoDigits(duration.inMinutes.remainder(60));
     final seconds = twoDigits(duration.inSeconds.remainder(60));
     return '${hours}:${minutes}:${seconds}';
   }
   void seekToPosition(Duration position) {
     _videoPlayerController.seekTo(position);
   }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: VideoPlayer(_videoPlayerController)
        ),

    Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          '${formatDuration(_videoPlayerController.value.position)} / ${formatDuration(_videoPlayerController.value.duration)}',
          style: TextStyle(fontSize: 16.0,color: Colors.grey),
        ),
        Row(
          children: [
            Visibility(
              visible: _videoPlayerController.value.isPlaying,
              child: Container(
                child: IconButton(
                  icon: Icon(Icons.pause,color: Colors.grey,size: 50),
                  onPressed: (){
                    setState(() {
                      _videoPlayerController.pause();
                    });
                  },
                ),
              ),
              replacement: Container(
                child: IconButton(
                  icon: Icon(Icons.play_arrow,color: Colors.grey,size: 50),
                  onPressed: (){
                    setState(() {
                      _videoPlayerController.play();

                    });
                  },
                ),
              ),

            ),
            Expanded(
              child: VideoProgressIndicator(
                _videoPlayerController,
                allowScrubbing: true,
                colors: const VideoProgressColors(
                  playedColor: Colors.grey,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.forward_10,color: Colors.grey,size: 50,),
              onPressed: () {
                seekToPosition(_videoPlayerController.value.position + Duration(seconds: 2));
              },
            ),

          ],
        ),
      ],
    )



      ],
    );
  }
}
