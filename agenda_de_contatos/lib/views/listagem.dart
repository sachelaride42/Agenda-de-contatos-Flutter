import 'package:agenda_de_contatos/models/contato.dart';
import 'package:agenda_de_contatos/models/agendaController.dart';
import 'package:agenda_de_contatos/views/cadastro.dart';
import 'package:flutter/material.dart';

class Listagem extends StatefulWidget {
  final AgendaController agendaController = AgendaController();
  Listagem({super.key);

  @override
  State<StatefulWidget> createState() {
    return Listagem_State();
  }
}

class Listagem_State extends State<Listagem> {
  late Future<List<Contato>> _futureContatos;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData(){
    setState(() {
      _futureContatos = widget.agendaController.getListaContatos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Lista de Contatos")),
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Expanded(
                child: FutureBuilder<List<Contato>>(
                    future: _futureContatos,
                    builder: (context, snapshot) {
                      print("Snapshot estado: ${snapshot.connectionState}");
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return const Center(child: CircularProgressIndicator());
                      }
                      else if (snapshot.hasError){
                        print("Erro no snapshot: ${snapshot.error}");
                        return const Center(child: Text("Erro ao carregar contatos"));
                      }
                      else if(!snapshot.hasData || snapshot.data!.isEmpty){
                        print("Nenhum contato encontrado");
                        return const Center(child: Text("Nenhum contato encontrado"));
                      }else{
                        print("Contatos carregados: ${snapshot.data!.length}");
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            Contato c = snapshot.data![index];
                            print("Renderizando contato: ${c.getNome()}, ${c.getTelefone()}, ${c.getEmail()}");
                            return ListTile(
                              title: Text(c.getNome()),
                              subtitle: Text('Tel: ${c.getTelefone()}; Email: ${c.getEmail()};'),
                              tileColor: Colors.blue.shade50,
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
                    loadData();
                  }
                },
                child: const Text("Cadastrar / Editar"),
              ),
          ]),
        );
  } //
}
