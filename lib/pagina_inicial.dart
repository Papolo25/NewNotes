import 'package:flutter/material.dart';
import 'nota.dart';
import 'nota_cardborde.dart';
import 'crear_nota.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  List<Nota> notas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 250, 188, 188),
        title: const Text('Mis notas'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
        ),
      ),

      body: notas.isEmpty
          ? const Center(
            child: Text('No tienes notas todavía',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
          )
          : GridView.builder(
    padding: const EdgeInsets.all(12),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1,
    ),
    itemCount: notas.length,
    itemBuilder: (context, index) {
      return NotaCard(
        nota: notas[index],
        onTap: () {
          // Aquí abriremos la nota
        },
      );
    },
  ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Nota? nuevaNota = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CrearNotaPage(),
            ),
          );

          if (!mounted || nuevaNota == null) {
            return;
          }

          setState(() {
            notas.add(nuevaNota);
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}