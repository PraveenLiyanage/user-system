import 'package:flutter/material.dart';
import 'package:student_app/screens/student_login_screen.dart';
import 'package:student_app/services/auth_service.dart';
import '../models/student.dart';
import '../services/api_service.dart';
import 'student_detail_screen.dart';
import 'student_form_screen.dart';
import '../Widgets/app_header.dart';
import '../Widgets/app_footer.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  final ApiService _api = ApiService();
  late Future<void> _loadFuture;

  final TextEditingController _searchCtrl = TextEditingController();
  List<Student> _allStudents = [];
  List<Student> _filteredStudents = [];

  @override
  void initState() {
    super.initState();
    _loadFuture = _loadStudents();
    _searchCtrl.addListener(_applyFilter);
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadStudents() async {
    final list = await _api.getStudent();
    setState(() {
      _allStudents = list;
      _filteredStudents = list;
    });
  }

  void _applyFilter() {
    final query = _searchCtrl.text.trim().toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredStudents = _allStudents;
      } else {
        _filteredStudents = _allStudents.where((s) {
          return s.name.toLowerCase().contains(query) ||
              s.email.toLowerCase().contains(query) ||
              (s.degreeProgram ?? '').toLowerCase().contains(query) ||
              (s.specialization ?? '').toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  Future<void> _refresh() async {
    await _loadStudents();
  }

  Future<void> _openCreateForm() async {
    final changed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const StudentFormScreen()),
    );
    if (changed == true) {
      await _loadStudents();
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
      await _loadStudents();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Student Registrations'),
      //   actions: [
      //     IconButton(
      //         icon: const Icon(Icons.logout),
      //         onPressed: () async {
      //           final auth = AuthService();
      //           await auth.logout();
      //           if (!context.mounted) return;
      //           Navigator.pushAndRemoveUntil(
      //             context,
      //             MaterialPageRoute(builder: (_) => const StudentLoginScreen()),
      //             (route) => false,
      //           );
      //         }
      //       )
      //   ],
      // ),
      body: FutureBuilder<void>(
        future: _loadFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              _allStudents.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return RefreshIndicator(
            onRefresh: _refresh,
            child: Column(
              children: [
                const AppHeader(),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextField(
                    controller: _searchCtrl,
                    decoration: InputDecoration(
                      hintText: 'Search by Name, Email or Degree Program...',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: _filteredStudents.isEmpty
                      ? const Center(
                          child: Text('No registrations found.'),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          itemCount: _filteredStudents.length,
                          itemBuilder: (context, index) {
                            final s = _filteredStudents[index];
                            return _StudentCard(
                              student: s,
                              onTap: () => _openDetail(s),
                            );
                          },
                        ),
                ),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), 
                child: Align(
                  alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                    onPressed: _openCreateForm,
                    icon: const Icon(Icons.add),
                    label: const Text('New Student'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 202, 216, 255),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      minimumSize: const Size(150, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      )
                    ),
                  ),
                const AppFooter(),
              ],
            ),
          );
        },
      ),
    );
  }
}

      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _openCreateForm,
      //   icon: const Icon(Icons.add),
      //   label: const Text('New Student'),
      // ),

// Student Card Widget
class _StudentCard extends StatelessWidget {
  final Student student;
  final VoidCallback onTap;

  const _StudentCard({required this.student, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                child: Hero(
                  tag: 'avatar_${student.id}', // Hero section tag added
                  child: Text(
                    student.name.isNotEmpty
                        ? student.name[0].toUpperCase()
                        : '?',
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.name,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      student.email,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${student.degreeProgram ?? ''}  ${student.specialization ?? ''}',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
              if (student.batchYear != null)
                Chip(
                  label: Text('Batch ${student.batchYear}'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}