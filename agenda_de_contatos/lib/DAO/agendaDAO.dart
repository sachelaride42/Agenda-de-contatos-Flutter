import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AgendaDAO{
  Future<Database> initializeDB() async {
    String path = join(await getDatabasesPath(), 'meu_banco.db');
    return await openDatabase(path, onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE usuarios(id INTEGER PRIMARY KEY, nome TEXT, idade INTEGER)",
      );
    }, version: 1);
  }

}