import 'package:sqflite/sqflite.dart';

///
/// This class represents a command sqlite
/// We will have a command  for each alter of our sqlite.
/// For example if we need to have a column to a table, we'll have
/// Command with "ALTER TABLE ADD COLUMNM etc etc"
///
abstract class CommandScript{

  Future<void> execute(Batch batch);

}