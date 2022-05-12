class Student {
  static Student _currentStudent = Student("", "");
  Student(String _studentNumber, String _name) {
    studentNumber = _studentNumber;
    name = _name;
  }
  String studentNumber = "";
  String name = "";

  static void setCurrentStudent(Student s) {
    _currentStudent = s;
  }

  static Student getCurrentStudent() {
    return _currentStudent;
  }
}
