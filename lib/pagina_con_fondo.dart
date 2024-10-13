import 'package:flutter/material.dart';
// import 'dart:convert'; // Para convertir JSON
// import 'package:http/http.dart' as http; // Paquete http para solicitudes


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
            side: const BorderSide(color: Colors.red, width: 4), // Borde rojo
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
                Navigator.of(context).pop(); // Cierra la ventana emergente
                Navigator.of(context).pop(); // Hace el pop en la navegación
                //Navigator.of(context).pop();
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
          child: Center(
            child: SizedBox(
              height: 180, // Ajuste de tamaño para centrar verticalmente
              child: ListView.builder(
                scrollDirection: Axis.horizontal, // Desplazamiento horizontal
                itemCount: buttonImages.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20), // Espacio entre botones
                    width: 200, // Cuadrado
                    height: 200, // Cuadrado
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            buttonImages[index]), // Imagen de fondo del botón
                        fit: BoxFit.cover,
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
                              fontSize: 20), // Estilo del texto
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
