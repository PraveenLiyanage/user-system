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
