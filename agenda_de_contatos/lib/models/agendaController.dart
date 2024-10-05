import 'package:agenda_de_contatos/DAO/agendaDAO.dart';
import 'package:agenda_de_contatos/models/contato.dart';

class AgendaController {
  AgendaDAO agendaDAO = AgendaDAO();

  Future<void> addContato(Contato c) async {
    await agendaDAO.inserirContato(c);
  }

  Future<List<Contato>> getListaContatos() async {
    return await agendaDAO.obterListaContatos();
  }

  Future <void> atualizarContato (Contato contato) async {
    await agendaDAO.atualizarContato(contato);
  }

  Future<void> deleteContato(Contato contato) async {
    await agendaDAO.excluirContato(contato);
  }
}
