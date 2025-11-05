import 'package:flutter/material.dart';
import 'package:mobile/views/widgets/detalhes_filme.dart';
import 'package:mobile/views/widgets/film_card.dart';
import 'package:mobile/views/widgets/form_films.dart';
import 'package:mobile/database.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filmes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> _filmes = [];

  @override
  void initState() {
    super.initState();
    _loadFilmes();
  }

  Future<void> _loadFilmes() async {
    final filmes = await DatabaseHelper.instance.getAll();
    setState(() => _filmes = filmes);
  }

  Future<void> _adicionarFilme(Map<String, dynamic> filme) async {
    await DatabaseHelper.instance.save(filme);
    _loadFilmes();
  }

  Future<void> _atualizarFilme(Map<String, dynamic> filme) async {
    await DatabaseHelper.instance.update(filme);
    _loadFilmes();
  }


  void _mostrarOpcoesFilme(Map<String, dynamic> filme) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Detalhes'),
            onTap: () {
              Navigator.pop(context); // Fecha o BottomSheet
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetalhesFilme(
                    url: filme['url'] ?? '',
                    title: filme['title'] ?? '',
                    genre: filme['genre'] ?? '',
                    duration: filme['duration'] ?? '',
                    rating: (filme['rating'] as num?)?.toDouble() ?? 0.0,
                    age: filme['age'] ?? '',
                    year: filme['year'] ?? '',
                    description: filme['description'] ?? '',
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Alterar'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => MovieForm(
                    filme: filme,
                    onSave: _atualizarFilme,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filmes', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 34, 160, 209),
      ),
      body: _filmes.isEmpty
          ? const Center(child: Text('Clique no + para cadastrar um filme'))
          : ListView.builder(
        itemCount: _filmes.length,
        itemBuilder: (context, index) {
          final f = _filmes[index];
          return Dismissible(
            key: Key(f['id'].toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) async {
              await DatabaseHelper.instance.delete(f['id']);
              setState(() {
                _filmes.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${f['title']} foi deletado')),
              );
            },
            child: FilmeCard(
              url: f['url'] ?? '',
              title: f['title'] ?? '',
              genre: f['genre'] ?? '',
              duration: f['duration'] ?? '',
              rating: (f['rating'] as num?)?.toDouble() ?? 0.0,
              onTap: () => _mostrarOpcoesFilme(f),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => MovieForm(
                onSave: _adicionarFilme,
              ),
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
