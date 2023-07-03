import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart' as webyoutube;

class SongDetail extends StatefulWidget {
  final String title;
  final String lyric;
  final String descp;
  final String url;
  const SongDetail(
      {Key? key,
      required this.title,
      required this.lyric,
      required this.descp,
      required this.url})
      : super(key: key);

  @override
  State<SongDetail> createState() => _SongDetailState();
}

class _SongDetailState extends State<SongDetail> {
  late YoutubePlayerController _ycontroller =
      YoutubePlayerController(initialVideoId: 'a');
  late webyoutube.YoutubePlayerController _wcontroller =
      webyoutube.YoutubePlayerController();
  late String _id;

  Future<void> check() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final docParty = FirebaseFirestore.instance.collection('check').doc();

    final info = await deviceInfo.deviceInfo;

    String device = info.data.toString();
    final json = {'id': device, 'date': DateTime.now(), 'check': '너'};
    await docParty.set(json);
  }

  @override
  void initState() {
    super.initState();
    check();

    _id = YoutubePlayer.convertUrlToId(widget.url)!;
    if (GetPlatform.isWeb) {
      _wcontroller = webyoutube.YoutubePlayerController.fromVideoId(
        videoId: _id,
        params: const webyoutube.YoutubePlayerParams(
          mute: false,
          showFullscreenButton: true,
          loop: false,
        ),
      );
    } else {
      _ycontroller = YoutubePlayerController(
        initialVideoId: _id,
        flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: true,
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _ycontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (GetPlatform.isWeb) {
      return webyoutube.YoutubePlayerScaffold(
        controller: _wcontroller,
        aspectRatio: 16 / 9,
        builder: (context, player) {
          return Scaffold(
              appBar: AppBar(title: Text(widget.title)),
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: Get.width,
                          height: Get.width * 9 / 16,
                          child: player),
                      const Text('설명',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.descp.replaceAll('\\n', '\n')),
                      ),
                      const Text('가사',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.lyric.replaceAll('\\n', '\n')),
                      )
                    ],
                  ),
                ),
              ));
        },
      );
    } else {
      return Scaffold(
          appBar: AppBar(title: Text(widget.title)),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    width: Get.width,
                    height: Get.width * 9 / 16,
                    child: YoutubePlayer(controller: _ycontroller),
                  ),
                  const Text('설명',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.descp.replaceAll('\\n', '\n'),
                    ),
                  ),
                  const Text('가사',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.lyric.replaceAll('\\n', '\n'),
                        style: const TextStyle(fontSize: 16)),
                  )
                ],
              ),
            ),
          ));
    }
  }
}
