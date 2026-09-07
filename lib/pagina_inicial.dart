import 'package:flutter/material.dart';

import 'nota.dart';
import 'nota_cardborde.dart';
import 'crear_nota.dart';
import 'ordenar_notas.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  List<Nota> notas = [];
  TipoOrden ordenActual = TipoOrden.fechaCreacion;

  void _ordenarNotas(TipoOrden orden) {
    setState(() {
      ordenActual = orden;
      notas = ordenarNotas(notas, orden);
    });
    Navigator.pop(context);
  }

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
        actions: [
          Builder(
            builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              icon: const Icon(Icons.filter_list),
              tooltip: 'Ordenar notas',
            ),
          ),
        ],
      ),

      endDrawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(24, 24, 24, 12),
                child: Text(
                  'Ordenar notas',
                  style: TextStyle(
                    color: Color.fromARGB(255, 250, 154, 9),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              RadioGroup<TipoOrden>(
                groupValue: ordenActual,
                onChanged: (orden) {
                  if (orden != null) _ordenarNotas(orden);
                },
                child: const Column(
                  children: [
                    RadioListTile<TipoOrden>(
                      value: TipoOrden.fechaCreacion,
                      title: Text(
                        'Fecha de creación',
                        style: TextStyle(color: Color.fromARGB(255, 250, 154, 9)),
                      ),
                      subtitle:  Text(
                        'Más recientes primero',
                        style: TextStyle(color: Color.fromARGB(255, 252, 251, 251)),
                      ),
                    ),
                    RadioListTile<TipoOrden>(
                      value: TipoOrden.fechaModificacion,
                      title:  Text(
                        'Fecha de modificación',
                        style: TextStyle(color: Color.fromARGB(255, 250, 154, 9)),
                      ),
                      subtitle:  Text(
                        'Más recientes primero',
                        style: TextStyle(color: Color.fromARGB(255, 253, 253, 252)),
                      ),
                    ),
                    RadioListTile<TipoOrden>(
                      value: TipoOrden.antiguedad,
                      title:  Text(
                        'Antigüedad',
                        style: TextStyle(color: Color.fromARGB(255, 250, 154, 9)),
                      ),
                      subtitle:  Text(
                        'Más antiguas primero',
                        style: TextStyle(color: Color.fromARGB(255, 248, 248, 247)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
                        notas = ordenarNotas(notas, ordenActual);
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
              notas = ordenarNotas(notas, ordenActual);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
