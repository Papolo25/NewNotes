import 'nota.dart';

enum TipoOrden { fechaCreacion, fechaModificacion, antiguedad }

List<Nota> ordenarNotas(List<Nota> notas, TipoOrden orden) {
  final notasOrdenadas = List<Nota>.of(notas);

  notasOrdenadas.sort((a, b) {
    final DateTime fechaA = orden == TipoOrden.fechaModificacion
        ? a.fechaModificacion
        : a.fechaCreacion;
    final DateTime fechaB = orden == TipoOrden.fechaModificacion
        ? b.fechaModificacion
        : b.fechaCreacion;

    return orden == TipoOrden.antiguedad
        ? fechaA.compareTo(fechaB)
        : fechaB.compareTo(fechaA);
  });

  return notasOrdenadas;
}
