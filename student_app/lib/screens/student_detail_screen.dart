import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/api_service.dart';
import 'student_form_screen.dart';
import '../Widgets/app_header.dart';
import '../Widgets/app_footer.dart';

// Correct import
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class StudentDetailScreen extends StatefulWidget {
  final Student student;

  const StudentDetailScreen({super.key, required this.student});

  @override
  State<StudentDetailScreen> createState() => _StudentDetailScreenState();
}

class _StudentDetailScreenState extends State<StudentDetailScreen> {
  final ApiService _api = ApiService();
  bool _deleting = false;

  // Correct desktop detection
  bool isWebDesktop() =>
      kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS;

  Future<void> _delete() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Profile?'),
        content: const Text(
            'Are you sure you want to delete this student profile? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() => _deleting = true);

    try {
      await _api.deleteStudent(widget.student.id);
      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error deleting: $e')));
      }
    } finally {
      if (mounted) setState(() => _deleting = false);
    }
  }

  Future<void> _edit() async {
    final changed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => StudentFormScreen(student: widget.student),
      ),
    );

    if (changed == true && mounted) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.student;

    return Scaffold(
      appBar: isWebDesktop()
          ? null
          : AppBar(
              title: Text(s.name), // FIXED
            ),

body: Column(
  children: [
    if (isWebDesktop()) const AppHeader(),

    Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            Hero(
              tag: 'avatar_${s.id}',
              child: CircleAvatar(
                radius: 48,
                backgroundColor: Colors.blue.shade100,
                child: Text(
                  s.name.isNotEmpty ? s.name[0].toUpperCase() : '?',
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              s.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              s.email,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF757575),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 3,
              shadowColor: Colors.black12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _infoRow('Degree Program', s.degreeProgram ?? 'N/A'),
                    _infoRow('Specialization', s.specialization ?? 'N/A'),
                    _infoRow('University', s.university ?? 'N/A'),
                    _infoRow('Registration Number',
                        s.registrationNumber ?? 'N/A'),
                    _infoRow('Batch Year', s.batchYear?.toString() ?? 'N/A'),
                    _infoRow(
                      'Registered At',
                      s.createdAt.toLocal().toString(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),

    Padding(
      padding: const EdgeInsets.only(bottom: 12.0, right: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'edit_${s.id}',
            onPressed: _edit,
            child: const Icon(Icons.edit),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            heroTag: 'delete_${s.id}',
            backgroundColor: Colors.red,
            onPressed: _deleting ? null : _delete,
            child: _deleting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  )
                : const Icon(Icons.delete),
          ),
        ],
      ),
    ),

    const AppFooter(),
  ],
),


      // floatingActionButton: Row(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     FloatingActionButton(
      //       heroTag: 'edit_${s.id}',
      //       onPressed: _edit,
      //       child: const Icon(Icons.edit),
      //     ),
      //     const SizedBox(width: 16),
      //     FloatingActionButton(
      //       heroTag: 'delete_${s.id}',
      //       backgroundColor: Colors.red,
      //       onPressed: _deleting ? null : _delete,
      //       child: _deleting
      //           ? const SizedBox(
      //               width: 20,
      //               height: 20,
      //               child: CircularProgressIndicator(
      //                 strokeWidth: 2,
      //                 valueColor: AlwaysStoppedAnimation(Colors.white),
      //               ),
      //             )
      //           : const Icon(Icons.delete),
      //     ),
      //   ],
      // ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
