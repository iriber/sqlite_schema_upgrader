import 'package:sqflite/sqflite.dart';
import 'package:sqlite_schema_upgrader/sqlite_schema_upgrader.dart';

///
/// Command to update datbase schema to v2.
///
class CommandScriptV2 extends CommandScript {
  @override
  Future<void> execute(Batch batch) async {
    batch.execute("ALTER TABLE log_data ADD level INTEGER");

    batch.execute(
        "INSERT INTO log_data(message,level) VALUES ('my first message',1)");
  }
}
