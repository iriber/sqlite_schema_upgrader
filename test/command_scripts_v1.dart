import 'package:sqflite/sqflite.dart';
import 'package:sqlite_schema_upgrader/sqlite_schema_upgrader.dart';

///
/// Command to create the first version of the database.
///
class CommandScriptV1 extends CommandScript {
  @override
  Future<void> execute(Batch batch) async {
    batch.execute(
        "CREATE TABLE log_data (id INTEGER PRIMARY KEY AUTOINCREMENT, message TEXT NOT NULL, datetime INTEGER)");
  }
}
