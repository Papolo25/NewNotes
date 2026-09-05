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
        backgroundColor: const Color.from(
          alpha: 1,
          red: 0.941,
          green: 0.627,
          blue: 0.047,
        ),
        title: const Text('TODAS MIS NOTAS'),
        titleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          fontWeight: FontWeight.bold,
        ),
      ),

      body: notas.isEmpty
          ? const Center(
              child: Text(
                'No tienes notas todavía',
                style: TextStyle(
                  color: Color.fromARGB(255, 250, 154, 9),
                  fontSize: 18,
                ),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(6),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                mainAxisExtent: 96,
              ),
              itemCount: notas.length,
              itemBuilder: (context, index) {
                return NotaCard(
                  nota: notas[index],
                  onTap: () async {
                    final dynamic resultado = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CrearNotaPage(notaInicial: notas[index]),
                      ),
                    );

                    if (!mounted || resultado == null) {
                      return;
                    }

                    setState(() {
                      if (resultado == 'delete') {
                        notas.removeAt(index);
                      } else if (resultado is Nota) {
                        notas[index] = resultado;
                      }
                    });
                  },
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 247, 151, 8),
        onPressed: () async {
          final dynamic nuevaNota = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CrearNotaPage()),
          );

          if (!mounted || nuevaNota == null) {
            return;
          }

          if (nuevaNota is Nota) {
            setState(() {
              notas.add(nuevaNota);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
