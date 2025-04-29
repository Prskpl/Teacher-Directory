// main.dart (Flutter App)
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'teacher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teacher List',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TeacherListPage(),
    );
  }
}

class TeacherListPage extends StatefulWidget {
  @override
  _TeacherListPageState createState() => _TeacherListPageState();
}

class _TeacherListPageState extends State<TeacherListPage> {
  List<Teacher> teachers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTeachers();
  }

  Future<void> fetchTeachers() async {
    final url = Uri.parse("http://192.168.1.12:8000/teachers"); // API endpoint
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List jsonData = json.decode(response.body);
        setState(() {
          teachers = jsonData.map((data) => Teacher.fromJson(data)).toList();
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching teachers: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Teachers')),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading spinner
          : ListView.builder(
        itemCount: teachers.length,
        itemBuilder: (context, index) {
          final teacher = teachers[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: CircleAvatar(child: Text(teacher.name[0])),
              title: Text(teacher.name),
              subtitle: Text('${teacher.subject} • ${teacher.experience} years'),
            ),
          );
        },
      ),
    );
  }
}
