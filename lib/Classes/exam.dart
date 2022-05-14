import 'package:flutter_countdown_timer/countdown_timer_controller.dart';

class Exam {
  Exam() {
    int endTime =
        DateTime.now().millisecondsSinceEpoch + 1000 * 60 * examLength;
    controller = CountdownTimerController(endTime: endTime, onEnd: submit);
  }
  int examLength = 20;

  CountdownTimerController controller = CountdownTimerController(endTime: 0);
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;

  int score = 0;

  void submit() {}
}
