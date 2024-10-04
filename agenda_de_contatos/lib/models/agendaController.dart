import 'package:agenda_de_contatos/models/contato.dart';

class AgendaController {
  List<Contato> listaDeContatos = [];

  void addContato(Contato c) {
    listaDeContatos.add(c);
  }

  List<Contato> getListaDeContatos() {
    return listaDeContatos;
  }

  Contato getElemento(int index) {
    Contato contato = listaDeContatos.elementAt(index);
    return contato;
  }

  void deleteContato(int index) {
    listaDeContatos.removeAt(index);
  }
}
