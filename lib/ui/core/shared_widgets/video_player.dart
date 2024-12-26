import 'package:app_eclipseworkd/domain/models/apod_model.dart';
import 'package:app_eclipseworkd/ui/core/shared_widgets/see_apod_details_btn.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoPlayer extends StatefulWidget {
  final ApodModel item;

  const YoutubeVideoPlayer({super.key, required this.item});

  @override
  State<YoutubeVideoPlayer> createState() => _YoutubeVideoPlayerState();
}

class _YoutubeVideoPlayerState extends State<YoutubeVideoPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    if (widget.item.url?.contains('youtube') == true) {
      _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.item.url!)!,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );
    } else {
      launchUrlString(widget.item.url!);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Video'),
      ),
      floatingActionButton: SeeApodDetailsBtn(
        date: widget.item.date,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              YoutubePlayerBuilder(
                player: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.blueAccent,
                ),
                builder: (context, player) {
                  return Column(
                    children: [
                      player,
                      SizedBox(height: 10),
                      Text(
                        '${widget.item.title} - ${widget.item.date}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 10),
                      Text('${widget.item.explanation}')
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
