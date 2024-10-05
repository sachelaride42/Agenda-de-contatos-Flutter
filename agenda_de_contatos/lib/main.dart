import 'package:agenda_de_contatos/models/agendaController.dart';
import 'package:agenda_de_contatos/views/listagem.dart';
import 'package:flutter/material.dart';

void main() {
  AgendaController aController = AgendaController();
  runApp(MaterialApp(home: Listagem(agendaController: aController)));
}
