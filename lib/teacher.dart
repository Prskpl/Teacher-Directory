// teacher.dart (Model)
class Teacher {
  final String name;
  final String subject;
  final int experience;

  Teacher({required this.name, required this.subject, required this.experience});

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      name: json['name'],
      subject: json['subject'],
      experience: json['experience'],
    );
  }
}
