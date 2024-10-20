import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'listagem.dart';

class Login extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    SharedSessao ssessao = SharedSessao();
    TextEditingController c_usuario = TextEditingController();
    TextEditingController c_senha = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(decoration: const InputDecoration(label: Text("Nome do usuário")),controller: c_usuario),
          TextField(decoration: const InputDecoration(label: Text("Senha")), controller: c_senha,),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(label: Text("Entrar"), icon: Icon(Icons.login), onPressed: (){
                  ssessao.login(c_usuario.text);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Listagem()));
                },),
                ElevatedButton.icon(label: Text("Cadastrar"), icon: Icon(Icons.add_circle_outline_sharp), onPressed: (){}),]),
        ],),
    );
  }

}