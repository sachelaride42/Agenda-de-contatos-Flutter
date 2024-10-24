import 'package:agenda_de_contatos/models/autenticacao/sharedSession.dart';
import 'package:agenda_de_contatos/models/contato.dart';
import 'package:agenda_de_contatos/controller/agendaController.dart';
import 'package:agenda_de_contatos/views/cadastro.dart';
import 'package:flutter/material.dart';

import 'loginView.dart';

class Listagem extends StatefulWidget {
  AgendaController agendaController;
  SharedSessao ssessao = SharedSessao();
  Listagem({super.key, required this.agendaController});

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

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
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
        appBar: AppBar(title: const Text("Lista de Contatos"), actions: [IconButton(icon: Icon(Icons.logout) ,onPressed: () async{
          await widget.ssessao.removerToken();
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginView(agendaController: widget.agendaController)),
                  (Route<dynamic> route) => false);
        })],),
        body: Column(crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
