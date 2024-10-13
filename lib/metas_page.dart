import 'package:flutter/material.dart';

class MetasPage extends StatefulWidget {
  @override
  _MetasPageState createState() => _MetasPageState();
}

class _MetasPageState extends State<MetasPage> {
  // Lista de metas financieras
  List<String> metasFinancieras = [
    'Ahorrar para el fondo de emergencia',
    'Inversión en fondos indexados',
    'Pagar deudas pendientes',
    'Ahorro para el retiro',
    'Compra de vivienda'
  ];

  // Lista dinámica para almacenar si una meta está completada o no
  List<bool> _completadas = [
    false,
    false,
    false,
    false,
    false
  ]; // Lista inicializada dinámicamente

  // Controlador para manejar la nueva meta ingresada
  final TextEditingController _nuevaMetaController = TextEditingController();

  // Método para agregar una nueva meta
  void _agregarNuevaMeta() {
    String nuevaMeta = _nuevaMetaController.text;
    if (nuevaMeta.isNotEmpty) {
      setState(() {
        metasFinancieras.add(nuevaMeta);
        _completadas
            .add(false); // Añadir el estado "no completada" para la nueva meta
      });
      _nuevaMetaController
          .clear(); // Limpiar el campo después de añadir la meta
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Metas Financieras'),
        backgroundColor:
            const Color.fromARGB(255, 251, 0, 0), // Fondo de la AppBar
      ),
      body: Column(
        children: [
          // Campo para añadir una nueva meta
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nuevaMetaController,
                    decoration: InputDecoration(
                      labelText: 'Nueva meta',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _agregarNuevaMeta,
                  child: Text('Añadir'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[300], // Fondo gris claro
              child: ListView.builder(
                itemCount: metasFinancieras.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.grey[850], // Fondo de cada tarjeta
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(
                        metasFinancieras[index],
                        style: TextStyle(
                          color: Colors.white, // Letras blancas
                          fontSize: 18,
                          decoration: _completadas[index]
                              ? TextDecoration
                                  .lineThrough // Tachado si está completada
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: Checkbox(
                        value: _completadas[index],
                        onChanged: (bool? value) {
                          setState(() {
                            _completadas[index] = value ?? false;
                          });
                        },
                        checkColor: Colors.white,
                        activeColor: Colors.green,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
