import 'package:flutter_countdown_timer/countdown_timer_controller.dart';

class Exam {
  static int currentQuestion = 0;
  static var questions = [];
  static var posAnswers = [];
  static var answers = [];
  Exam() {
    int endTime =
        DateTime.now().millisecondsSinceEpoch + 1000 * 60 * examLength;
    controller = CountdownTimerController(endTime: endTime, onEnd: submit);
  }
  int examLength = 20;

  CountdownTimerController controller = CountdownTimerController(endTime: 0);
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;
  var correctAnswers = [];
  int score = 0;

  void submit() {}
}
