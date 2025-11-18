import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/api_service.dart';

class StudentFormScreen extends StatefulWidget {
  final Student? student; // null ==> create, non-null => edit

  const StudentFormScreen({super.key, this.student});

  @override
  State<StudentFormScreen> createState() => _StudentFormScreenState();
}

class _StudentFormScreenState extends State<StudentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _api = ApiService();

  //controllers
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _degreeCtrl = TextEditingController();
  final _specCtrl = TextEditingController();
  final _uniCtrl = TextEditingController();
  final _regCtrl = TextEditingController();
  final _batchCtrl = TextEditingController();

  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final s = widget.student;
    if (s != null) {
      _nameCtrl.text = s.name;
      _emailCtrl.text = s.email;
      _degreeCtrl.text = s.degreeProgram ?? '';
      _specCtrl.text = s.specialization ?? '';
      _uniCtrl.text = s.university ?? '';
      _regCtrl.text = s.registrationNumber ?? '';
      _batchCtrl.text = s.batchYear?.toString() ?? '';
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _degreeCtrl.dispose();
    _specCtrl.dispose();
    _uniCtrl.dispose();
    _regCtrl.dispose();
    _batchCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);

    try {
      final name = _nameCtrl.text.trim();
      final email = _emailCtrl.text.trim();
      final degree =
          _degreeCtrl.text.trim().isEmpty ? null : _degreeCtrl.text.trim();
      final spec =
          _specCtrl.text.trim().isEmpty ? null : _specCtrl.text.trim();
      final uni = _uniCtrl.text.trim().isEmpty ? null : _uniCtrl.text.trim();
      final reg = _regCtrl.text.trim().isEmpty ? null : _regCtrl.text.trim();
      final batch = _batchCtrl.text.trim().isEmpty
          ? null
          : int.tryParse(_batchCtrl.text.trim());

      if (widget.student == null) {
        // Create
        await _api.createStudent(
          name: name,
          email: email,
          degreeProgram: degree,
          specialization: spec,
          university: uni,
          registrationNumber: reg,
          batchYear: batch,
        );
      } else {
        // Update
        final updated = Student(
          id: widget.student!.id,
          name: name,
          email: email,
          degreeProgram: degree,
          specialization: spec,
          university: uni,
          registrationNumber: reg,
          batchYear: batch,
          createdAt: widget.student!.createdAt,
        );
        await _api.updateStudent(updated);
      }

      if (mounted) {
        Navigator.pop(context, true); // indicate saved
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving student: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.student != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Student' : 'Add Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameCtrl,
                        decoration: const InputDecoration(labelText: 'Name'),
                        validator: (v) => v == null || v.trim().isEmpty
                            ? 'Name is required'
                            : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _emailCtrl,
                        decoration: const InputDecoration(labelText: 'Email'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Email is required';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                              .hasMatch(v.trim())) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _degreeCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Degree Program',
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _specCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Specialization',
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _uniCtrl,
                        decoration: const InputDecoration(
                          labelText: 'University',
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _regCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Registration Number',
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _batchCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Batch Year',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _saving ? null : _save,
                style: ElevatedButton.styleFrom(
                  minimumSize:
                      const Size.fromHeight(50), // full-width tall button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                icon: _saving
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.save),
                label: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    isEdit ? 'Update' : 'Create',
                    key: ValueKey(isEdit),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
