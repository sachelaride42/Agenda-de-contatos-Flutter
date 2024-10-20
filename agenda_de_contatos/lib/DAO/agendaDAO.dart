import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/contato.dart';

class AgendaDAO{
  Future<Database> initializeDB() async {
    try{
      String path = join(await getDatabasesPath(), 'meu_banco.db');
      return await openDatabase(path, onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE contatos(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, telefone TEXT, email TEXT)",
        );
      }, version: 1);
    }
    catch(e){
      print("Erro ao inicializar o banco de dados: $e");
      rethrow;
    }

  }

  Future<void> inserirContato(Contato contato) async {
    final Database db = await initializeDB();
    int id = await db.insert('contatos', contato.toMap());
    contato.setId(id);
  }

  Future<List<Contato>> obterListaContatos() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> maps = await db.query('contatos');
    return List.generate(maps.length, (i) {
      return Contato.fromMap(maps[i]);
    });
  }

  Future<void> atualizarContato(Contato contato) async{
    final Database db = await initializeDB();
    await db.update('contatos', contato.toMap(), where: 'id = ?', whereArgs: [contato.id]);
  }

  Future<void> excluirContato(Contato contato) async{
    final Database db = await initializeDB();
    await db.delete('contatos', where: 'id = ?', whereArgs: [contato.id]);
  }

}