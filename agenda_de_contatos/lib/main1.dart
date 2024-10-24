import 'package:agenda_de_contatos/controller/agendaController.dart';
import 'package:agenda_de_contatos/views/listagem.dart';
import 'package:flutter/material.dart';
import 'models/autenticacao/sharedSession.dart';
import 'views/loginView.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  AgendaController ac = AgendaController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<bool>(
        future: SharedSessao().estaLogado(), // Verifica se o usuário está logado
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),  // Mostra um "carregando" enquanto verifica
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(child: Text('Erro ao verificar o estado de login')),
            );
          } else if (snapshot.data == true) {
            return Listagem(agendaController: ac);  // Se o usuário está logado, vai para a tela de listagem
          } else {
            return LoginView(agendaController: ac);  // Se o usuário não está logado, vai para a tela de login
          }
        },
      ),
    );
  }
}
