import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/api_service.dart';
import 'student_form_screen.dart';

class StudentDetailScreen extends StatefulWidget{
  final Student student;

  const StudentDetailScreen({super.key, required this.student});

  @override
  State<StudentDetailScreen> createState() => _StudentDetailScreenState();
}

class _StudentDetailScreenState extends State<StudentDetailScreen>{
  final ApiService _api = ApiService();
  bool _deleting = false;

  Future<void> _delete() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder:(context) => AlertDialog(
        title: const Text('Delete Profile?'),
        content: const Text('Are you sure you want to delete this student profile? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() {
      _deleting = true;
    });

    try {
      await _api.deleteStudent(widget.student.id);
      if (mounted) {
        Navigator.pop(context, true); // Indicate deletion
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting student profile: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _deleting = false);
    }
  }

  Future<void> _edit() async{
    final changed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => StudentFormScreen(student: widget.student),
      ),
    );

    if (changed == true && mounted){
      Navigator.pop(context, true); // Indicate edited
    }
  }

  @override
  Widget build(BuildContext context){
    final s = widget.student;

    return Scaffold(
      appBar: AppBar(
        title: Text(s.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _edit,
          ),
        ],
      ),


      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: const Text('Name'),
            subtitle: Text(s.name),
          ),
          ListTile(
            title: const Text('Email'),
            subtitle: Text(s.email),
          ),
          ListTile(
            title: const Text('Degree Program'),
            subtitle: Text(s.degreeProgram ?? 'N/A'),
          ),
          ListTile(
            title: const Text('Specialization'),
            subtitle: Text(s.specialization ?? 'N/A'),
          ),
          ListTile(
            title: const Text('University'),
            subtitle: Text(s.university ?? 'N/A'),
          ),
          ListTile(
            title: const Text('Registration Number'),
            subtitle: Text(s.registrationNumber ?? 'N/A'),
          ),
          ListTile(
            title: const Text('Batch Year'),
            subtitle: Text(s.batchYear?.toString() ?? 'N/A'),
          ),
          ListTile(
            title: const Text('Registered At'),
            subtitle: Text(s.createdAt.toLocal().toString()),
          ),
        ]
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _deleting ? null : _delete,
        backgroundColor: Colors.red,
        child: _deleting
            ? const CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(Colors.white),
            )
            : const Icon(Icons.delete),
      ),
    );
  }
}     