# Agenda de contatos Flutter
Prova faculdade
Aluno: Mateus Roberto Sachelaride
RGM: 802.369

Instruções:
Este projeto é uma aplicação simples de cadastro de contatos desenvolvida com Flutter. A aplicação permite que os usuários cadastrem, editem, excluam e visualizem contatos, com os campos nome, telefone e e-mail. O projeto segue o padrão de organização, pelas pastas, com classes para telas, repositório e entidade.

Pré-requisitos
Para executar este projeto, você precisará de:
- Flutter SDK instalado
- Dart SDK (geralmente incluído com o Flutter)
- Um emulador Android/iOS ou um dispositivo físico conectado
- Instalar o Flutter

Configuração do Projeto
Siga as etapas abaixo para configurar o projeto localmente:
- Clone o repositório
- Navegue até o diretório do projeto (vai depender de onde foi instalado)
- Configure um emulador

Executando o Projeto
Depois de configurar o ambiente, siga estas etapas para executar o projeto:
- Executar no emulador ou dispositivo conectado com "flutter run". Isso irá compilar e rodar o projeto no dispositivo ou emulador configurado.

Build para produção:
Caso queira gerar um APK ou IPA para distribuição em dispositivos:
- Para Android: flutter build apk

Estrutura do Projeto
O projeto segue uma estrutura organizada, separada em telas, modelo de dados e repositório. Aqui está um resumo da organização dos arquivos:
- lib/: Contém todos os arquivos do projeto Flutter.
- models/: Contém a classe Contato que representa a entidade do contato e a classe RepositorioContatos responsável pela manipulação de dados.
- views/: Contém as 3 telas Cadastro, EdiçãoExclusão e Listagem, mais métodos adicionais para lidar com validação.
- main.dart: Arquivo principal do projeto.

Funcionalidades Implementadas
Adicionar contato: Preencha os campos de nome, telefone e email e adicione o contato à lista.
Editar contato: Selecione um contato e edite as informações.
Excluir contato: Remova um contato da lista de contatos.
Validação de dados: Verifica a validade dos campos de nome, telefone e e-mail.

