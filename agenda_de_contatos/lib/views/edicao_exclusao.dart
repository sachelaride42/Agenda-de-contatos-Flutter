import 'package:agenda_de_contatos/models/contato.dart';
import 'package:agenda_de_contatos/models/repositorioContatos.dart';
import 'package:flutter/material.dart';

class EdicaoExclusao extends StatefulWidget {
  final Contato contato;
  final RepositorioContatos repo;
  final int indice;

  EdicaoExclusao(
      {required this.contato, required this.repo, required this.indice});

  @override
  State<StatefulWidget> createState() {
    return EdicaoExclusaoState();
  }
}

class EdicaoExclusaoState extends State<EdicaoExclusao> {
  late TextEditingController controleNome;
  late TextEditingController controleTelefone;
  late TextEditingController controleEmail;

  @override
  void initState() {
    super.initState();
    controleNome = TextEditingController(text: widget.contato.getNome());
    controleTelefone =
        TextEditingController(text: widget.contato.getTelefone());
    controleEmail = TextEditingController(text: widget.contato.getEmail());
  }

  @override
  void dispose() {
    controleNome.dispose();
    controleTelefone.dispose();
    controleEmail.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edição e exclusão"),
      ),
      body: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        TextField(
          controller: controleNome,
        ),
        TextField(controller: controleTelefone),
        TextField(controller: controleEmail),
        TextButton(
            onPressed: () {
              widget.repo.getElemento(widget.indice).setNome(controleNome.text);
              widget.repo
                  .getElemento(widget.indice)
                  .setTelefone(controleTelefone.text);
              widget.repo
                  .getElemento(widget.indice)
                  .setEmail(controleEmail.text);
              Navigator.pop(context, true);
            },
            child: Text("Salvar edição")),
        TextButton(
            onPressed: () {
              widget.repo.deleteContato(widget.indice);
              Navigator.pop(context, true);
            },
            child: Text("Excluir"))
      ])),
    );
  }
}
