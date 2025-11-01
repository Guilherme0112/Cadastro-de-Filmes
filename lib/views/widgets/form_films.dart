import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class MovieForm extends StatefulWidget {
  final void Function(Map<String, dynamic>) onSave;

  const MovieForm({super.key, required this.onSave, required GlobalKey<FormState> formKey});


  @override
  State<MovieForm> createState() => MovieFormState();
}

class MovieFormState extends State<MovieForm> {
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

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onSave({
        'url': _urlController.text,
        'title': _titleController.text,
        'genre': _genreController.text,
        'duration': _durationController.text,
        'rating': _rating,
        'age': _ageRating,
        'year': _yearController.text,
        'description': _descriptionController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
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
                  const Text(
                    'Faixa Etária:    ',
                    style: TextStyle(fontSize: 16, color: Color.fromARGB(178, 0, 0, 0)),
                  ),
                  DropdownButton<String>(
                    value: _ageRating,
                    items: _ageOptions
                        .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ))
                        .toList(),
                    onChanged: (v) {
                      setState(() {
                        _ageRating = v!;
                      });
                    },
                  ),
                ],
              ),


              TextFormField(
                controller: _durationController,
                decoration: const InputDecoration(labelText: 'Duração'),
                validator: (v) => v!.isEmpty ? 'Obrigatório' : null,
              ),


              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    const Text(
                      'Nota: ',
                      style: TextStyle(fontSize: 16, color: Color.fromARGB(178, 0, 0, 0)),
                    ),
                    const SizedBox(width: 8),
                    SmoothStarRating(
                      rating: _rating,
                      size: 30,
                      color: Colors.blue,
                      borderColor: Colors.blue,
                      allowHalfRating: true,
                      starCount: 5,
                    ),
                  ],
                ),
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
          backgroundColor: const Color.fromARGB(255, 34, 160, 209)
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
