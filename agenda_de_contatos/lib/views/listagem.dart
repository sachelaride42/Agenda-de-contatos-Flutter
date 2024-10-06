import 'package:agenda_de_contatos/models/contato.dart';
import 'package:agenda_de_contatos/models/agendaController.dart';
import 'package:agenda_de_contatos/views/cadastro.dart';
import 'package:flutter/material.dart';

class Listagem extends StatefulWidget {
  AgendaController agendaController;
  Listagem({super.key, required this.agendaController});

  @override
  State<StatefulWidget> createState() {
    return Listagem_State();
  }
}

class Listagem_State extends State<Listagem> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Lista de Contatos")),
        body: Center(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Expanded(
                child: FutureBuilder<List<Contato>>(
                    future: widget.agendaController.getListaContatos(),
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
                              subtitle: Text('Tel: ${c.getTelefone()}; Email: ${c.getEmail()};'),
                            );
                          }
                        );
                      }
                    }
                    )),
            TextButton(
              onPressed: () async {
                final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Cadastro(
                            aC: widget.agendaController,
                            )));
                if (result == true) {
                  setState(() {});
                }
              },
              child: const Text("Cadastrar / Editar"),
            ),
          ]),
        ));
  } //
}
