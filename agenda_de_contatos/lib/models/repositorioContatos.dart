import 'package:agenda_de_contatos/models/contato.dart';

class RepositorioContatos {
  List<Contato> listaDeContatos = [];

  void addContato(Contato c) {
    listaDeContatos.add(c);
  }

  List<Contato> getListaDeContatos() {
    return listaDeContatos;
  }
}
