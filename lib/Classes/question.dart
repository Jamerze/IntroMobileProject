class Question {
  final String answers;
  final String correct_answer;
  final String question;
  final String questionType;
  final String question_id;

  const Question({
    required this.answers,
    required this.correct_answer,
    required this.question,
    required this.questionType,
    required this.question_id}
  );

  factory Question.fromMap(Map<String, dynamic> data){
    return Question(answers: data['answers'],
    correct_answer: data['correct_answer'],
    question: data['question'],
    questionType:  data['questionType'],
    question_id: data['question_id']);
  }
}