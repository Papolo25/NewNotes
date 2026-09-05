import 'package:flutter/material.dart';
import 'nota.dart';

class NotaCard extends StatelessWidget {
  final Nota nota;
  final VoidCallback? onTap;

  const NotaCard({
    super.key,
    required this.nota,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Card(
        color: const Color(0xFF1E1E1E),

        margin: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),

        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,

          child: Padding(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nota.titulo,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  nota.descripcion,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}