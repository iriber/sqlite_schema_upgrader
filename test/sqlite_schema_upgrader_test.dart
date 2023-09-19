import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqlite_schema_upgrader/sqlite_schema_upgrader.dart';
import 'package:test/test.dart';

import 'command_scripts_v1.dart';
import 'command_scripts_v2.dart';

void main() {
  group('A group of tests', () {
    SQLiteSchema sqliteSchema = SQLiteSchema();
    Database db;
    setUp(() async {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    });

    test('Create v1', () async {
      print("create v1");
      db = await openDatabase('myapp_database.db', version: 1);
      sqliteSchema.setCommand(1, CommandScriptV1());
      sqliteSchema.create(db, 1);
      expect(true, isTrue);
    });

    test('Create v2', () async {
      db = await openDatabase('myapp_database.db', version: 2);
      sqliteSchema.setCommand(1, CommandScriptV1());
      sqliteSchema.setCommand(2, CommandScriptV2());
      sqliteSchema.create(db, 2);

      expect(true, isTrue);
    });
  });
}
