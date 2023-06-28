import 'package:get/get.dart';

class NewsController extends GetxController {
  String keyword = 'FC서울';

  void changeKeyword(String word) {
    keyword = word;
    update();
  }
}
