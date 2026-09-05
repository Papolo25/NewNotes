import 'package:flutter/material.dart';

import 'nota.dart';

class NotaCard extends StatelessWidget {
  final Nota nota;
  final VoidCallback? onTap;

  const NotaCard({super.key, required this.nota, this.onTap});

  String get descripcionVisible {
    const limite = 20;

    if (nota.descripcion.length <= limite) {
      return nota.descripcion;
    }

    return '${nota.descripcion.substring(0, limite)}...';
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Card(
        color: const Color(0xFF1E1E1E),

        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,

          child: Padding(
            padding: const EdgeInsets.all(6),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nota.titulo,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Divider(height: 8, thickness: 1, color: Colors.white24),

                Text(
                  descripcionVisible,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
