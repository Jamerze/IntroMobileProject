class Student {
  static Student _currentStudent = Student("", "", "");
  Student(String _studentNumber, String _name, String _points) {
    studentNumber = _studentNumber;
    name = _name;
    points = _points;
  }
  String studentNumber = "";
  String name = "";
  String points = "0";

  static void setCurrentStudent(Student s) {
    _currentStudent = s;
  }

  static Student getCurrentStudent() {
    return _currentStudent;
  }
}
