class Contato {
  int? id;
  String nome;
  String telefone;
  String email;

  Contato({this.id, required this.nome, required this.telefone, required this.email});

  factory Contato.fromMap(Map<String, dynamic> map) {
    return Contato(
      id: map['id'],
      nome: map['nome'],
      telefone: map['telefone'],
      email: map['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'telefone': telefone,
      'email': email,
    };
  }

  void setId(int id){
    this.id = id;
  }

  int? getId(){
    return id;
  }

  void setNome(String nome) {
    this.nome = nome;
  }

  String getNome() {
    return nome;
  }

  void setTelefone(String telefone) {
    this.telefone = telefone;
  }

  String getTelefone() {
    return telefone;
  }

  void setEmail(String email) {
    this.email = email;
  }

  String getEmail() {
    return email;
  }
}
