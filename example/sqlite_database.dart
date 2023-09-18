import 'package:sqflite/sqflite.dart';
import 'package:sqlite_schema_upgrader/sqlite_schema_upgrader.dart';

/// It manages sqlite database connection.
class SQLiteDatabase {

  /// Initializes and returns sqlite database connection.
  Future<Database> initializeDB(int version) async {

    ///You must indicate what to do onCreate and what onUpdate
    ///and our SQLiteSchema is the one who is in charge of that.
    return openDatabase(
        'myapp_database.db',
        onCreate: (database, version) async {
          SQLiteSchema().create(database, version);
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          SQLiteSchema().upgrade(db, oldVersion, newVersion);
        },
        version: version
    );
  }

}