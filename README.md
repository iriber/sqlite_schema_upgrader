
This package helps your app to upgrade your app database schema in cleaned and incremental way.


## Features

Use SQLiteSchema to bind onCreate and onUpgrade parameters in the openDatabase SQLite method.
SQLiteSchema is in charge of upgrade the database schema up to date.


## Getting started

It packages implements the Command design pattern.

1) SQLiteSchema: the invoker, it knows the commands to execute to upgrade the database schema.
2) CommandScript: the command. Create one concrete command for each new version of your database. If in your next build yo have to change your database schema, create a concrete command with the sql script and add it into the SQLiteSchema.
3) Receiver: Batch. We send the scripts to the Batch to upgrade the database schema.

## Usage

Use SQLiteSchema to bind openDatabase parameters:

```dart
import '/src/config/enviroment.dart';
import '/src/data/sqlite/sqlite_scheme.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// It manages sqlite database connection.
class SQLiteDatabase {

  /// Initializes and returns sqlite database connection.
  Future<Database> initializeDB() async {

    ///gets database location.
    String path = Environment().config.getAppDocumentsPath();

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
        version: Environment().config.appDatabaseVersion
    );
  }

}
```
Then you have to create Commands.
For this example, I created two concrete commands:

* CommanScriptV1: it creates the first version of database schema. It creates the table “LogData”
* CommandScriptV2: it upgrades the database schema, it alters LogData table adding one more column.

```dart
import '/src/data/sqlite/command_script.dart';
import '/src/data/sqlite/sqlite_scheme.dart';

/**
 * Command to create the first version of the database.
 */
class CommandScriptV1 extends CommandScript{

  Future<void> execute(Batch batch) async {
    batch.execute("CREATE TABLE log_data (id INTEGER PRIMARY KEY AUTOINCREMENT,"
        " message TEXT NOT NULL, datetime INTEGER)");
    }

}
```

```dart
import '/src/data/sqlite/command_script.dart';
import '/src/data/sqlite/sqlite_scheme.dart';

/**
 * Command to update datbase schema to v2.
 */
class CommandScriptV2 extends CommandScript{

  Future<void> execute(Batch batch) async {
    batch.execute("ALTER TABLE log_data ADD level INTEGER");
  }
}
```

Then assign those commands to sqliteSchema indicating the version

```dart
SQLiteSchema sqliteSchema = SQLiteSchema();
sqliteSchema.setCommand(1, CommandScriptV1());
sqliteSchema.setCommand(2, CommandScriptV2());
```
