import 'package:agenda_de_contatos/models/contato.dart';
import 'package:agenda_de_contatos/models/repositorioContatos.dart';
import 'package:flutter/material.dart';

class Cadastro extends StatefulWidget {
  final RepositorioContatos rC;

  Cadastro({required this.rC});

  @override
  State<StatefulWidget> createState() {
    return CadastroState(repositorio: rC);
  }
}

class CadastroState extends State<Cadastro> {
  RepositorioContatos repositorio;

  CadastroState({required this.repositorio});

  TextEditingController controleNome = TextEditingController();
  TextEditingController controleTelefone = TextEditingController();
  TextEditingController controleEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro e edição de Contatos"),
      ),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: repositorio.getListaDeContatos().length,
                  itemBuilder: (context, index) {
                    Contato c = repositorio.getListaDeContatos()[index];
                    return ListTile(
                        title: Text(c.getNome()),
                        subtitle: Text(
                            'Tel: ${c.getTelefone()}; Email: ${c.getEmail()}'));
                  })),
          TextField(
            controller: controleNome,
            decoration: InputDecoration(hintText: "Nome"),
          ),
          TextField(
            controller: controleTelefone,
            decoration: InputDecoration(hintText: "Telefone"),
          ),
          TextField(
            controller: controleEmail,
            decoration: InputDecoration(hintText: "Email"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                Contato contact = Contato(
                    nome: controleNome.text,
                    telefone: controleTelefone.text,
                    email: controleEmail.text);
                repositorio.addContato(contact);
              });
              Navigator.pop(context, true);
            },
            child: Text("Salvar"),
          )
        ],
      )),
    );
  }
}
