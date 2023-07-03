import 'package:aboutfcseoul/MO_SNG/song_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Song extends StatelessWidget {
  const Song({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text('경기 전',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Color(0xffffd700))),
          const SizedBox(height: 10),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('singbfmatch')
                .orderBy('dispseq')
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              } else {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      String title = snapshot.data!.docs[index].get('title');
                      String lyric = snapshot.data!.docs[index].get('lyrics');
                      String descp = snapshot.data!.docs[index].get('descp');
                      String url = snapshot.data!.docs[index].get('video');
                      return InkWell(
                        highlightColor: Colors.red,
                        onTap: () {
                          Get.to(() => SongDetail(
                              title: title,
                              lyric: lyric,
                              descp: descp,
                              url: url));
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(title,
                                style: const TextStyle(fontSize: 20)),
                          ),
                        ),
                      );
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
          const SizedBox(height: 10),
          const Text('경기 중',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Color(0xffffd700))),
          const SizedBox(height: 10),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('singfmatch')
                .orderBy('dispseq')
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              } else {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      String title = snapshot.data!.docs[index].get('title');
                      String lyric = snapshot.data!.docs[index].get('lyrics');
                      String descp = snapshot.data!.docs[index].get('descp');
                      String url = snapshot.data!.docs[index].get('video');
                      return InkWell(
                        onTap: () {
                          Get.to(() => SongDetail(
                              title: title,
                              lyric: lyric,
                              descp: descp,
                              url: url));
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(title,
                                style: const TextStyle(fontSize: 20)),
                          ),
                        ),
                      );
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
        ],
      ),
    );
  }
}
