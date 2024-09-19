class Contato {
  String nome;
  String telefone;
  String email;

  Contato({required this.nome, required this.telefone, required this.email});

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
