import 'package:agenda_de_contatos/models/contato.dart';
import 'package:agenda_de_contatos/models/agendaController.dart';
import 'package:agenda_de_contatos/views/cadastro.dart';
import 'package:flutter/material.dart';

class EdicaoExclusao extends StatefulWidget {
  final Contato contato;
  final AgendaController aController;

  const EdicaoExclusao(
      {super.key, required this.contato, required this.aController});

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
        title: const Text("Edição e exclusão"),
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
            onPressed: () async {
              if (validaContato(context, controleNome, controleTelefone, controleEmail)) {
                widget.contato.setNome(controleNome.text);
                widget.contato.setTelefone(controleTelefone.text);
                widget.contato.setEmail(controleNome.text);

                await widget.aController.atualizarContato(widget.contato);
                Navigator.pop(context, true);
              }
            },
            child: const Text("Salvar edição")),
        TextButton(
            onPressed: () async {
              if (validaContato(context, controleNome, controleTelefone, controleEmail)) {
                await widget.aController.deleteContato(widget.contato);
                Navigator.pop(context, true);
              }
            },
            child: const Text("Excluir"))
      ])),
    );
  }
}
