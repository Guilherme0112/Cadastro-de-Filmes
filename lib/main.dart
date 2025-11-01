import 'package:flutter/material.dart';
import 'package:mobile/views/widgets/button.dart';
import 'package:mobile/views/widgets/form_films.dart';

final GlobalKey<MovieFormState> _movieFormKey = GlobalKey<MovieFormState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 119, 255),
        ),
        useMaterial3: true,
      ),

      home: const MyHomePage(title: 'Filmes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Filmes',
          style: TextStyle(color: Colors.white),
        ),

        backgroundColor: const Color.fromARGB(255, 34, 160, 209),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Equipe:'),
                  content: const Text('Guilherme Mendes Gomes'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Ok'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),


      body: Center(child: Text('Clique no + para cadastrar um filme')),
      floatingActionButton: Button(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'Cadastrar Filme',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: const Color.fromARGB(255, 34, 160, 209),
                ),
                body: MovieForm(
                  onSave: (data) {
                    print(data);
                    Navigator.of(context).pop();
                  },
                  formKey: GlobalKey<FormState>(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
