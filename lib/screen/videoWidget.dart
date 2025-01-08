import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

class SamplePlayer extends StatefulWidget {
  const SamplePlayer({super.key});

  @override
  _SamplePlayerState createState() => _SamplePlayerState();
}

class _SamplePlayerState extends State<SamplePlayer> {
  late FlickManager flickManager;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController:
          VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'), // Use a direct video URL
      autoPlay: false, // Disable auto-play
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      isPlaying = !isPlaying;
      if (isPlaying) {
        flickManager.flickControlManager?.play();
      } else {
        flickManager.flickControlManager?.pause();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        FlickVideoPlayer(flickManager: flickManager),
        if (!isPlaying)
          IconButton(
            icon: const Icon(Icons.play_arrow, color: Colors.white, size: 50),
            onPressed: _togglePlayPause,
          ),
      ],
    );
  }
}
