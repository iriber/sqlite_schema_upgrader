import 'package:sqflite/sqflite.dart';

/// This class represents a command sqlite.
abstract class CommandScript {
  /// Executes the command over the batch.
  Future<void> execute(Batch batch);
}
