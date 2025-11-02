import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mobile/database.dart';

class MovieForm extends StatefulWidget {
  final void Function(Map<String, dynamic>) onSave;

  MovieForm({super.key, required this.onSave});
  final _formKey = GlobalKey<FormState>();

  @override
  State<MovieForm> createState() => _MovieFormState();
}

class _MovieFormState extends State<MovieForm> {
  final _formKey = GlobalKey<FormState>();
  final _urlController = TextEditingController();
  final _titleController = TextEditingController();
  final _genreController = TextEditingController();
  final _durationController = TextEditingController();
  final _yearController = TextEditingController();
  final _descriptionController = TextEditingController();
  double _rating = 0;
  String _ageRating = 'Livre';
  final List<String> _ageOptions = ['Livre', '10+', '12+', '14+', '16+', '18+'];

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final filme = {
        'url': _urlController.text,
        'title': _titleController.text,
        'genre': _genreController.text,
        'duration': _durationController.text,
        'rating': _rating,
        'age': _ageRating,
        'year': _yearController.text,
        'description': _descriptionController.text,
      };

      await DatabaseHelper.instance.save(filme);

      widget.onSave(filme);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Filme salvo com sucesso!')),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Filme', style: TextStyle(color: Colors.white)),
      backgroundColor: const Color.fromARGB(255, 34, 160, 209),),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _urlController,
                decoration: const InputDecoration(labelText: 'Url Imagem'),
                validator: (v) => v!.isEmpty ? 'Obrigatório' : null,
              ),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (v) => v!.isEmpty ? 'Obrigatório' : null,
              ),
              TextFormField(
                controller: _genreController,
                decoration: const InputDecoration(labelText: 'Gênero'),
                validator: (v) => v!.isEmpty ? 'Obrigatório' : null,
              ),
              Row(
                children: [
                  const Text('Faixa Etária:  '),
                  DropdownButton<String>(
                    value: _ageRating,
                    items: _ageOptions
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) => setState(() => _ageRating = v!),
                  ),
                ],
              ),
              TextFormField(
                controller: _durationController,
                decoration: const InputDecoration(labelText: 'Duração'),
                validator: (v) => v!.isEmpty ? 'Obrigatório' : null,
              ),
              Row(
                children: [
                  const Text('Nota: '),
                  const SizedBox(width: 8),
                  RatingBar.builder(
                    initialRating: _rating,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 30,
                    itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.blue),
                    onRatingUpdate: (rating) => setState(() => _rating = rating),
                  ),
                ],
              ),
              TextFormField(
                controller: _yearController,
                decoration: const InputDecoration(labelText: 'Ano'),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? 'Obrigatório' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descrição'),
                maxLines: 3,
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submit,
        child: const Icon(Icons.save, color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 34, 160, 209),
      ),
    );
  }

  @override
  void dispose() {
    _urlController.dispose();
    _titleController.dispose();
    _genreController.dispose();
    _durationController.dispose();
    _yearController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
