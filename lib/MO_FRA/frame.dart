import 'package:aboutfcseoul/MO_ABT/about_kleague.dart';
import 'package:aboutfcseoul/MO_NEW/news.dart';
import 'package:aboutfcseoul/MO_SCH/schedule.dart';
import 'package:aboutfcseoul/common/fc_http.dart';
import 'package:flutter/material.dart';

class Frame extends StatefulWidget {
  const Frame({Key? key}) : super(key: key);

  @override
  State<Frame> createState() => _FrameState();
}

class _FrameState extends State<Frame> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 3,
      vsync: this, //vsync에 this 형태로 전달해야 애니메이션이 정상 처리됨
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FC 서울')),
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
                  child: const Text('정보'))
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
                    color: Colors.green[200],
                    alignment: Alignment.center,
                    child: const News()),
                Container(
                    color: Colors.green[200],
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(12),
                    child: Schedule()),
                Container(
                    color: Colors.green[200],
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(12),
                    child: const AboutKleague()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
