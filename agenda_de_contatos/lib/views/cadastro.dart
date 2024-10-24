import 'package:agenda_de_contatos/models/contato.dart';
import 'package:agenda_de_contatos/controller/agendaController.dart';
import 'package:agenda_de_contatos/views/edicao_exclusao.dart';
import 'package:flutter/material.dart';

class Cadastro extends StatefulWidget {
  final AgendaController aC;

  const Cadastro({super.key, required this.aC});

  @override
  State<StatefulWidget> createState() {
    return CadastroState(aController: aC);
  }
}

class CadastroState extends State<Cadastro> {
  AgendaController aController;

  CadastroState({required this.aController});

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
              child: FutureBuilder<List<Contato>>(
                  future: widget.aC.getListaContatos(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator());
                    }
                    else if (snapshot.hasError){
                      return const Center(child: Text("Erro ao carregar contatos"));
                    }
                    else if(!snapshot.hasData || snapshot.data!.isEmpty){
                      return const Center(child: Text("Nenhum contato encontrado"));
                    }else{
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            Contato c = snapshot.data![index];
                            return ListTile(
                              title: Text(c.getNome()),
                              subtitle: Text('Tel: ${c.getTelefone()}; Email: ${c.getEmail()}'),
                                onTap: () async {
                                  final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EdicaoExclusao(
                                                  contato: c,
                                                  aController: aController,
                                                  )));
                                  if (result == true) {
                                    setState(() {});
                                    Navigator.pop(context, true);
                                  }
                                }
                            );
                          }
                      );
                    }
                  }
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
            onPressed: () async {
              if (validaContato(
                  context, controleNome, controleTelefone, controleEmail)) {
                  Contato contact = Contato(
                  nome: controleNome.text,
                  telefone: controleTelefone.text,
                  email: controleEmail.text);
                  await aController.addContato(contact);
                  setState(() {

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
