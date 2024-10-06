import 'package:agenda_de_contatos/models/agendaController.dart';
import 'package:agenda_de_contatos/views/listagem.dart';
import 'package:flutter/material.dart';

import 'DAO/agendaDAO.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AgendaController aController = AgendaController();

  runApp(MaterialApp(home: Listagem(agendaController: aController)));
}
