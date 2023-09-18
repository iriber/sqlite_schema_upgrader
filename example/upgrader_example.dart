import 'package:sqlite_schema_upgrader/sqlite_schema_upgrader.dart';
import 'package:sqflite/sqflite.dart';

import 'command_scripts_v1.dart';
import 'command_scripts_v2.dart';
import 'sqlite_database.dart';

void main() async{

  ///sqlite schema with 2 command scripts
  var sqliteSchema = SQLiteSchema();
  sqliteSchema.setCommand(1, CommandScriptV1());
  sqliteSchema.setCommand(2, CommandScriptV2());

  //initialize and get the connection.
  Database database = await SQLiteDatabase().initializeDB(2);

  final List<Map<String, Object?>> queryResult =
  await database.query("select * from log_data");
  Map<String, dynamic> logItem = queryResult.first;
  print(logItem["message"]);

}
