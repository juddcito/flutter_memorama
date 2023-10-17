import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {

  Database? _database;

  Future<Database> initializeDatabase() async {
    final String path = join(await getDatabasesPath(), 'memorama.db');
    final Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE scores(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, nivel INTEGER, score TEXT)',
        );
      },
    );
    _database = database;
    return database;
  }

  Future<int> insertScore(int nivel, String score) async {
    final db = _database;
    return await db!.rawInsert('INSERT INTO scores (nivel, score) VALUES (?,?)', [nivel, score]);
  }
  
  Future<Map<String, dynamic>> getMinScoreAndTime(int nivel) async {

    final db = _database;

    final result = await db!.rawQuery(
        'SELECT MIN(score) AS min_score FROM scores where nivel = ?', [nivel]
    );

    return result.isNotEmpty ? result.first : {'min_score': "No hay scores"};
  }


}