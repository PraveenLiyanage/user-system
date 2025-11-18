import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/student.dart';

class ApiService {
  // Flutter web and API run on same machien.
  static const String baseUrl = 'http://localhost:5206/api/user'; 

  // For Android Emulator use:
  // static const String baseUrl = 'http://10.0.2.2:5206/api/user';

  Future<List<Student>> getStudent() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;
      return jsonList
          .map((json) => Student.fromJson(json as Map<String, dynamic>))
          .toList();
    }
    else {
      throw Exception('Failed to load students. Status code: ${response.statusCode}');
    }
  }

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
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> json = jsonDecode(response.body) as Map<String, dynamic>;
      return Student.fromJson(json);
    } else {
      throw Exception('Failed to create student. Status code: ${response.statusCode}');
    }
  }

  Future<void> updateStudent(Student student) async {
    final url ='$baseUrl/${student.id}';
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
      throw Exception('Failed to update student. Status code: ${response.statusCode}');
    }
  }

  Future<void> deleteStudent(int id) async {
    final url = '$baseUrl/$id';

    final response = await http.delete(Uri.parse(url));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete student. Status code: ${response.statusCode}');
    }
  }
}