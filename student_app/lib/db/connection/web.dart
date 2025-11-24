import 'package:drift/web.dart';
import '../../local/app_db.dart';

AppDatabase constructDb() {
  final executor = WebDatabase('student_db');
  return AppDatabase(executor);
}
