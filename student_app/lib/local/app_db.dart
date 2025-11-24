// import 'package:drift/drift.dart';
// import 'package:drift/web.dart';
// import 'package:flutter/material.dart';

// part 'app_db.g.dart';

// class Students extends Table {
//   IntColumn get id => integer()();
//   TextColumn get name => text()();
//   TextColumn get email => text()();
//   TextColumn get degreeProgram => text().nullable()();
//   TextColumn get specialization => text().nullable()();
//   TextColumn get university => text().nullable()();
//   TextColumn get registrationNumber => text().nullable()();
//   IntColumn get batchYear => integer().nullable()();
//   DataTimeColumn get createdAt => dateTime()();

//   @override
//   Set<Column> get primaryKry => {id};
// }

// @DriftDatabase(tables: [Students])
// class AppDatabase extends _$AppDatabase {
//   AppDatabase() : super(WebDtabase('studentdb'));
//   IndexedDB name

//   @override
//   int get schemaVersion => 1;
// }


// lib/local/app_db.dart
import 'package:drift/drift.dart';
import 'package:student_app/models/student.dart';

part 'app_db.g.dart';

// Drift table for students
class Students extends Table {
  IntColumn get id => integer()(); // we’ll use server ID, not autoincrement
  TextColumn get name => text()();
  TextColumn get email => text()();

  TextColumn get degreeProgram => text().nullable()();
  TextColumn get specialization => text().nullable()();
  TextColumn get university => text().nullable()();
  TextColumn get registrationNumber => text().nullable()();
  IntColumn get batchYear => integer().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Optional: you can later add more tables, e.g. user_session, settings, etc.
@DriftDatabase(tables: [Students])
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor executor) : super(executor);

  @override
  int get schemaVersion => 1;

  // ---------- Student helpers ----------

  Future<List<Student>> getAllStudents() => select(students).get();

  Stream<List<Student>> watchAllStudents() => select(students).watch();

  Future<void> upsertStudents(List<StudentsCompanion> entries) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(students, entries);
    });
  }

  Future<void> clearStudents() async {
    await delete(students).go();
  }

  Future<void> upsertStudent(StudentsCompanion entry) async {
    await into(students).insertOnConflictUpdate(entry);
  }

  Future<void> deleteStudentById(int id) async {
    await (delete(students)..where((tbl) => tbl.id.equals(id))).go();
  }
}
