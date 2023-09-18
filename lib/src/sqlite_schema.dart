import 'dart:collection';

import '/src/command_script.dart';
import 'package:sqflite/sqflite.dart';

///
/// This class create the sqlite schema and manage the upgrading.
///
class SQLiteSchema{

  factory SQLiteSchema() {
    return _singleton;
  }
  SQLiteSchema._internal();
  static final SQLiteSchema _singleton = SQLiteSchema._internal();

  /// It contains the command related to each version.
  final Map<int, CommandScript> versionCommands = HashMap();

  /// Sets a command to execute for a version
  void setCommand(int version, CommandScript command){
    //match the version number with a command script.
    versionCommands[version] = command;
  }

  /// Creates the database
  Future<void> create(Database db, int version) async {
    print("Creating database ${db.path} " );
    upgrade(db, 0, version);
  }

  /// Upgrades the database from and old version
  Future<void> upgrade(Database db, int oldVersion, int newVersion ) async{
    print("Upgrading database ${db.path} from $oldVersion to $newVersion" );

    Batch batch = db.batch();

    /// executes the commands to upgrade the database schema
    for( int currentVersion=oldVersion+1; currentVersion<=newVersion; currentVersion++ ){
      CommandScript? command = versionCommands[currentVersion];
      command?.execute(batch);
    }
    await batch.commit();
  }

}