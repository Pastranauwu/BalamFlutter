import 'package:flutter/material.dart';
import 'pagina_con_fondo.dart';
import 'pagina_temas_interes.dart';
import 'dart:convert'; // Para convertir JSON
import 'package:http/http.dart' as http; // Paquete http para solicitudes

// Función para enviar el JSON con la pregunta y respuesta
Future<void> enviarPreguntaRespuesta(String pregunta, String respuesta) async {
  final String apiUrl = 'http://172.31.99.176:8000/mensajes'; // Ruta de la API

  // Estructura del JSON que enviarás
  Map<String, dynamic> jsonBody = {
    'pregunta': pregunta,
    'respuesta': respuesta,
  };

  // Hacer la solicitud POST
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json', // Indica que el cuerpo es JSON
    },
    body: jsonEncode(jsonBody), // Convierte el mapa a un JSON
  );

  // Verificar si la solicitud fue exitosa
  if (response.statusCode == 200) {
    print('Datos enviados con éxito');
    print('Respuesta del servidor: ${response.body}');
  } else {
    print('Error al enviar los datos: ${response.statusCode}');
  }
}


class PaginaFormulario extends StatelessWidget {
  const PaginaFormulario({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Formulario',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Color.fromARGB(254, 236, 10, 40),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '¿Qué problemas financieros tienes?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Color.fromARGB(254, 236, 10, 40),
                  width: 3,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Escribe aquí...',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PaginaConFondo()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.grey,
                  ),
                  child: Text(
                    'Omitir',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    enviarPreguntaRespuesta(
                        '¿Cómo te llamas?', 'Me llamo Eduardo');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaginaTemasInteres()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromARGB(254, 236, 10, 40),
                  ),
                  child: Text('Enviar', style: TextStyle(fontSize: 25)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
