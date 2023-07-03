import 'package:get/get.dart';

class ScheController extends GetxController {
  bool desc = true;

  void changeSort() {
    desc = !desc;
    update();
  }
}
