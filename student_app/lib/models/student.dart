class Student {
  final int id;
  final String name;
  final String email;
  final String? degreeProgram;
  final String? specialization;
  final String? university;
  final String? registrationNumber;
  final int? batchYear;
  final DateTime createdAt;

  Student({
    required this.id,
    required this.name,
    required this.email,
    this.degreeProgram,
    this.specialization,
    this.university,
    this.registrationNumber,
    this.batchYear,
    required this.createdAt,
  });

  //JSON serialization
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      degreeProgram: json['degreeProgram'] as String?,
      specialization: json['specialization'] as String?,
      university: json['university'] as String?,
      registrationNumber: json['registrationNumber'] as String?,
      batchYear: json['batchYear'] as int?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  // Map<String, dynamic> toJson() => {
  //       'id': id,
  //       'name': name,
  //       'email': email,
  //       'degreeProgram': degreeProgram,
  //       'specialization': specialization,
  //       'university': university,
  //       'registrationNumber': registrationNumber,
  //       'batchYear': batchYear,
  //       'createdAt': createdAt.toIso8601String(),
  //     };
}
