import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../controller/agendaController.dart';
import '../controller/loginController.dart';
import '../models/autenticacao/sharedSession.dart';
import 'listagem.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key, required this.agendaController});

  AgendaController agendaController;

  @override
  State<StatefulWidget> createState() {
    return _LoginView();
  }

}
class _LoginView extends State<LoginView>{
  LoginController loginController = LoginController();
  SharedSessao ssessao = SharedSessao();
  TextEditingController c_usuario = TextEditingController();
  TextEditingController c_senha = TextEditingController();

  @override
  void dispose(){
    c_usuario.dispose();
    c_senha.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
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
                ElevatedButton.icon(label: Text("Entrar"), icon: Icon(Icons.login), onPressed: () async{
                  if(await loginController.temLogin(c_usuario.text, c_senha.text)){
                    ssessao.login(c_usuario.text);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Listagem(agendaController: widget.agendaController,)),
                            (Route<dynamic> route) => false);
                  }
                  else{
                    _mostrarAviso(context, "Erro ao logar");
                  }
                },),
                ElevatedButton.icon(label: Text("Cadastrar"), icon: Icon(Icons.add_circle_outline_sharp), onPressed: () async{
                  try{
                    await loginController.cadastrarLogin(c_usuario.text, c_senha.text);
                  }
                  catch(e){
                    _mostrarAviso(context, "Erro ao cadastrar");
                    return;
                  }
                  _mostrarAviso(context, "Cadastrado com sucesso");
                }),]),
        ],),
    );
  }



}

void _mostrarAviso (BuildContext context, String conteudo){
  showDialog(
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
        title: Text("Aviso"),
        content: Text(conteudo),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          },
          child: Text("Ok"))
        ]
      );
    }
  );
}

