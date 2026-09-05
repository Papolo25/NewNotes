import 'package:flutter/material.dart';
import 'nota.dart';

class CrearNotaPage extends StatefulWidget {
  const CrearNotaPage({super.key});

  @override
  State<CrearNotaPage> createState() => _CrearNotaPageState();
}

class _CrearNotaPageState extends State<CrearNotaPage> {
  String titulo = '';
  String descripcion = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 245, 182, 182),
        title: const Text('Crear nota'),
        actions: [
          IconButton(
            onPressed: () {
              if (titulo.isEmpty || descripcion.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Completa el título y la descripción'),
                  ),
                );
                return;
              }

              final nuevaNota = Nota(
                titulo: titulo,
                descripcion: descripcion,
              );

              Navigator.pop(context, nuevaNota);
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              maxLength: 20,
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              decoration: const InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                titulo = value;
              },
            ),

            const SizedBox(height: 16),

            TextField(
              maxLength: 100,
              maxLines: 8,
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                descripcion = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}