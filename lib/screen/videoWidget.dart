import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SamplePlayer extends StatefulWidget {
  final String courseId;
  const SamplePlayer({super.key ,required this.courseId});

  @override
  _SamplePlayerState createState() => _SamplePlayerState();
}

class _SamplePlayerState extends State<SamplePlayer> {
  late FlickManager flickManager = FlickManager(
    videoPlayerController: VideoPlayerController.network(''),
    autoPlay: false,
  );
  bool isPlaying = false;
  bool isLoading = true;
  Map<String, dynamic>? modulData; // Untuk menyimpan data modul


  @override
  void initState() {
    super.initState();
    fetchVideoData();
  }

  Future<void> fetchVideoData() async {
    final String url =
        'http://192.168.100.82:3000/api/modulsByCourseID/${widget.courseId}';
    try {
      print(modulData?['YTEmbedLink']);
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          modulData = jsonDecode(response.body);
          isLoading = false;
          flickManager = FlickManager(
            videoPlayerController: VideoPlayerController.network(modulData?['YTEmbedLink'] ?? 'No video'),
            autoPlay: false,
          );
        });
      } else {
        throw Exception('Failed to load modul data');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
    }
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
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Stack(
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
