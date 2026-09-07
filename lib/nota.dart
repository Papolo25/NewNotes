class Nota {
  String titulo;
  String descripcion;
  final DateTime fechaCreacion;
  DateTime fechaModificacion;

  factory Nota({
    required String titulo,
    required String descripcion,
    DateTime? fechaCreacion,
    DateTime? fechaModificacion,
  }) {
    final fechaCreada = fechaCreacion ?? DateTime.now();

    return Nota._(
      titulo: titulo,
      descripcion: descripcion,
      fechaCreacion: fechaCreada,
      fechaModificacion: fechaModificacion ?? fechaCreada,
    );
  }

  Nota._({
    required this.titulo,
    required this.descripcion,
    required this.fechaCreacion,
    required this.fechaModificacion,
  });
}