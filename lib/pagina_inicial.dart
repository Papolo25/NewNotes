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
  List<Nota> notasEliminadas = [];
  TipoOrden ordenActual = TipoOrden.fechaCreacion;

  void _ordenarNotas(TipoOrden orden) {
    setState(() {
      ordenActual = orden;
      notas = ordenarNotas(notas, orden);
    });
    Navigator.pop(context);
  }

  void _restaurarNota(Nota nota) {
    setState(() {
      notasEliminadas.remove(nota);
      notas.add(nota);
      notas = ordenarNotas(notas, ordenActual);
    });
    Navigator.pop(context);
  }

  Future<void> _eliminarDefinitivamente(Nota nota) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar definitivamente'),
        content: const Text('Esta nota no se podrá recuperar.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmar == true && mounted) {
      setState(() => notasEliminadas.remove(nota));
    }
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
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(Icons.menu),
            tooltip: 'Opciones',
          ),
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

      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(24, 24, 24, 12),
                child: Text(
                  'Opciones',
                  style: TextStyle(
                    color: Color.fromARGB(255, 250, 154, 9),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.delete_outline,
                  color: Color.fromARGB(255, 250, 154, 9),
                ),
                title: const Text(
                  'Papelera',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: notasEliminadas.isEmpty
                    ? null
                    : CircleAvatar(
                        radius: 12,
                        backgroundColor: const Color.fromARGB(255, 250, 154, 9),
                        child: Text(
                          '${notasEliminadas.length}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                onTap: () => Navigator.pop(context),
              ),
              const Divider(color: Colors.white24),
              Expanded(
                child: notasEliminadas.isEmpty
                    ? const Center(
                        child: Text(
                          'La papelera está vacía',
                          style: TextStyle(color: Colors.white54),
                        ),
                      )
                    : ListView.builder(
                        itemCount: notasEliminadas.length,
                        itemBuilder: (context, index) {
                          final nota = notasEliminadas[index];
                          return ListTile(
                            title: Text(
                              nota.titulo,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: const Text(
                              'Nota eliminada',
                              style: TextStyle(color: Colors.white54),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () => _restaurarNota(nota),
                                  icon: const Icon(Icons.restore),
                                  color: const Color.fromARGB(255, 250, 154, 9),
                                  tooltip: 'Restaurar nota',
                                ),
                                IconButton(
                                  onPressed: () =>
                                      _eliminarDefinitivamente(nota),
                                  icon: const Icon(Icons.delete_forever),
                                  color: Colors.redAccent,
                                  tooltip: 'Eliminar definitivamente',
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
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
                        style: TextStyle(
                          color: Color.fromARGB(255, 250, 154, 9),
                        ),
                      ),
                      subtitle: Text(
                        'Más recientes primero',
                        style: TextStyle(
                          color: Color.fromARGB(255, 252, 251, 251),
                        ),
                      ),
                    ),
                    RadioListTile<TipoOrden>(
                      value: TipoOrden.fechaModificacion,
                      title: Text(
                        'Fecha de modificación',
                        style: TextStyle(
                          color: Color.fromARGB(255, 250, 154, 9),
                        ),
                      ),
                      subtitle: Text(
                        'Más recientes primero',
                        style: TextStyle(
                          color: Color.fromARGB(255, 253, 253, 252),
                        ),
                      ),
                    ),
                    RadioListTile<TipoOrden>(
                      value: TipoOrden.antiguedad,
                      title: Text(
                        'Antigüedad',
                        style: TextStyle(
                          color: Color.fromARGB(255, 250, 154, 9),
                        ),
                      ),
                      subtitle: Text(
                        'Más antiguas primero',
                        style: TextStyle(
                          color: Color.fromARGB(255, 248, 248, 247),
                        ),
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
                        notasEliminadas.add(notas.removeAt(index));
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
