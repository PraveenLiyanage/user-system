// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../models/student.dart';

// class ApiService {
//   // Flutter web and API run on same machien.
//   static const String baseUrl = 'http://localhost:5206/api/user';

//   // For Android Emulator use:
//   // static const String baseUrl = 'http://10.0.2.2:5206/api/user';

//   Future<List<Student>> getStudent() async {
//     final response = await http.get(Uri.parse(baseUrl));
//     if (response.statusCode == 200) {
//       final List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;
//       return jsonList
//           .map((json) => Student.fromJson(json as Map<String, dynamic>))
//           .toList();
//     }
//     else {
//       throw Exception('Failed to load students. Status code: ${response.statusCode}');
//     }
//   }

//   Future<Student> createStudent({
//     required String name,
//     required String email,
//     String? degreeProgram,
//     String? specialization,
//     String? university,
//     String? registrationNumber,
//     int? batchYear,
//   }) async {
//     final body = jsonEncode({
//       'name': name,
//       'email': email,
//       'degreeProgram': degreeProgram,
//       'specialization': specialization,
//       'university': university,
//       'registrationNumber': registrationNumber,
//       'batchYear': batchYear,
//     });

//     final response = await http.post(
//       Uri.parse(baseUrl),
//       headers: {'Content-Type': 'application/json'},
//       body: body,
//     );

//     if (response.statusCode == 201) {
//       final Map<String, dynamic> json = jsonDecode(response.body) as Map<String, dynamic>;
//       return Student.fromJson(json);
//     } else {
//       throw Exception('Failed to create student. Status code: ${response.statusCode}');
//     }
//   }

//   Future<void> updateStudent(Student student) async {
//     final url ='$baseUrl/${student.id}';
//     final body = jsonEncode({
//       'id': student.id,
//       'name': student.name,
//       'email': student.email,
//       'degreeProgram': student.degreeProgram,
//       'specialization': student.specialization,
//       'university': student.university,
//       'registrationNumber': student.registrationNumber,
//       'batchYear': student.batchYear,
//     });

//     final response = await http.put(
//       Uri.parse(url),
//       headers: {'Content-Type': 'application/json'},
//       body: body,
//     );

//     if (response.statusCode != 204) {
//       throw Exception('Failed to update student. Status code: ${response.statusCode}');
//     }
//   }

//   Future<void> deleteStudent(int id) async {
//     final url = '$baseUrl/$id';

//     final response = await http.delete(Uri.parse(url));

//     if (response.statusCode != 204) {
//       throw Exception('Failed to delete student. Status code: ${response.statusCode}');
//     }
//   }
// }






// import 'dart:convert';
// import 'package:drift/drift.dart' show Value;
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:student_app/main.dart';
// import '../local/app_db.dart';
// import '../models/student.dart' as model;

// class ApiService {
//   static const String baseUrl = 'http://localhost:5206/api/user';

//   final AppDatabase _db = db;

//   // Convert API model -> Drift companion
//   StudentsCompanion _toDriftCompanion(model.Student s) {
//     return StudentsCompanion(
//       id: Value(s.id),
//       name: Value(s.name),
//       email: Value(s.email),
//       degreeProgram: Value(s.degreeProgram),
//       specialization: Value(s.specialization),
//       university: Value(s.university),
//       registrationNumber: Value(s.registrationNumber),
//       batchYear: Value(s.batchYear),
//       createdAt: Value(s.createdAt),
//     );
//   }

//   // Convert Drift row -> API model
//   model.Student _fromDriftRow(Student row) {
//     return model.Student(
//       id: row.id,
//       name: row.name,
//       email: row.email,
//       degreeProgram: row.degreeProgram,
//       specialization: row.specialization,
//       university: row.university,
//       registrationNumber: row.registrationNumber,
//       batchYear: row.batchYear,
//       createdAt: row.createdAt,
//     );
//   }

// Future<List<model.Student>> getStudent() async {
//   try {
//     final url = Uri.parse(baseUrl);
//     debugPrint('GET $url');
//     final response = await http.get(url);

//     debugPrint('Response status: ${response.statusCode}');
//     debugPrint('Response body: ${response.body}');

//     if (response.statusCode == 200) {
//       final List<dynamic> jsonList =
//           jsonDecode(response.body) as List<dynamic>;

//       final students = jsonList
//           .map(
//             (json) =>
//                 model.Student.fromJson(json as Map<String, dynamic>),
//           )
//           .toList();

//       final toInsert = students.map(_toDriftCompanion).toList();
//       await _db.clearStudents();
//       await _db.upsertStudents(toInsert);

//       return students;
//     } else {
//       debugPrint(
//         'Server error ${response.statusCode}, falling back to local DB',
//       );
//       return _getStudentsFromLocal();
//     }
//   } catch (e, st) {
//     debugPrint('Error in getStudent: $e');
//     debugPrint('$st');
//     return _getStudentsFromLocal();
//   }
// }

//   Future<List<model.Student>> _getStudentsFromLocal() async {
//     final rows = await _db.getAllStudents();
//     return rows.map(_fromDriftRow).toList();
//   }

//   // Create
//   Future<void> createStudent({
//     required String name,
//     required String email,
//     String? degreeProgram,
//     String? specialization,
//     String? university,
//     String? registrationNumber,
//     int? batchYear,
//   }) async {
//     final body = jsonEncode({
//       'name': name,
//       'email': email,
//       'degreeProgram': degreeProgram,
//       'specialization': specialization,
//       'university': university,
//       'registrationNumber': registrationNumber,
//       'batchYear': batchYear,
//     });

//     final response = await http.post(
//       Uri.parse(baseUrl),
//       headers: {'Content-Type': 'application/json'},
//       body: body,
//     );

//     // your API might return 201 on create; adjust if needed
//     if (response.statusCode != 201 && response.statusCode != 200) {
//       throw Exception(
//         'Failed to create student. Status code: ${response.statusCode}',
//       );
//     }

//     if (response.body.isNotEmpty) {
//       final json = jsonDecode(response.body) as Map<String, dynamic>;
//       final student = model.Student.fromJson(json);
//       await _db.upsertStudent(_toDriftCompanion(student));
//     }
//   }

//   // Update
//   Future<void> updateStudent(model.Student student) async {
//     final url = '$baseUrl/${student.id}';
//     final body = jsonEncode(student.toJson());

//     final response = await http.put(
//       Uri.parse(url),
//       headers: {'Content-Type': 'application/json'},
//       body: body,
//     );

//     if (response.statusCode != 204) {
//       throw Exception(
//         'Failed to update student. Status code: ${response.statusCode}',
//       );
//     }

//     // update local cache as well
//     await _db.upsertStudent(_toDriftCompanion(student));
//   }

//   // Delete
//   Future<void> deleteStudent(int id) async {
//     final url = '$baseUrl/$id';

//     final response = await http.delete(Uri.parse(url));

//     if (response.statusCode != 204) {
//       throw Exception(
//         'Failed to delete student. Status code: ${response.statusCode}',
//       );
//     }

//     await _db.deleteStudentById(id);
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import '../models/student.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:5206/api/user';

  static const String _studentBoxName = 'studentBox';
  static const String _studentCacheKey = 'student_json';

  Future<Box> _openStudentBox() async {
    return await Hive.openBox(_studentBoxName);
  }

  Future<List<Student>> getStudent() async {
    final box = await _openStudentBox();

    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final jsonStr = response.body;

        await box.put(_studentCacheKey, jsonStr);

        final List<dynamic> jsonList = jsonDecode(jsonStr) as List<dynamic>;
        return jsonList
            .map((json) => Student.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        // If server got error fall back to local cache
        final cached = box.get(_studentCacheKey);
        if (cached != null) {
          final List<dynamic> jsonList =
              jsonDecode(cached as String) as List<dynamic>;
          return jsonList
              .map((json) => Student.fromJson(json as Map<String, dynamic>))
              .toList();
        }

        throw Exception(
            'Failed to load students. Status code: ${response.statusCode}');
      }
    } catch (e) {
      final cached = box.get(_studentCacheKey);
      if (cached != null) {
        final List<dynamic> jsonList =
            jsonDecode(cached as String) as List<dynamic>;
        return jsonList
            .map((json) => Student.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      rethrow;
    }
  }

  // Create

  Future<Student> createStudent({
    required String name,
    required String email,
    String? degreeProgram,
    String? specialization,
    String? university,
    String? registrationNumber,
    int? batchYear,
  }) async {
    final body = jsonEncode({
      'name': name,
      'email': email,
      'degreeProgram': degreeProgram,
      'specialization': specialization,
      'university': university,
      'registrationNumber': registrationNumber,
      'batchYear': batchYear,
    });

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'applicstion/json'},
      body: body,
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> json =
          jsonDecode(response.body) as Map<String, dynamic>;
      return Student.fromJson(json);
    } else {
      throw Exception(
          'Failed to create student. status code ${response.statusCode}');
    }
  }

  // Update
  Future<void> updateStudent(Student student) async {
    final url = '$baseUrl/${student.id}';
    final body = jsonEncode({
      'id': student.id,
      'name': student.name,
      'email': student.email,
      'degreeProgram': student.degreeProgram,
      'specialization': student.specialization,
      'university': student.university,
      'registrationNumber': student.registrationNumber,
      'batchYear': student.batchYear,
    });

    final response = await http.put(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode != 204) {
      throw Exception(
          'Failed to Update Student. Status Code ${response.statusCode}');
    }
  }

  // Delete
  Future<void> deleteStudent(int id) async {
      final url = '$baseUrl/$id';

      final response = await http.delete(Uri.parse(url));

      if (response.statusCode != 204) {
        throw Exception('Failed to delete student. Status code: ${response.statusCode}');
      }
    }
  }



// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:hive/hive.dart';
// import 'package:flutter/material.dart';
// import '../models/student.dart';

// import '../db/connection/shared.dart';
// import '../local/app_db.dart';

// class ApiService {
//   static const String baseUrl = 'http://localhost:5206/api/user';

//   static const String _studentBoxName = 'studentBox';
//   static const String _studentCacheKey = 'student_json';

//   Future<Box> _openStudentBox() async {
//     return await Hive.openBox(_studentBoxName);
//   }

//   Future<List<Student>> getStudent() async {
//     final box = await _openStudentBox();

//     try {
//       final response = await http.get(Uri.parse(baseUrl));

//       if (response.statusCode == 200) {
//         final jsonStr = response.body;

//         await box.put(_studentCacheKey, jsonStr);

//         final List<dynamic> jsonList = jsonDecode(jsonStr) as List<dynamic>;
//         return jsonList
//             .map((json) => Student.fromJson(json as Map<String, dynamic>))
//             .toList();
//       } else {
//         // If server got error fall back to local cache
//         final cached = box.get(_studentCacheKey);
//         if (cached != null) {
//           final List<dynamic> jsonList =
//               jsonDecode(cached as String) as List<dynamic>;
//           return jsonList
//               .map((json) => Student.fromJson(json as Map<String, dynamic>))
//               .toList();
//         }

//         throw Exception(
//             'Failed to load students. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       final cached = box.get(_studentCacheKey);
//       if (cached != null) {
//         final List<dynamic> jsonList =
//             jsonDecode(cached as String) as List<dynamic>;
//         return jsonList
//             .map((json) => Student.fromJson(json as Map<String, dynamic>))
//             .toList();
//       }
//       rethrow;
//     }
//   }

//   // Create

//   Future<Student> createStudent({
//     required String name,
//     required String email,
//     String? degreeProgram,
//     String? specialization,
//     String? university,
//     String? registrationNumber,
//     int? batchYear,
//   }) async {
//     final body = jsonEncode({
//       'name': name,
//       'email': email,
//       'degreeProgram': degreeProgram,
//       'specialization': specialization,
//       'university': university,
//       'registrationNumber': registrationNumber,
//       'batchYear': batchYear,
//     });

//     final response = await http.post(
//       Uri.parse(baseUrl),
//       headers: {'Content-Type': 'applicstion/json'},
//       body: body,
//     );

//     if (response.statusCode == 201) {
//       final Map<String, dynamic> json =
//           jsonDecode(response.body) as Map<String, dynamic>;
//       return Student.fromJson(json);
//     } else {
//       throw Exception(
//           'Failed to create student. status code ${response.statusCode}');
//     }
//   }

//   // Update
//   Future<void> updateStudent(Student student) async {
//     final url = '$baseUrl/${student.id}';
//     final body = jsonEncode({
//       'id': student.id,
//       'name': student.name,
//       'email': student.email,
//       'degreeProgram': student.degreeProgram,
//       'specialization': student.specialization,
//       'university': student.university,
//       'registrationNumber': student.registrationNumber,
//       'batchYear': student.batchYear,
//     });

//     final response = await http.put(
//       Uri.parse(url),
//       headers: {'Content-Type': 'application/json'},
//       body: body,
//     );

//     if (response.statusCode != 204) {
//       throw Exception(
//           'Failed to Update Student. Status Code ${response.statusCode}');
//     }
//   }

//   // Delete
//   Future<void> deleteStudent(int id) async {
//       final url = '$baseUrl/$id';

//       final response = await http.delete(Uri.parse(url));

//       if (response.statusCode != 204) {
//         throw Exception('Failed to delete student. Status code: ${response.statusCode}');
//       }
//     }
//   }
