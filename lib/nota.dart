class Nota {
  String titulo;
  String descripcion;
  final DateTime fechaCreacion;
  DateTime fechaModificacion;

  Nota({
    required this.titulo,
    required this.descripcion,
    DateTime? fechaCreacion,
    DateTime? fechaModificacion,
  })  : fechaCreacion = fechaCreacion ?? DateTime.now(),
        fechaModificacion = fechaModificacion ?? fechaCreacion ?? DateTime.now();
}