import 'package:agenda_de_contatos/DAO/loginDAO.dart';

import '../models/login.dart';

class LoginController{
  LoginDAO loginDAO = LoginDAO();

  Future<void> cadastrarLogin(String usuario, String senha) async{
    Login login = Login(usuario: usuario,senha: senha);
    await loginDAO.cadastrarLogin(login);
  }

  Future<bool> temLogin(String usuario, String senha) async{
    return await loginDAO.temLogin(usuario, senha);
  }
}