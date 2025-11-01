import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart'; 

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
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: _urlController,
              decoration: const InputDecoration(labelText: 'Url Imagem'),
            ),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Título'),
              validator: (v) => v!.isEmpty ? 'Obrigatório' : null,
            ),
            TextFormField(
              controller: _genreController,
              decoration: const InputDecoration(labelText: 'Gênero'),
            ),
            DropdownButtonFormField<String>(
              value: _ageRating,
              items: _ageOptions
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => _ageRating = v!),
              decoration: const InputDecoration(labelText: 'Faixa Etária'),
            ),
            TextFormField(
              controller: _durationController,
              decoration: const InputDecoration(labelText: 'Duração'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: RatingBar.builder(
                initialRating: _rating,
                minRating: 0,
                maxRating: 5,
                allowHalfRating: true,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (r) => setState(() => _rating = r),
              ),
            ),
            TextFormField(
              controller: _yearController,
              decoration: const InputDecoration(labelText: 'Ano'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Descrição'),
              maxLines: 3,
            ),
            const SizedBox(height: 80), // espaço para o FAB
          ],
        ),
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
