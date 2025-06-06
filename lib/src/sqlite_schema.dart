import 'dart:collection';
import 'package:sqflite_common/sqflite.dart';

import 'command_script.dart';

/// This class creates the sqlite schema and manage the upgrading.
class SQLiteSchema {
  SQLiteSchema._internal();
  factory SQLiteSchema() => _singleton;
  static final SQLiteSchema _singleton = SQLiteSchema._internal();

  /// It contains the command related to each version.
  final Map<int, CommandScript> versionCommands = HashMap();

  /// Sets a command to execute for a version
  void setCommand(int version, CommandScript command) {
    //match the version number with a command script.
    versionCommands[version] = command;
  }

  /// Creates the database
  Future<void> create(Database db, int version, {bool verbose = false}) async {
    if (verbose) print("Creating database ${db.path} ");
    upgrade(db, 0, version);
  }

  /// Upgrades the database from and old version
  Future<void> upgrade(Database db, int oldVersion, int newVersion,
      {bool verbose = false}) async {
    if (verbose) {
      print("Upgrading database ${db.path} from $oldVersion to $newVersion");
    }

    Batch batch = db.batch();

    /// executes the commands to upgrade the database schema
    for (int currentVersion = oldVersion + 1;
        currentVersion <= newVersion;
        currentVersion++) {
      CommandScript? command = versionCommands[currentVersion];
      command?.execute(batch);
    }
    await batch.commit();
  }
}
