import 'package:balam_front/pagina_con_fondo.dart';
import 'package:flutter/material.dart';
// import 'dart:convert'; // Para convertir JSON
// import 'package:http/http.dart' as http; // Paquete http para solicitudes

int cambio = 0;

class PaginaTemasInteres extends StatefulWidget {
  final List<String> subtemas; // Asegúrate de que este sea el tipo correcto
  const PaginaTemasInteres({super.key, required this.subtemas});

  @override
  _PaginaTemasInteresState createState() => _PaginaTemasInteresState();
}

class _PaginaTemasInteresState extends State<PaginaTemasInteres> {
  List<bool> selectedTopics = []; // Inicializar como vacío
  bool isTopicsSelected = false;
  bool isLevelSelectionVisible = false;
  int selectedLevel = -1;

  String titulo = "Temas de Interés";
  String subtitulo = "Selecciona tus temas de interés";

  @override
  void initState() {
    super.initState();
    // Inicializa el estado de los checkboxes según el número de subtemas
    selectedTopics = List<bool>.filled(widget.subtemas.length, false);
  }

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
      children: List.generate(widget.subtemas.length, (index) {
        return CheckboxListTile(
          title: Text(widget.subtemas[index]), // Muestra el subtema
          value: selectedTopics[index],
          onChanged: (bool? value) {
            setState(() {
              selectedTopics[index] = value ?? false;
              _updateTopicsSelection();
            });
          },
        );
      }),
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
              subtitle: Text('Está aprendiendo las bases de la gestión financiera, como elaborar un presupuesto, ahorrar y entender productos financieros básicos.'),
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
          subtitle:Text('Maneja sus finanzas con cierta soltura, utiliza herramientas como el crédito de forma responsable y busca formas de hacer crecer su dinero.'),
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
          subtitle: Text('Tiene un conocimiento profundo del sistema financiero, invierte con estrategia y planifica su futuro financiero con seguridad.'),
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
