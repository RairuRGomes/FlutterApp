/*
  App para cadastro de Filmes.

*/

import 'package:flutter/material.dart';

class Filme {
  // Atributos
  String _nome;
  int _anoLancamento;
  String _categoria;
  String _sinopse;
  int _nota;
  
  // Construtor
  Filme(this._nome, this._anoLancamento, this._categoria, this._sinopse, this._nota){ 
  }

}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Filme> lista = []; // Lista vazia

  // Construtor
  MyApp() {
    Filme movie1 = Filme("O Curioso Caso de Benjamin Button", 2008, "Romance/Fantasia", "Benjamin Button é um homem que nasce idoso e rejuvenesce à medida que o tempo passa. Doze anos depois de seu nascimento, ele conhece Daisy, uma criança que entra e sai de sua vida enquanto cresce para ser dançarina. Embora tenha todos os tipos de aventuras incomuns, sua relação com Daisy o faz acreditar que os dois se encontrarão no momento certo da vida.", 10);
    lista.add(movie1);
    
    Filme movie2 = Filme("As Aventuras de Pi", 2012, "Aventura/Drama", "Pi e sua família decidem ir para o Canadá depois de fechar o zoológico da família. A embarcação deles naufraga, e o jovem sobrevive junto com alguns animais, incluindo um temível tigre de Bengala, com o qual desenvolve uma ligação.", 9);
    lista.add(movie2);
    
    Filme movie3 = Filme("Sniper Americano", 2014, "Guerra/Ação", "História real de Chris Kyle, atirador de elite das forças especiais da marinha dos Estados Unidos. Durante a guerra do Iraque, sua missão era uma só- proteger seus companheiros. Seu dever fez dele um dos maiores atiradores da história americana. Sua precisão salva inúmeras vidas, mas também o torna um alvo preferencial. Quando Kyle finalmente volta para casa, ele descobre que não tem como deixar a guerra para trás.", 10);
    lista.add(movie3);
    
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Rairu Filmes",
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(lista),
    );
  }
}

class HomePage extends StatefulWidget {
  final List<Filme> lista;

  // Construtor
  HomePage(this.lista);

  @override
  _HomePageState createState() => _HomePageState(lista);
}

class _HomePageState extends State<HomePage> {
  final List<Filme> lista;

  // Construtor
  _HomePageState(this.lista);

  // Métodos
  void _atualizarTela() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    return Scaffold(
      drawer: NavDrawer(lista),
      appBar: AppBar(
        title: Text("Filme (${lista.length})"),
      ),
      body: ListView.builder(
          itemCount: lista.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                "FILME: ${lista[index]._nome} | CATEGORIA: ${lista[index]._categoria} | NOTA: ${lista[index]._nota}",
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {},
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _atualizarTela,
        tooltip: 'Atualizar',
        child: Icon(Icons.update),
      ),
    );
  }
}

class NavDrawer extends StatelessWidget {
  // Atributos
  final List lista;
  final double _fontSize = 17.0;

  // Construtor
  NavDrawer(this.lista);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Opcional
          DrawerHeader(
            child: Text(
              "Menu",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(color: Colors.black),
          ),
          ListTile(
            leading: Icon(Icons.duo_rounded),
            title: Text(
              "Informações do Filme",
              style: TextStyle(fontSize: _fontSize),
            ),
            onTap: () {
              Navigator.pop(context); // Fecha o Drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaInformacoesDoFilme(lista),
                ),
              );
            },
          ),
      
          ListTile(
            leading: Icon(Icons.control_point_rounded),
            title: Text(
              "Cadastrar um Novo Filme",
              style: TextStyle(fontSize: _fontSize),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaCadastrarFilme(lista),
                ),
              );
            },
          ),
          Container(
            padding: EdgeInsets.all(20.0),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ListTile(
              leading: Icon(Icons.group_sharp),
              title: Text(
                "About",
                style: TextStyle(fontSize: _fontSize),
              ),
                  onTap: () {
              Navigator.pop(context); // Fecha o Drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => About(),
                ),
              );
            },
            ),
          ),
        ],
      ),
    );
  }
}

//-----------------------------------------------------------------------------
// Tela Informações dos Filmes
//-----------------------------------------------------------------------------

class TelaInformacoesDoFilme extends StatefulWidget {
  final List<Filme> lista;

  // Construtor
  TelaInformacoesDoFilme(this.lista);

  @override
  _TelaInformacoesDoFilme createState() => _TelaInformacoesDoFilme(lista);
}

class _TelaInformacoesDoFilme extends State<TelaInformacoesDoFilme> {
  // Atributos
  final List lista;
  Filme movie;
  int index = -1;
  double _fontSize = 18.0;
  final nomeController = TextEditingController();
  final anoLancamentoController = TextEditingController();
  final categoriaController = TextEditingController();
  final sinopseController = TextEditingController();
  final notaController = TextEditingController();
  bool _edicaoHabilitada = false;

  // Construtor
  _TelaInformacoesDoFilme(this.lista) {
    if (lista.length > 0) {
      index = 0;
      movie = lista[0];
      nomeController.text = movie._nome;
      anoLancamentoController.text = movie._anoLancamento.toString();
      categoriaController.text = movie._categoria;
      sinopseController.text = movie._sinopse;
      notaController.text = movie._nota.toString();
      
    }
  }

  // Métodos
  void _exibirRegistro(index) {
    if (index >= 0 && index < lista.length) {
      this.index = index;
      movie = lista[index];
      nomeController.text = movie._nome;
      anoLancamentoController.text = movie._anoLancamento.toString();
      categoriaController.text = movie._categoria;
      sinopseController.text = movie._sinopse;
      notaController.text = movie._nota.toString();
      setState(() {});
    }
  }

  void _atualizarDados() {
    if (index >= 0 && index < lista.length) {
      _edicaoHabilitada = false;
      lista[index]._nome = nomeController.text;
      lista[index]._anoLancamento = int.parse(anoLancamentoController.text);
      lista[index]._categoria = categoriaController.text;
      lista[index]._sinopse = sinopseController.text;
      lista[index]._nota = int.parse(notaController.text);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var titulo = "Informações do Filme";
    if (movie == null) {
      return Scaffold(
        appBar: AppBar(title: Text(titulo)),
        body: Column(
          children: <Widget>[
            Text("Nenhum Filme encontrado!"),
            Container(
              color: Colors.red,
              child: BackButton(),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  _edicaoHabilitada = true;
                  setState(() {});
                },
                tooltip: 'Habilitar Edição',
                child: Icon(Icons.edit_outlined),              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                enabled: _edicaoHabilitada,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nome do Filme",
                
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: nomeController,
              ),
            ),
            // --- Ano de Lançamento do Filme ---
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                enabled: _edicaoHabilitada,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Ano de Lançamento do Filme",
                 
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: anoLancamentoController,
              ),
            ),
            // --- Categoria do Filme ---
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                enabled: _edicaoHabilitada,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Categoria do Filme",
                  
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: categoriaController,
              ),
            ),
            // --- Sinopse do Filme ---
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                enabled: _edicaoHabilitada,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Sinopse do Filme",
                  
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: sinopseController,
              ),
            ),
             // --- Nota do Filme ---
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                enabled: _edicaoHabilitada,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nota do Filme",
                  
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: notaController,
              ),
            ),
            
            RaisedButton(
              child: Text(
                "Atualizar Dados",
                style: TextStyle(fontSize: _fontSize),
              ),
              onPressed: _atualizarDados,
            ),
            Text(
              "[${index + 1}/${lista.length}]",
              style: TextStyle(fontSize: 15.0),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <FloatingActionButton>[
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _exibirRegistro(0),
                    tooltip: 'Primeiro',
                    child: Icon(Icons.first_page),
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _exibirRegistro(index - 1),
                    tooltip: 'Retroceder',
                    child: Icon(Icons.navigate_before),
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _exibirRegistro(index + 1),
                    tooltip: 'Avançar',
                    child: Icon(Icons.navigate_next),
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _exibirRegistro(lista.length - 1),
                    tooltip: 'Último',
                    child: Icon(Icons.last_page),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//-----------------------------------------------------------------------------
// Tela: About
// ----------------------------------------------------------------------------

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Sobre")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Aplicação:", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Aplicativo desenvolvido no curso de Tecnologia em Análise e Desenvolvimento de Sistemas do UNISAL - Centro Universitário Salesiano de São Paulo - Campus São José,"),
              Text("durante a aula de Desenvolvimento para Dispositivo Móvel, WEB e Game com o obejtivo de catalogação e avalição de filmes"),
              Text("Criado e Desenvolvido por:",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Rairu Rufino Gomes"),
              Text("RA:", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("140001295"),
            
            ],
          ),
        ));
  }
}

//-----------------------------------------------------------------------------
// Tela: Cadastrar Filme
// ----------------------------------------------------------------------------

class TelaCadastrarFilme extends StatefulWidget {
  final List<Filme> lista;

  // Construtor
  TelaCadastrarFilme(this.lista);

  @override
  _TelaCadastrarFilmeState createState() => _TelaCadastrarFilmeState(lista);
}

class _TelaCadastrarFilmeState extends State<TelaCadastrarFilme> {
  // Atributos
  final List<Filme> lista;
  String _nome;
  int _anoLancamento;
  String _categoria;
  String _sinopse;
  int _nota;
  double _fontSize = 20.0;
  final nomeController = TextEditingController();
  final anoLancamentoController = TextEditingController();
  final categoriaController = TextEditingController();
  final sinopseController = TextEditingController();
  final notaController = TextEditingController();

  // Construtor
  _TelaCadastrarFilmeState(this.lista);

  // Métodos
  void _cadastrarFilme() {
    _nome = nomeController.text;
    _anoLancamento = int.parse(anoLancamentoController.text);
    _categoria = categoriaController.text;
    _sinopse = sinopseController.text;
    _nota = int.parse(notaController.text);
    
    if (_nome != "" && _anoLancamento > 0 && _categoria != "" && _sinopse != "" && _nota > 0) {
      var movie = Filme(_nome, _anoLancamento, _categoria, _sinopse, _nota); // Cria um novo objeto

      lista.add(movie);
      // _index = lista.length - 1;
      nomeController.text = "";
      anoLancamentoController.text = "";
      categoriaController.text = "";
      sinopseController.text = "";
      notaController.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar Filme"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Text(
                "Dados do Filme:",
                style: TextStyle(fontSize: _fontSize),
              ),
            ),
            // --- Nome do Filme ---
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nome do Filme",
                  hintText: "Nome do Filme"
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: nomeController,
              ),
            ),
            // --- Ano de Lançamento do Filme ---
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Ano de Lançamento do Filme",
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: anoLancamentoController,
              ),
            ),
            // --- Categoria do Filme ---
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Categoria do Filme",
                  
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: categoriaController,
              ),
            ),
            
            // --- Sinopse do Filme ---
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Sinopse do Filme",
                  
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: sinopseController,
              ),
            ),
            
            // --- Nota do Filme ---
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nota do Filme",
                  
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: notaController,
              ),
            ),
            // Saída
            RaisedButton(
              child: Text(
                "Cadastrar Filme",
                style: TextStyle(fontSize: _fontSize),
              ),
              onPressed: _cadastrarFilme,
            ),
          ],
        ),
      ),
    );
  }
}
