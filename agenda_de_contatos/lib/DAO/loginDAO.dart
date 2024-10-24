import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/login.dart';

class LoginDAO{
  Future<Database> initializeDB() async {
    try{
      String path = join(await getDatabasesPath(), 'meu_banco.db');
      return await openDatabase(path, onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE contatos(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, telefone TEXT, email TEXT)",
        );
        await db.execute("CREATE TABLE login(id INTEGER PRIMARY KEY AUTOINCREMENT, usuario TEXT, senha TEXT)");
      }/*onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute("CREATE TABLE login(id INTEGER PRIMARY KEY AUTOINCREMENT, usuario TEXT, senha TEXT)");
      }*/, version: 1);
    }
    catch(e){
      print("Erro ao inicializar o banco de dados: $e");
      rethrow;
    }
  }

  Future<void> cadastrarLogin(Login login) async {
    final Database db = await initializeDB();
    int id = await db.insert('login', login.toMap());
    login.setId(id);
  }

  Future<bool> temLogin(String usuario, String senha) async{
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> maps = await db.query('login', where: 'usuario = ? AND senha = ?', whereArgs: [usuario, senha]);
    return maps.isNotEmpty;
  }
}