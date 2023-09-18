import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite_schema_upgrader/sqlite_schema_upgrader.dart';

/// It manages sqlite database connection.
class SQLiteDatabase {

  /// Initializes and returns sqlite database connection.
  Future<Database> initializeDB(int version) async {

    ///gets database location.
    String path = (await getApplicationDocumentsDirectory()).path;

    ///You must indicate what to do onCreate and what onUpdate
    ///and our SQLiteSchema is the one who is in charge of that.
    return openDatabase(
        join(path, 'myapp_database.db'),
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