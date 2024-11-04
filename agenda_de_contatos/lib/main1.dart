import 'package:agenda_de_contatos/controller/agendaController.dart';
import 'package:agenda_de_contatos/views/listagem.dart';
import 'package:flutter/material.dart';
import 'models/autenticacao/sharedSession.dart';
import 'views/loginView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      body: Center(
        child: Text("Título"),
      ),),);
  }

}
