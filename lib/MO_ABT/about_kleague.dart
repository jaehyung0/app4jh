import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutKleague extends StatelessWidget {
  const AboutKleague({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const Text('스플릿 라운드',
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Image.asset('assets/images/info.png'),
                const SizedBox(height: 5),
                const Text(
                  '정규 라운드는 총 33라운드 - 3번씩 대결\n1~6위는 파이널A, 7~12위는 파이널B 그룹 배치\n33라운드 이후 그룹별로 파이널 라운드 5게임을 치뤄서 1등을 정한다.\n파이널 라운드로 추가된 승점은 그룹 내에서만 순위 이동',
                  style: TextStyle(fontSize: 15),
                ),
                const Text(
                    'Ex) 38라운드가 끝난 후 파이널B의 7위팀의 승점이 50, 파이널A의 6위팀 승점이 49라도 6위와 7위의 위치는 바뀌지 않는다.',
                    style: TextStyle(color: Colors.red)),
                const SizedBox(height: 5),
                InkWell(
                  onTap: () {
                    launchUrl(Uri.parse('https://www.fmkorea.com/2095381160'));
                  },
                  child: Container(
                    alignment: Alignment.topRight,
                    child: const Text(
                      '설명 페이지',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.blue, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const Text('승강전',
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Image.asset('assets/images/play_off1.png'),
                const SizedBox(height: 10),
                Image.asset('assets/images/play_off2.png'),
                const SizedBox(height: 10),
                const Text(
                  '홈 앤드 어웨이 방식으로 1,2차전을 치른다. 1,2차전 합계점수가 동률일 경우 2차전에서 그대로 연장전을 진입하고 승부가 나지 않을 경우 승부차기를 진행한다.\nK리그2 1위, 플레이오프 승리 2팀이 K리그1로 승격을 하고 K리그1 12위는 K리그2로 강등된다.',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            padding: const EdgeInsets.all(10),
            child: const Column(
              children: [
                Text('FA CUP(하나원큐 FA CUP)',
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text(
                  '대한축구협회가 주최하는 대한민국 최상위 컵 대회. 대한축구협회에 등록한 프로 구단과 세미프로 구단, 아마추어 구단이 참가한다.\nK5리그의 아마추어 구단과 K3리그, K4리그의 세미프로 구단은 배분한 출전권에 따라 1~2라운드부터 참가하고 K리그2의 프로 구단은 2라운드부터, K리그1의 프로 구단은 3라운드부터, AFC 챔피언스 리그 출전 구단은 16강부터 참가한다.\nFA컵에서 우승하는 구단은 다음 시즌 AFC 챔피언스 리그 출전권을 부여 받는다',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const Text('AFC 챔피언스 리그(ACL)',
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text(
                  '2021년부터 참가 팀이 32개 팀에서 40개 팀으로 확대되었다. 2019년 AFC에서 2년마다 실시한 리그 평가에 따라 평가가 높은 리그의 동아시아 16개 팀, 서아시아 16개 팀에게 본선 진출 티켓을 배분하였다. 본선 진출 국가 수가 기존 최소 각 6개국에서 각 10개국으로 대폭 늘어났다. 챔피언스리그 본선에 동아시아와 서아시아가 각 본선 직행 16개팀과 플레이오프 통과팀 4팀이 참가한다.',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 5),
                InkWell(
                  onTap: () {
                    launchUrl(Uri.parse(
                        'https://namu.wiki/w/AFC%20%EC%B1%94%ED%94%BC%EC%96%B8%EC%8A%A4%20%EB%A6%AC%EA%B7%B8'));
                  },
                  child: Container(
                    alignment: Alignment.topRight,
                    child: const Text(
                      '설명 페이지',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.blue, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
