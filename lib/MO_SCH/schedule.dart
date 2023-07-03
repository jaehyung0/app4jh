import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/sche_controller.dart';

class Schedule extends StatelessWidget {
  Schedule({Key? key}) : super(key: key);
  final getController = Get.put(ScheController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<ScheController>(builder: (controller) {
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('matches')
              .orderBy('round', descending: getController.desc)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            } else {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: getController.changeSort,
                          icon: const Icon(
                            Icons.change_circle_outlined,
                            color: Colors.white,
                          ))
                    ],
                  ),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      List<dynamic> list = snapshot.data!.docs;
                      return Opacity(
                        opacity: list[index]['home'] == 'A' ? 0.7 : 1,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'R${list[index]['round'].toString()}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                    ),
                                    Text(
                                      list[index]['day'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'FC서울',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Expanded(
                                        child: Text(
                                      '${list[index]['mscore']} : ${list[index]['ascore']}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    Expanded(
                                        child: Text(
                                      list[index]['vs'],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ))
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red),
                                      child: Text(
                                        list[index]['home'],
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      list[index]['stadium'],
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              ],
                            ),
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
                ],
              );
            }
          },
        );
      }),
    );
  }
}
