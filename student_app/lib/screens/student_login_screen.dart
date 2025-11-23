import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'student_list_screen.dart';
import 'student_register_screen.dart';

class StudentLoginScreen extends StatefulWidget {
  const StudentLoginScreen({super.key});

  @override
  State<StudentLoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<StudentLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _auth = AuthService();
  bool _loading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    try {
      await _auth.login(
        email: _emailCtrl.text.trim(),
        password: _passwordCtrl.text.trim(),
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const StudentListScreen()),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Failed $e")),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _goToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const StudentRegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Login')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(20),
              child: Form(key: _formKey, child: Column(mainAxisSize: MainAxisSize.min, children: [
                TextFormField(
                  controller: _emailCtrl,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Email Required' : null,
                ),
                const SizedBox(height: 12), TextFormField(
                  controller: _passwordCtrl,
                  decoration: const
                  InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Password Required': null,
                ),

                const SizedBox(height: 20),
                ElevatedButton(onPressed: _loading? null : _submit, child: _loading? const
                CircularProgressIndicator(strokeWidth: 2) : const Text('Login'),
            ),

            const SizedBox(height: 6),
            TextButton(onPressed: _goToRegister, child: const Text('Create Account'),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}