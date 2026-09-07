import 'package:flutter/material.dart';

import 'nota.dart';

class CrearNotaPage extends StatefulWidget {
  final Nota? notaInicial;

  const CrearNotaPage({super.key, this.notaInicial});

  @override
  State<CrearNotaPage> createState() => _CrearNotaPageState();
}

class _CrearNotaPageState extends State<CrearNotaPage> {
  late final TextEditingController _tituloController;
  late final TextEditingController _descripcionController;
  late final String _tituloInicial;
  late final String _descripcionInicial;

  bool _cerrando = false;

  bool get isEditing => widget.notaInicial != null;

  bool get hayCambiosSinGuardar =>
      _tituloController.text != _tituloInicial ||
      _descripcionController.text != _descripcionInicial;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(
      text: widget.notaInicial?.titulo ?? '',
    );
    _descripcionController = TextEditingController(
      text: widget.notaInicial?.descripcion ?? '',
    );
    _tituloInicial = _tituloController.text;
    _descripcionInicial = _descripcionController.text;
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  void _guardarNota() {
    final titulo = _tituloController.text.trim();
    final descripcion = _descripcionController.text.trim();

    if (titulo.isEmpty || descripcion.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa el título y la descripción')),
      );
      return;
    }

    final notaGuardada = Nota(
      titulo: titulo,
      descripcion: descripcion,
      fechaCreacion: widget.notaInicial?.fechaCreacion,
      fechaModificacion: DateTime.now(),
    );

    _cerrando = true;
    Navigator.pop(context, notaGuardada);
  }

  Future<void> _manejarIntentoDeSalida(
    bool didPop,
    Object? result,
  ) async {
    if (didPop || _cerrando || !mounted) {
      return;
    }

    if (!hayCambiosSinGuardar) {
      _cerrando = true;
      Navigator.pop(context);
      return;
    }

    final salirSinGuardar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cambios sin guardar'),
        content: const Text(
          'Tienes cambios sin guardar. ¿Quieres salir sin guardar?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Seguir editando'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Salir sin guardar'),
          ),
        ],
      ),
    );

    if (salirSinGuardar == true && mounted) {
      _cerrando = true;
      Navigator.pop(context);
    }
  }

  Future<void> _eliminarNota() async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar nota'),
        content: const Text('¿Estás seguro de que quieres eliminar esta nota?'),
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
      Navigator.pop(context, 'delete');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: _manejarIntentoDeSalida,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(234, 0, 0, 0),
        appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 247, 151, 8),
        title: Text(isEditing ? 'Editar nota' : 'Crear nota'),
        actions: [
          if (isEditing)
            IconButton(
              onPressed: _eliminarNota,
              icon: const Icon(Icons.delete),
              tooltip: 'Eliminar nota',
              color: const Color.fromARGB(255, 255, 82, 82),
            ),
          IconButton(
            onPressed: _guardarNota,
            icon: const Icon(Icons.save),
            tooltip: 'Guardar nota',
          ),
        ],
        ),

        body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _tituloController,
                style: const TextStyle(color: Colors.white),
                cursorColor: const Color.fromARGB(255, 240, 121, 10),
                decoration: const InputDecoration(
                  labelText: 'Título',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 243, 115, 11),
                  ),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white24),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 243, 115, 11),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: _descripcionController,
                maxLines: 8,
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(214, 233, 109, 8),
                  ),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white24),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 245, 182, 182),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
        ),
      ),
    );
  }
}
