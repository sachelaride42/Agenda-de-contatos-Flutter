import 'package:agenda_de_contatos/models/contato.dart';
import 'package:agenda_de_contatos/models/repositorioContatos.dart';
import 'package:agenda_de_contatos/views/cadastro.dart';
import 'package:flutter/material.dart';

class Listagem extends StatefulWidget {
  const Listagem({super.key});

  @override
  State<StatefulWidget> createState() {
    return Listagem_State();
  }
}

class Listagem_State extends State<Listagem> {
  final RepositorioContatos rc = RepositorioContatos();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Lista de Contatos")),
        body: Center(
          child: Column(children: [
            Expanded(
                child: ListView.builder(
                    itemCount: rc.getListaDeContatos().length,
                    itemBuilder: (context, index) {
                      Contato c = rc.getListaDeContatos()[index];
                      return ListTile(
                          title: Text(c.getNome()),
                          subtitle: Text(
                              'Tel: ${c.getTelefone()}; Email: ${c.getEmail()}'));
                    })),
            TextButton(
              onPressed: () async {
                final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Cadastro(
                              rC: rc,
                            )));
                if (result == true) {
                  setState(() {});
                }
              },
              child: Text("Cadastrar / Editar"),
            ),
          ], crossAxisAlignment: CrossAxisAlignment.center),
        ));
  }
}
