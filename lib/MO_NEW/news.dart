import 'package:aboutfcseoul/MO_NEW/controller/news_controller.dart';
import 'package:aboutfcseoul/MO_NEW/widgets/scoreboard.dart';
import 'package:aboutfcseoul/common/fc_http.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:url_launcher/url_launcher.dart';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  final getController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            const Text('최근 경기',
                style: TextStyle(fontSize: 30, color: Colors.white)),
            const SizedBox(height: 10),
            Container(
              width: Get.width / 5 * 4,
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red)),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('match')
                    .doc('current')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  } else {
                    Map<String, dynamic> map = snapshot.data!.data()!;
                    return Scoreboard(map: map);
                  }
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Divider(color: Colors.red, thickness: 2),
            ),
            SizedBox(
              height: 50,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('keyword')
                    .orderBy('despnum')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                      width: 100,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red)),
                      child: const Text('FC서울'),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ElevatedButton(
                              onPressed: () {
                                getController.changeKeyword(
                                    snapshot.data!.docs[index].get('keyword'));
                              },
                              child: Text(
                                snapshot.data!.docs[index].get('keyword'),
                                overflow: TextOverflow.ellipsis,
                              ));
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            width: 7,
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            GetBuilder<NewsController>(builder: (controller) {
              return FutureBuilder<Map<String, dynamic>>(
                future: FcHttp.callApi(controller.keyword),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  } else {
                    List<dynamic> list = snapshot.data!['items'];
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: list.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          margin: const EdgeInsets.fromLTRB(10.0, 5, 10, 5),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text(
                                  parse(list[index]['title'])
                                      .body!
                                      .innerHtml
                                      .replaceAll('<b>', '')
                                      .replaceAll('</b>', ''),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                const SizedBox(height: 5),
                                /*Expanded(
                                      child: Text(parse(list[index]['description'])
                                          .body!
                                          .innerHtml),
                                    ),*/
                                InkWell(
                                    onTap: () {
                                      launchUrl(Uri.parse(list[index]['link']));
                                    },
                                    child: Text(
                                      parse(list[index]['link'])
                                          .body!
                                          .innerHtml,
                                      style: const TextStyle(
                                          color: Colors.blue, fontSize: 14),
                                    )),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              );
            }),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
