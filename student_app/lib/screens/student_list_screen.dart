import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/api_service.dart';
import 'student_detail_screen.dart';
import 'student_form_screen.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  final ApiService _api = ApiService();
  late Future<List<Student>> _futureStudents;

  @override
  void initState() {
    super.initState();
    _futureStudents = _api.getStudent();
  }

  Future<void> _refresh() async {
    setState(() {
      _futureStudents = _api.getStudent();
    });
  }

  Future<void> _openCreateForm() async {
    final changed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => const StudentFormScreen()),
    );
    if (changed == true) {
      _refresh();
    }
  }

  Future<void> _openDetail(Student s) async {
    final changed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => StudentDetailScreen(student: s),
      ),
    );
    if (changed == true) {
      _refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Registrations'),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<Student>>(
          future: _futureStudents,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final students = snapshot.data ?? [];

            if (students.isEmpty) {
              return const Center(
                  child: Text('No students registrations found.'));
            }

            return ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final s = students[index];
                return ListTile(
                  title: Text(s.name),
                  subtitle: Text(
                      '${s.email}\n${s.degreeProgram ?? ''} ${s.specialization ?? ''}'),
                  isThreeLine: true,
                  onTap: () => _openDetail(s),
                    // later add navigation to detail screen
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openCreateForm,
          // later add navigation to add student screen
        child: const Icon(Icons.add),
      ),
    );
  }
}
