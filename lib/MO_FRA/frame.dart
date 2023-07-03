import 'package:aboutfcseoul/MO_ABT/about_kleague.dart';
import 'package:aboutfcseoul/MO_NEW/news.dart';
import 'package:aboutfcseoul/MO_SCH/schedule.dart';
import 'package:aboutfcseoul/MO_SNG/song.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';

class Frame extends StatefulWidget {
  const Frame({Key? key}) : super(key: key);

  @override
  State<Frame> createState() => _FrameState();
}

class _FrameState extends State<Frame> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _txt = TextEditingController();

  @override
  void initState() {
    _tabController = TabController(
      length: 4,
      vsync: this, //vsync에 this 형태로 전달해야 애니메이션이 정상 처리됨
    );
    super.initState();
    check('접속', '너');
  }

  Future<void> check(String check, String who) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final docParty = FirebaseFirestore.instance.collection('check').doc();

    final info = await deviceInfo.deviceInfo;

    String device = info.data.toString();
    final json = {
      'id': device,
      'date': DateTime.now(),
      'check': who,
      'type': check
    };
    await docParty.set(json);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FC 서울'),
        actions: [
          Container(alignment: Alignment.center, child: const Text('다운')),
          IconButton(
              onPressed: () {
                Get.defaultDialog(
                  title: 'APK 다운',
                  content: const Text(
                      '카카오ID: 94wogud\n이메일:kjh990011@gmail.com\n연락주세요.\napk 다운 받는법 공부중 ㅠ'),
                  textConfirm: '확인',
                  confirmTextColor: Colors.white,
                  onConfirm: Get.back,
                );
              },
              icon: const Icon(Icons.android)),
          Container(alignment: Alignment.center, child: const Text('개선점')),
          IconButton(
              onPressed: () {
                check('개선', '너');

                Get.defaultDialog(
                  title: '개선 사항',
                  content: SizedBox(
                    child: TextField(
                      controller: _txt,
                      maxLines: 6,
                    ),
                  ),
                  textConfirm: '전송',
                  confirmTextColor: Colors.white,
                  onConfirm: () async {
                    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                    final docParty =
                        FirebaseFirestore.instance.collection('report').doc();

                    String report = _txt.text;
                    final info = await deviceInfo.deviceInfo;

                    String device = info.data.toString();
                    final json = {
                      'report': report,
                      'id': device,
                      'date': DateTime.now(),
                      'check': '너'
                    };
                    await docParty.set(json).then((value) => Get.back());
                  },
                  textCancel: '취소',
                  onCancel: Get.back,
                );
              },
              icon: const Icon(Icons.question_answer_sharp))
        ],
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: [
              Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text('소식')),
              Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text('일정')),
              Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text('정보')),
              Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text('응원가'))
            ],
            indicator: const BoxDecoration(color: Color(0xffffd700)),
            labelColor: Colors.red, //선택된 Tab 의 label 색상
            unselectedLabelColor: Colors.grey, //선
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Container(
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: const News()),
                Container(
                    color: Colors.black,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(12),
                    child: Schedule()),
                Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(12),
                    child: const AboutKleague()),
                Container(
                    color: Colors.black,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(12),
                    child: const Song()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
