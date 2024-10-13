import 'package:flutter/material.dart';
import 'pagina_con_fondo.dart';
import 'pagina_temas_interes.dart';
import 'dart:convert'; // Para convertir JSON
import 'package:http/http.dart' as http; // Paquete http para solicitudes

// Modelo para representar la respuesta de la API
class RespuestaApi {
  final String preguntaRecibida;
  final String respuestaRecibida;
  final List<String> subtemasRecomendados;

  RespuestaApi({
    required this.preguntaRecibida,
    required this.respuestaRecibida,
    required this.subtemasRecomendados,
  });

  // Método para crear una instancia de RespuestaApi a partir de un JSON
  factory RespuestaApi.fromJson(Map<String, dynamic> json) {
    return RespuestaApi(
      preguntaRecibida: json['pregunta_recibida'],
      respuestaRecibida: json['respuesta_recibida'],
      subtemasRecomendados: List<String>.from(json['subtemas_recomendados']),
    );
  }
}

// Función para enviar el JSON con la pregunta y respuesta y recibir la respuesta filtrada
Future<RespuestaApi?> enviarPreguntaRespuesta(
    String pregunta, String respuesta) async {
  final String apiUrl = 'http://172.31.99.197:49749/mensajes'; // Ruta de la API

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

    // Decodificar el JSON recibido
    final String responseBody = utf8.decode(response.bodyBytes);
    final Map<String, dynamic> jsonResponse = jsonDecode(responseBody);

    return RespuestaApi.fromJson(
        jsonResponse); // Crear y devolver la instancia de RespuestaApi
  } else {
    print('Error al enviar los datos: ${response.statusCode}');
    return null; // Devolver null si hay un error
  }
}

class PaginaFormulario extends StatelessWidget {
  const PaginaFormulario({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _textController = TextEditingController();
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
                controller: _textController,
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
                    print("presionaste");
                    String textoIngresado =
                        _textController.text; // Obtener el texto del TextField
                    // Llamar a la función para enviar la pregunta y respuesta
                    RespuestaApi? respuestaApi = await enviarPreguntaRespuesta(
                        '¿Qué problemas financieros tienes?', textoIngresado);
                    if (respuestaApi != null) {
                      // Navegar a la siguiente página y pasar los subtemas
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaginaTemasInteres(
                            subtemas: respuestaApi.subtemasRecomendados,
                          ),
                        ),
                      );
                    }
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
