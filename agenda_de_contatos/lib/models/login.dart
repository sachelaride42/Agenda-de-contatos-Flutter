class Login{
  int? id;
  String usuario;
  String senha;

  Login({this.id, required this.usuario, required this.senha});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'usuario': usuario,
      'senha': senha
    };
  }

  void setId(int id){
    this.id = id;
  }


  void setUsuario(String nome){
    this.usuario = nome;
  }

  void setSenha(String senha){
    this.senha = senha;
  }

}