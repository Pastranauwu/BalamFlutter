import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LecturaModel {
  final List<String> lecturas;

  LecturaModel({required this.lecturas});

  factory LecturaModel.fromJson(List<dynamic> json) {
    return LecturaModel(
      lecturas: List<String>.from(json.map((x) => x.toString())),
    );
  }
}

// Clase para la página de Lectura
class Lectura extends StatefulWidget {
  final String tema;

  const Lectura({Key? key, required this.tema}) : super(key: key);

  @override
  _LecturaState createState() => _LecturaState();
}

class _LecturaState extends State<Lectura> {
  late Future<LecturaModel> futureLecturas;

  @override
  void initState() {
    super.initState();
    futureLecturas = fetchLecturas(widget.tema);
  }

  Future<LecturaModel> fetchLecturas(String tema) async {
    final response = await http.post(
      Uri.parse(
          'http://172.31.98.222:8000/tips_para_aprender'), // Cambia esto a la URL de tu API
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'pregunta':
            '¿Como puedo ayudarte en este dia?', // Cambia esto según tus necesidades
        'respuesta':
            'Quiero temas referentes a mi educacion financiera', // Cambia esto según tus necesidades
      }),
    );

    final String responseBody = utf8.decode(response.bodyBytes);
    print(responseBody);
    if (response.statusCode == 200) {
      // Si la respuesta es 200, analiza el JSON
      return LecturaModel.fromJson(json.decode(responseBody));
    } else {
      // Si no se pudo hacer la solicitud, lanza una excepción.
      throw Exception('Error al cargar las lecturas');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tema),
      ),
      body: FutureBuilder<LecturaModel>(
        future: futureLecturas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Muestra las lecturas
            return ListView.builder(
              itemCount: snapshot.data!.lecturas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Lectura ${index + 1}'), // Título de la lectura
                  subtitle: Text(snapshot
                      .data!.lecturas[index]), // Contenido de la lectura
                );
              },
            );
          }
        },
      ),
    );
  }
}
