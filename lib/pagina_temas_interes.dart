import 'package:balam_front/pagina_con_fondo.dart';
import 'package:flutter/material.dart';
import 'dart:convert'; // Para convertir JSON
import 'package:http/http.dart' as http; // Paquete http para solicitudes

int cambio = 0;

// Modelo para los datos
// ignore: camel_case_types
class datos {
  final String id;
  final String name;

  datos({required this.id, required this.name});

  // Convertir JSON a un objeto de MiModelo
  factory datos.fromJson(Map<String, dynamic> json) {
    return datos(
      id: json['id'],
      name: json['name'],
    );
  }
}

// Función para hacer la llamada a la API y guardar datos
Future<List<datos>> fetchDatosDeApi() async {
  final String apiUrl = 'http://127.0.0.1:50654/ruta/1'; // URL de la API
  final response = await http.get(Uri.parse(apiUrl)); // Hacer la solicitud GET

  if (response.statusCode == 200) {
    // Si la respuesta es exitosa (200), se decodifica el JSON
    List<dynamic> jsonResponse = json.decode(response.body);

    // Se convierte la respuesta en una lista de objetos de MiModelo
    return jsonResponse.map((data) => datos.fromJson(data)).toList();
  } else {
    // Si la solicitud falla, lanza una excepción
    throw Exception('Error al cargar los datos desde la API');
  }
}

class PaginaTemasInteres extends StatefulWidget {
  const PaginaTemasInteres({super.key});

  @override
  _PaginaTemasInteresState createState() => _PaginaTemasInteresState();
}

class _PaginaTemasInteresState extends State<PaginaTemasInteres> {
  List<bool> selectedTopics = [false, false, false, false];
  bool isTopicsSelected = false;
  bool isLevelSelectionVisible = false;
  int selectedLevel = -1;
  fetchDatosDeApi() {
    // TODO: implement fetchDatosDeApi
    throw UnimplementedError();
  }

  String titulo = "Temas de Interés";
  String subtitulo = "Selecciona tus temas de interés";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
        backgroundColor: Color.fromARGB(254, 236, 10, 40),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              subtitulo,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
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
                color: Colors.white,
              ),
              padding: EdgeInsets.all(16.0),
              child: isLevelSelectionVisible
                  ? _buildLevelSelection()
                  : _buildTopicsSelection(),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.grey,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: TextStyle(fontSize: 20),
                  ),
                  child: Text('Omitir'),
                ),
                ElevatedButton(
                  onPressed: isTopicsSelected
                      ? () {
                          setState(() {
                            isLevelSelectionVisible = true;
                            titulo = "Nivel del reto";
                            subtitulo = "¿En que nivel crees estar?";
                            cambio = cambio + 1;
                            if (cambio > 1) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PaginaConFondo()),
                              );
                            }
                          });
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromARGB(254, 236, 10, 40),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: TextStyle(fontSize: 20),
                  ),
                  child: Text('Enviar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopicsSelection() {
    return Column(
      children: [
        CheckboxListTile(
          title: Text('Tema 1'),
          value: selectedTopics[0],
          onChanged: (bool? value) {
            setState(() {
              selectedTopics[0] = value ?? false;
              _updateTopicsSelection();
            });
          },
        ),
        CheckboxListTile(
          title: Text('Tema 2'),
          value: selectedTopics[1],
          onChanged: (bool? value) {
            setState(() {
              selectedTopics[1] = value ?? false;
              _updateTopicsSelection();
            });
          },
        ),
        CheckboxListTile(
          title: Text('Tema 3'),
          value: selectedTopics[2],
          onChanged: (bool? value) {
            setState(() {
              selectedTopics[2] = value ?? false;
              _updateTopicsSelection();
            });
          },
        ),
        CheckboxListTile(
          title: Text('Tema 4'),
          value: selectedTopics[3],
          onChanged: (bool? value) {
            setState(() {
              selectedTopics[3] = value ?? false;
              _updateTopicsSelection();
            });
          },
        ),
      ],
    );
  }

  void _updateTopicsSelection() {
    isTopicsSelected = selectedTopics.any((selected) => selected);
  }

  Widget _buildLevelSelection() {
    return Column(
      children: [
        RadioListTile<int>(
          title: Text('Principiante',
              style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(
              "Está aprendiendo las bases de la gestión financiera, como elaborar un presupuesto, ahorrar y entender productos financieros básicos."),
          value: 0,
          groupValue: selectedLevel,
          onChanged: (int? value) {
            setState(() {
              selectedLevel = value ?? -1;
            });
          },
        ),
        RadioListTile<int>(
          title: Text(
            'Intermedio',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
              "Maneja sus finanzas con cierta soltura, utiliza herramientas como el crédito de forma responsable y busca formas de hacer crecer su dinero."),
          value: 1,
          groupValue: selectedLevel,
          onChanged: (int? value) {
            setState(() {
              selectedLevel = value ?? -1;
            });
          },
        ),
        RadioListTile<int>(
          title: Text('Experto', style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(
              "Tiene un conocimiento profundo del sistema financiero, invierte con estrategia y planifica su futuro financiero con seguridad."),
          value: 2,
          groupValue: selectedLevel,
          onChanged: (int? value) {
            setState(() {
              selectedLevel = value ?? -1;
            });
          },
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
