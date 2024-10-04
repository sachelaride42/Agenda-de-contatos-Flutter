import 'package:agenda_de_contatos/models/contato.dart';
import 'package:agenda_de_contatos/models/agendaController.dart';
import 'package:agenda_de_contatos/views/edicao_exclusao.dart';
import 'package:flutter/material.dart';

class Cadastro extends StatefulWidget {
  final AgendaController rC;

  const Cadastro({super.key, required this.rC});

  @override
  State<StatefulWidget> createState() {
    return CadastroState(repositorio: rC);
  }
}

class CadastroState extends State<Cadastro> {
  AgendaController repositorio;

  CadastroState({required this.repositorio});

  TextEditingController controleNome = TextEditingController();
  TextEditingController controleTelefone = TextEditingController();
  TextEditingController controleEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro e edição de Contatos"),
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
                  subtitle:
                      Text('Tel: ${c.getTelefone()}; Email: ${c.getEmail()}'),
                  onTap: () async {
                    final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EdicaoExclusao(
                                contato: c, repo: repositorio, indice: index)));
                    if (result == true) {
                      setState(() {});
                      Navigator.pop(context, true);
                    }
                  });
            },
          )),
          const Text("Para editar ou excluir, selecione um contato"),
          TextFormField(
            controller: controleNome,
            decoration:
                const InputDecoration(labelText: "Nome", hintText: "Insira o nome"),
          ),
          TextField(
            controller: controleTelefone,
            decoration: const InputDecoration(
                labelText: "Telefone", hintText: "(XX) XXXXX-XXXX"),
          ),
          TextFormField(
              controller: controleEmail,
              decoration: const InputDecoration(
                  labelText: "Email", hintText: "email@exemplo.com")),
          TextButton(
            onPressed: () {
              if (validaContato(
                  context, controleNome, controleTelefone, controleEmail)) {
                setState(() {
                  Contato contact = Contato(
                      nome: controleNome.text,
                      telefone: controleTelefone.text,
                      email: controleEmail.text);
                  repositorio.addContato(contact);
                });
                Navigator.pop(context, true);
              }
            },
            child: const Text("Salvar"),
          )
        ],
      )),
    );
  }
}

bool validaContato(BuildContext context, TextEditingController cNome,
    TextEditingController cTelefone, TextEditingController cEmail) {
  RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  RegExp phoneRegExp = RegExp(r'^\(\d{2}\) \d{5}-\d{4}$');

  if (cNome.text.isEmpty) {
    mostrarErro(context, "Por favor, preencha o nome");
    return false;
  }

  if (cTelefone.text.isEmpty) {
    mostrarErro(context, "Por favor, insira o telefone");
    return false;
  } else if (!phoneRegExp.hasMatch(cTelefone.text)) {
    mostrarErro(context, "Formato de telefone inválido, use (XX) XXXXX-XXXX");
    return false;
  }

  if (cEmail.text.isEmpty) {
    mostrarErro(context, "Por favor, insira o email");
    return false;
  } else if (!emailRegExp.hasMatch(cEmail.text)) {
    mostrarErro(context, "Formato de email inválido");
    return false;
  }

  return true;
}

void mostrarErro(BuildContext context, String mensagem) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text("Erro"),
            content: Text(mensagem),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ]);
      });
}
