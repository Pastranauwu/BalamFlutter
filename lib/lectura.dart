import 'package:flutter/material.dart';

// Clase para la página de Lectura
class Lectura extends StatelessWidget {
  final String tema;

  const Lectura({Key? key, required this.tema}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tema),
      ),
      body: Center(
        child: Text(
          'Contenido de $tema',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
