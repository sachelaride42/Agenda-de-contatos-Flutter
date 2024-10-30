import 'package:agenda_de_contatos/views/listagem.dart';
import 'package:agenda_de_contatos/views/loginView.dart';
import 'package:flutter/material.dart';
import 'controller/agendaController.dart';
import 'models/autenticacao/secureStorage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Widget home;
  SecureStorage ss = SecureStorage();


  AgendaController ac = AgendaController();
  if(await ss.estaLogado()){
    print("Indo para listagem");
    home = Listagem(agendaController: ac);
  }
  else{
    print("Indo para login");
    home = LoginView(agendaController: ac);
  }
  runApp(MaterialApp(home: home));
}

