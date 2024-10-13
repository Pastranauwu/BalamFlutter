import 'package:balam_front/metas_page.dart';
import 'package:balam_front/pagina_formulario.dart';
import 'package:flutter/material.dart';
import 'lectura.dart'; // Asegúrate de importar la clase Lectura

class PaginaConFondo extends StatefulWidget {
  const PaginaConFondo({super.key});

  @override
  _PaginaConFondoState createState() => _PaginaConFondoState();
}

class _PaginaConFondoState extends State<PaginaConFondo> {
  int _currentIndex = 0; // Índice actual seleccionado

  // Método para mostrar la ventana emergente
  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Evita cerrar la ventana al tocar fuera
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0), // Bordes redondeados
            side: const BorderSide(
                color: Color(0xffeb0029), width: 4), // Borde rojo
          ),
          title: const Center(
            child: Text(
              '¿Desea salir?',
              style: TextStyle(
                  color: Colors.black, fontSize: 30), // Color del texto
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No',
                  style: TextStyle(color: Colors.red)), // Botón No
              onPressed: () {
                Navigator.of(context).pop(); // Cierra la ventana emergente
              },
            ),
            TextButton(
              child: const Text('Sí',
                  style: TextStyle(color: Colors.red)), // Botón Sí
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaginaFormulario(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  // Lista de imágenes para los botones
  final List<String> buttonImages = [
    'assets/temploBoton.png', // Asegúrate de que estas imágenes existan
    'assets/temploBoton.png',
    'assets/temploBoton.png',
    'assets/temploBoton.png',
  ];

  // Lista de temas y subtemas
  final List<Map<String, String>> temas = [
    {'tema': 'Ruta de Aprendizaje', 'subtema': 'Objetivos y estructura'},
    {'tema': 'Metas de Desarrollo', 'subtema': 'A corto y largo plazo'},
    {'tema': 'Desafíos', 'subtema': 'Superación de obstáculos'},
    {'tema': 'Salir', 'subtema': 'Cerrar la aplicación'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffeb0029),
        title: const Center(
          child: Text(
            "BIENVENIDO AL MUNDO DE BALAM",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFFFFFFF), // Fondo blanco
        currentIndex: _currentIndex, // Índice actual
        onTap: (index) {
          setState(() {
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MetasPage(),
                ),
              );
            }
            if (index == 3) {
              _showExitDialog(context); // Muestra la ventana emergente al salir
            } else {
              _currentIndex = index; // Cambia el índice actual
            }
          });
        },
        selectedItemColor:
            const Color(0xFFeb0029), // Color rojo para el ícono seleccionado
        unselectedItemColor:
            Colors.black, // Color negro para íconos no seleccionados
        selectedLabelStyle: const TextStyle(color: Color(0xFFeb0029)),
        unselectedLabelStyle: const TextStyle(color: Colors.black),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_task, size: 35),
            label: "RUTA",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.adjust, size: 35),
            label: "METAS",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.engineering_sharp, size: 35),
            label: "DESAFIOS",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app, size: 35),
            label: "Salir",
          ),
        ],
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/fondoPrincipal.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centra verticalmente
            children: [
              // Contenedor redondeado para "Tema" y "Subtema"
              Container(
                width: 300,
                margin: const EdgeInsets.all(16.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2), // Sombra del contenedor
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      temas[_currentIndex]['tema']!, // Tema basado en el índice
                      style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      temas[_currentIndex]
                          ['subtema']!, // Subtema basado en el índice
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(255, 167, 164, 164)),
                    ),
                  ],
                ),
              ),
              // ListView.builder para los botones
              Expanded(
                child: Center(
                  // Centro de la ListView
                  child: Container(
                    height: 250, // Ajuste de tamaño más pequeño
                    child: ListView.builder(
                      scrollDirection:
                          Axis.horizontal, // Desplazamiento horizontal
                      itemCount: buttonImages.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 30), // Espacio entre botones
                          width: 250, // Tamaño cuadrado
                          height: 250, // Tamaño cuadrado
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(buttonImages[
                                  index]), // Imagen de fondo del botón
                              fit: BoxFit.contain, // Ajuste de la imagen
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(0, 0), // Sombra de los botones
                              ),
                            ],
                          ),
                          child: TextButton(
                            onPressed: () {
                              // Acción al presionar el botón
                              print('Botón ${index + 1} presionado');
                            },
                            child: Center(
                              child: Text(
                                'Tema ${index + 1}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16), // Estilo del texto
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              // Sección de botones que parecen hojas
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Acción al presionar el botón de lectura
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Lectura(tema: 'Lectura ${index + 1}'),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets
                              .zero, // Elimina el padding predeterminado
                          elevation: 0, // Elimina la elevación del botón
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // Bordes redondeados
                          ),
                        ),
                        child: Container(
                          height: 130, 
                          width: 100,// Ajusta la altura según sea necesario
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/lectura.jpeg'), // Cambia la ruta a tu imagen
                              fit: BoxFit
                                  .cover, // Ajusta la imagen para cubrir el botón
                            ),
                            borderRadius:
                                BorderRadius.circular(10), // Bordes redondeados
                          ),
                          alignment:
                              Alignment.topLeft, // Alinea el texto en el centro
                          child: const Text(
                            '  Lectura', // Texto del botón
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),

                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
