import 'package:flutter/material.dart';

class Scoreboard extends StatelessWidget {
  final Map<String, dynamic> map;
  const Scoreboard({Key? key, required this.map}) : super(key: key);

  String setScorerList(String scorer, String time) {
    String rtn = "";
    List<String> scorerList = scorer.split(';');
    List<String> timeList = time.split(';');
    for (int i = 0; i < scorerList.length; i++) {
      if (i != 0) {
        rtn += '\n';
      }
      rtn += '${scorerList[i]} - ${timeList[i]}';
    }
    return rtn;
  }

  @override
  Widget build(BuildContext context) {
    String hScorers = setScorerList(map['hscorer'], map['htime']);
    String aScorers = setScorerList(map['ascorer'], map['atime']);
    /* String hscore =
        map['hscorer'] == '' ? '' : '${map['hscorer']} - ${map['htime']}';
    String ascore =
        map['ascorer'] == '' ? '' : '${map['ascorer']} - ${map['atime']}';*/
    return Column(
      children: [
        Text(
          map['matchday'],
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Text(
              map['home'],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            )),
            Expanded(
                child: Text(
              map['away'],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            )),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Text(
              map['hscore'],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 25, color: Colors.white),
            )),
            Expanded(
                child: Text(
              map['ascore'],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 25, color: Colors.white),
            )),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Text(
              hScorers,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 17,
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold),
            )),
            Expanded(
                child: Text(
              aScorers,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 17,
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold),
            )),
          ],
        ),
      ],
    );
  }
}
