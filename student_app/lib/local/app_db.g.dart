// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// ignore_for_file: type=lint
class $StudentsTable extends Students with TableInfo<$StudentsTable, Student> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _degreeProgramMeta =
      const VerificationMeta('degreeProgram');
  @override
  late final GeneratedColumn<String> degreeProgram = GeneratedColumn<String>(
      'degree_program', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _specializationMeta =
      const VerificationMeta('specialization');
  @override
  late final GeneratedColumn<String> specialization = GeneratedColumn<String>(
      'specialization', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _universityMeta =
      const VerificationMeta('university');
  @override
  late final GeneratedColumn<String> university = GeneratedColumn<String>(
      'university', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _registrationNumberMeta =
      const VerificationMeta('registrationNumber');
  @override
  late final GeneratedColumn<String> registrationNumber =
      GeneratedColumn<String>('registration_number', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _batchYearMeta =
      const VerificationMeta('batchYear');
  @override
  late final GeneratedColumn<int> batchYear = GeneratedColumn<int>(
      'batch_year', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        email,
        degreeProgram,
        specialization,
        university,
        registrationNumber,
        batchYear,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'students';
  @override
  VerificationContext validateIntegrity(Insertable<Student> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('degree_program')) {
      context.handle(
          _degreeProgramMeta,
          degreeProgram.isAcceptableOrUnknown(
              data['degree_program']!, _degreeProgramMeta));
    }
    if (data.containsKey('specialization')) {
      context.handle(
          _specializationMeta,
          specialization.isAcceptableOrUnknown(
              data['specialization']!, _specializationMeta));
    }
    if (data.containsKey('university')) {
      context.handle(
          _universityMeta,
          university.isAcceptableOrUnknown(
              data['university']!, _universityMeta));
    }
    if (data.containsKey('registration_number')) {
      context.handle(
          _registrationNumberMeta,
          registrationNumber.isAcceptableOrUnknown(
              data['registration_number']!, _registrationNumberMeta));
    }
    if (data.containsKey('batch_year')) {
      context.handle(_batchYearMeta,
          batchYear.isAcceptableOrUnknown(data['batch_year']!, _batchYearMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Student map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Student(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      degreeProgram: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}degree_program']),
      specialization: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}specialization']),
      university: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}university']),
      registrationNumber: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}registration_number']),
      batchYear: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}batch_year']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $StudentsTable createAlias(String alias) {
    return $StudentsTable(attachedDatabase, alias);
  }
}

class Student extends DataClass implements Insertable<Student> {
  final int id;
  final String name;
  final String email;
  final String? degreeProgram;
  final String? specialization;
  final String? university;
  final String? registrationNumber;
  final int? batchYear;
  final DateTime createdAt;
  const Student(
      {required this.id,
      required this.name,
      required this.email,
      this.degreeProgram,
      this.specialization,
      this.university,
      this.registrationNumber,
      this.batchYear,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['email'] = Variable<String>(email);
    if (!nullToAbsent || degreeProgram != null) {
      map['degree_program'] = Variable<String>(degreeProgram);
    }
    if (!nullToAbsent || specialization != null) {
      map['specialization'] = Variable<String>(specialization);
    }
    if (!nullToAbsent || university != null) {
      map['university'] = Variable<String>(university);
    }
    if (!nullToAbsent || registrationNumber != null) {
      map['registration_number'] = Variable<String>(registrationNumber);
    }
    if (!nullToAbsent || batchYear != null) {
      map['batch_year'] = Variable<int>(batchYear);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  StudentsCompanion toCompanion(bool nullToAbsent) {
    return StudentsCompanion(
      id: Value(id),
      name: Value(name),
      email: Value(email),
      degreeProgram: degreeProgram == null && nullToAbsent
          ? const Value.absent()
          : Value(degreeProgram),
      specialization: specialization == null && nullToAbsent
          ? const Value.absent()
          : Value(specialization),
      university: university == null && nullToAbsent
          ? const Value.absent()
          : Value(university),
      registrationNumber: registrationNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(registrationNumber),
      batchYear: batchYear == null && nullToAbsent
          ? const Value.absent()
          : Value(batchYear),
      createdAt: Value(createdAt),
    );
  }

  factory Student.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Student(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      degreeProgram: serializer.fromJson<String?>(json['degreeProgram']),
      specialization: serializer.fromJson<String?>(json['specialization']),
      university: serializer.fromJson<String?>(json['university']),
      registrationNumber:
          serializer.fromJson<String?>(json['registrationNumber']),
      batchYear: serializer.fromJson<int?>(json['batchYear']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'degreeProgram': serializer.toJson<String?>(degreeProgram),
      'specialization': serializer.toJson<String?>(specialization),
      'university': serializer.toJson<String?>(university),
      'registrationNumber': serializer.toJson<String?>(registrationNumber),
      'batchYear': serializer.toJson<int?>(batchYear),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Student copyWith(
          {int? id,
          String? name,
          String? email,
          Value<String?> degreeProgram = const Value.absent(),
          Value<String?> specialization = const Value.absent(),
          Value<String?> university = const Value.absent(),
          Value<String?> registrationNumber = const Value.absent(),
          Value<int?> batchYear = const Value.absent(),
          DateTime? createdAt}) =>
      Student(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        degreeProgram:
            degreeProgram.present ? degreeProgram.value : this.degreeProgram,
        specialization:
            specialization.present ? specialization.value : this.specialization,
        university: university.present ? university.value : this.university,
        registrationNumber: registrationNumber.present
            ? registrationNumber.value
            : this.registrationNumber,
        batchYear: batchYear.present ? batchYear.value : this.batchYear,
        createdAt: createdAt ?? this.createdAt,
      );
  Student copyWithCompanion(StudentsCompanion data) {
    return Student(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      degreeProgram: data.degreeProgram.present
          ? data.degreeProgram.value
          : this.degreeProgram,
      specialization: data.specialization.present
          ? data.specialization.value
          : this.specialization,
      university:
          data.university.present ? data.university.value : this.university,
      registrationNumber: data.registrationNumber.present
          ? data.registrationNumber.value
          : this.registrationNumber,
      batchYear: data.batchYear.present ? data.batchYear.value : this.batchYear,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Student(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('degreeProgram: $degreeProgram, ')
          ..write('specialization: $specialization, ')
          ..write('university: $university, ')
          ..write('registrationNumber: $registrationNumber, ')
          ..write('batchYear: $batchYear, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, email, degreeProgram,
      specialization, university, registrationNumber, batchYear, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Student &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.degreeProgram == this.degreeProgram &&
          other.specialization == this.specialization &&
          other.university == this.university &&
          other.registrationNumber == this.registrationNumber &&
          other.batchYear == this.batchYear &&
          other.createdAt == this.createdAt);
}

class StudentsCompanion extends UpdateCompanion<Student> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> email;
  final Value<String?> degreeProgram;
  final Value<String?> specialization;
  final Value<String?> university;
  final Value<String?> registrationNumber;
  final Value<int?> batchYear;
  final Value<DateTime> createdAt;
  const StudentsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.degreeProgram = const Value.absent(),
    this.specialization = const Value.absent(),
    this.university = const Value.absent(),
    this.registrationNumber = const Value.absent(),
    this.batchYear = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  StudentsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String email,
    this.degreeProgram = const Value.absent(),
    this.specialization = const Value.absent(),
    this.university = const Value.absent(),
    this.registrationNumber = const Value.absent(),
    this.batchYear = const Value.absent(),
    required DateTime createdAt,
  })  : name = Value(name),
        email = Value(email),
        createdAt = Value(createdAt);
  static Insertable<Student> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? degreeProgram,
    Expression<String>? specialization,
    Expression<String>? university,
    Expression<String>? registrationNumber,
    Expression<int>? batchYear,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (degreeProgram != null) 'degree_program': degreeProgram,
      if (specialization != null) 'specialization': specialization,
      if (university != null) 'university': university,
      if (registrationNumber != null) 'registration_number': registrationNumber,
      if (batchYear != null) 'batch_year': batchYear,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  StudentsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? email,
      Value<String?>? degreeProgram,
      Value<String?>? specialization,
      Value<String?>? university,
      Value<String?>? registrationNumber,
      Value<int?>? batchYear,
      Value<DateTime>? createdAt}) {
    return StudentsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      degreeProgram: degreeProgram ?? this.degreeProgram,
      specialization: specialization ?? this.specialization,
      university: university ?? this.university,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      batchYear: batchYear ?? this.batchYear,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (degreeProgram.present) {
      map['degree_program'] = Variable<String>(degreeProgram.value);
    }
    if (specialization.present) {
      map['specialization'] = Variable<String>(specialization.value);
    }
    if (university.present) {
      map['university'] = Variable<String>(university.value);
    }
    if (registrationNumber.present) {
      map['registration_number'] = Variable<String>(registrationNumber.value);
    }
    if (batchYear.present) {
      map['batch_year'] = Variable<int>(batchYear.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('degreeProgram: $degreeProgram, ')
          ..write('specialization: $specialization, ')
          ..write('university: $university, ')
          ..write('registrationNumber: $registrationNumber, ')
          ..write('batchYear: $batchYear, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $StudentsTable students = $StudentsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [students];
}

typedef $$StudentsTableCreateCompanionBuilder = StudentsCompanion Function({
  Value<int> id,
  required String name,
  required String email,
  Value<String?> degreeProgram,
  Value<String?> specialization,
  Value<String?> university,
  Value<String?> registrationNumber,
  Value<int?> batchYear,
  required DateTime createdAt,
});
typedef $$StudentsTableUpdateCompanionBuilder = StudentsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> email,
  Value<String?> degreeProgram,
  Value<String?> specialization,
  Value<String?> university,
  Value<String?> registrationNumber,
  Value<int?> batchYear,
  Value<DateTime> createdAt,
});

class $$StudentsTableFilterComposer
    extends Composer<_$AppDatabase, $StudentsTable> {
  $$StudentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get degreeProgram => $composableBuilder(
      column: $table.degreeProgram, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get specialization => $composableBuilder(
      column: $table.specialization,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get university => $composableBuilder(
      column: $table.university, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get registrationNumber => $composableBuilder(
      column: $table.registrationNumber,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get batchYear => $composableBuilder(
      column: $table.batchYear, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$StudentsTableOrderingComposer
    extends Composer<_$AppDatabase, $StudentsTable> {
  $$StudentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get degreeProgram => $composableBuilder(
      column: $table.degreeProgram,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get specialization => $composableBuilder(
      column: $table.specialization,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get university => $composableBuilder(
      column: $table.university, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get registrationNumber => $composableBuilder(
      column: $table.registrationNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get batchYear => $composableBuilder(
      column: $table.batchYear, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$StudentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudentsTable> {
  $$StudentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get degreeProgram => $composableBuilder(
      column: $table.degreeProgram, builder: (column) => column);

  GeneratedColumn<String> get specialization => $composableBuilder(
      column: $table.specialization, builder: (column) => column);

  GeneratedColumn<String> get university => $composableBuilder(
      column: $table.university, builder: (column) => column);

  GeneratedColumn<String> get registrationNumber => $composableBuilder(
      column: $table.registrationNumber, builder: (column) => column);

  GeneratedColumn<int> get batchYear =>
      $composableBuilder(column: $table.batchYear, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$StudentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $StudentsTable,
    Student,
    $$StudentsTableFilterComposer,
    $$StudentsTableOrderingComposer,
    $$StudentsTableAnnotationComposer,
    $$StudentsTableCreateCompanionBuilder,
    $$StudentsTableUpdateCompanionBuilder,
    (Student, BaseReferences<_$AppDatabase, $StudentsTable, Student>),
    Student,
    PrefetchHooks Function()> {
  $$StudentsTableTableManager(_$AppDatabase db, $StudentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String?> degreeProgram = const Value.absent(),
            Value<String?> specialization = const Value.absent(),
            Value<String?> university = const Value.absent(),
            Value<String?> registrationNumber = const Value.absent(),
            Value<int?> batchYear = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              StudentsCompanion(
            id: id,
            name: name,
            email: email,
            degreeProgram: degreeProgram,
            specialization: specialization,
            university: university,
            registrationNumber: registrationNumber,
            batchYear: batchYear,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String email,
            Value<String?> degreeProgram = const Value.absent(),
            Value<String?> specialization = const Value.absent(),
            Value<String?> university = const Value.absent(),
            Value<String?> registrationNumber = const Value.absent(),
            Value<int?> batchYear = const Value.absent(),
            required DateTime createdAt,
          }) =>
              StudentsCompanion.insert(
            id: id,
            name: name,
            email: email,
            degreeProgram: degreeProgram,
            specialization: specialization,
            university: university,
            registrationNumber: registrationNumber,
            batchYear: batchYear,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$StudentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $StudentsTable,
    Student,
    $$StudentsTableFilterComposer,
    $$StudentsTableOrderingComposer,
    $$StudentsTableAnnotationComposer,
    $$StudentsTableCreateCompanionBuilder,
    $$StudentsTableUpdateCompanionBuilder,
    (Student, BaseReferences<_$AppDatabase, $StudentsTable, Student>),
    Student,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$StudentsTableTableManager get students =>
      $$StudentsTableTableManager(_db, _db.students);
}
