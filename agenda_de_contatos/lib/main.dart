import 'package:agenda_de_contatos/views/listagem.dart';
import 'package:agenda_de_contatos/views/login.dart';
import 'package:flutter/material.dart';
import 'models/agendaController.dart';
import 'models/autenticacao/sharedSession.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Widget home;

  AgendaController ac = AgendaController();
  SharedSessao ss = SharedSessao();
  if(await ss.estaLogado()){
    home = Listagem(agendaController: ac);
  }
  else{
    home = Login(agendaController: ac,);
  }
  runApp(MaterialApp(home: home));
}

