import 'package:flutter/material.dart';

int _paginaActual = 0;

List<Widget> _paginas = [];
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: PaginaFormulario(),
    );
  }
}

class PaginaFormulario extends StatelessWidget {
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
        )),
        backgroundColor: Color.fromARGB(254, 236, 10, 40),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Texto centrado

            Text(
              '¿Qué problemas financieros tienes?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 20),

            // Contenedor con borde rojo y redondeado

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Color.fromARGB(254, 236, 10, 40), // Borde rojo

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

            // Botones en la parte inferior

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Botón de omitir

                ElevatedButton(
                  onPressed: () {
                    // Navegar a la página con el fondo principal

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PaginaConFondo()),
                    );
                  },
                  child: Text(
                    'Omitir',
                    style: TextStyle(fontSize: 25),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,

                    backgroundColor: Colors.grey, // Color gris para omitir
                  ),
                ),

                // Botón de enviar

                ElevatedButton(
                  onPressed: () {
                    // Navegar a otra página

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaginaTemasInteres()),
                    );
                  },
                  child: Text('Enviar', style: TextStyle(fontSize: 25)),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,

                    backgroundColor: Color.fromARGB(254, 236, 10, 40), // Rojo
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Página nueva a la que se navega al presionar "Enviar

class PaginaTemasInteres extends StatefulWidget {
  @override
  _PaginaTemasInteresState createState() => _PaginaTemasInteresState();
}

class _PaginaTemasInteresState extends State<PaginaTemasInteres> {
  // Variables para los checkboxes
  List<bool> selectedTopics = [false, false, false, false];
  bool isTopicsSelected =
      false; // Para habilitar/deshabilitar el botón "Enviar"
  bool isLevelSelectionVisible =
      false; // Para mostrar el nuevo contenedor de niveles
  int selectedLevel =
      -1; // Para guardar el nivel seleccionado (0: Principiante, 1: Intermedio, 2: Experto)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temas de Interés'),
        backgroundColor: Color.fromARGB(254, 236, 10, 40),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .start, // Cambiado a start para alinear hacia arriba
          children: [
            // Título de la sección
            Text(
              'Selecciona tus temas de interés',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),

            // Contenedor con borde rojo y redondeado
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Color.fromARGB(254, 236, 10, 40), // Borde rojo
                  width: 3,
                ),
                color: Colors.white, // Color de fondo del contenedor
              ),
              padding: EdgeInsets.all(16.0),
              child: isLevelSelectionVisible
                  ? _buildLevelSelection() // Mostrar selección de niveles
                  : _buildTopicsSelection(), // Mostrar selección de temas
            ),
            SizedBox(height: 40),

            // Botones en la parte inferior
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Botón de omitir
                ElevatedButton(
                  onPressed: () {
                    // Acción al presionar omitir
                    Navigator.pop(context); // Volver a la página anterior
                  },
                  child: Text('Omitir'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.grey, // Color gris para omitir
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: TextStyle(fontSize: 20), // Tamaño de texto
                  ),
                ),

                // Botón de enviar
                ElevatedButton(
                  onPressed: isTopicsSelected
                      ? () {
                          setState(() {
                            isLevelSelectionVisible =
                                true; // Mostrar el contenedor de selección de niveles
                          });
                        }
                      : null, // Deshabilitado si no se selecciona ningún tema
                  child: Text('Enviar'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromARGB(254, 236, 10, 40), // Rojo
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: TextStyle(fontSize: 20), // Tamaño de texto
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Método para construir la selección de temas
  Widget _buildTopicsSelection() {
    return Column(
      children: [
        // Checkbox 1
        CheckboxListTile(
          title: Text('Tema 1'),
          value: selectedTopics[0],
          onChanged: (bool? value) {
            setState(() {
              selectedTopics[0] = value ?? false;
              _updateTopicsSelection(); // Actualiza si hay selección
            });
          },
        ),
        // Checkbox 2
        CheckboxListTile(
          title: Text('Tema 2'),
          value: selectedTopics[1],
          onChanged: (bool? value) {
            setState(() {
              selectedTopics[1] = value ?? false;
              _updateTopicsSelection(); // Actualiza si hay selección
            });
          },
        ),
        // Checkbox 3
        CheckboxListTile(
          title: Text('Tema 3'),
          value: selectedTopics[2],
          onChanged: (bool? value) {
            setState(() {
              selectedTopics[2] = value ?? false;
              _updateTopicsSelection(); // Actualiza si hay selección
            });
          },
        ),
        // Checkbox 4
        CheckboxListTile(
          title: Text('Tema 4'),
          value: selectedTopics[3],
          onChanged: (bool? value) {
            setState(() {
              selectedTopics[3] = value ?? false;
              _updateTopicsSelection(); // Actualiza si hay selección
            });
          },
        ),
      ],
    );
  }

  // Método para actualizar la selección de temas
  void _updateTopicsSelection() {
    isTopicsSelected = selectedTopics.any(
        (selected) => selected); // Comprueba si hay algún tema seleccionado
  }

  // Método para construir la selección de niveles
  Widget _buildLevelSelection() {
    return Column(
      children: [
        // Radio button de Principiante
        RadioListTile<int>(
          title: Text('Principiante'),
          value: 0,
          groupValue: selectedLevel,
          onChanged: (int? value) {
            setState(() {
              selectedLevel = value ?? -1; // Actualiza el nivel seleccionado
            });
          },
        ),
        // Radio button de Intermedio
        RadioListTile<int>(
          title: Text('Intermedio'),
          value: 1,
          groupValue: selectedLevel,
          onChanged: (int? value) {
            setState(() {
              selectedLevel = value ?? -1; // Actualiza el nivel seleccionado
            });
          },
        ),
        // Radio button de Experto
        RadioListTile<int>(
          title: Text('Experto'),
          value: 2,
          groupValue: selectedLevel,
          onChanged: (int? value) {
            setState(() {
              selectedLevel = value ?? -1; // Actualiza el nivel seleccionado
            });
          },
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

// Página con el fondo principal (la que se muestra al presionar "Omitir")

class PaginaConFondo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {},
        currentIndex: _paginaActual, //necesita un current index
        items: const [
          //una lista de los items que tiene y por lo general se utiliza BottomNavigationBarItem, ahuevo debe tener un label no nulo y un icono si no da error
          BottomNavigationBarItem(
              backgroundColor: Color(0xff5b6670),
              icon: Icon(Icons.add_task),
              label: "RUTA"),
          BottomNavigationBarItem(
              backgroundColor: Color(0xff5b6670),
              icon: Icon(Icons.adjust),
              label: "METAS"),
          BottomNavigationBarItem(
              backgroundColor: Color(0xff5b6670),
              icon: Icon(Icons.zoom_in_sharp),
              label: "DESAFIOS"),
        ],
      ),
      appBar: AppBar(
        title: Center(
          child: Text(
            textAlign: TextAlign.justify,
            'Balam',
            style: TextStyle(color: Colors.white, fontSize: 35),
          ),
        ),
        backgroundColor: Color.fromARGB(254, 236, 10, 40),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image:
                  AssetImage('assets/fondoPrincipal.jpeg'), // Fondo principal
              fit: BoxFit.cover,
            ),
          ),
          // child: Center(
          // ),
        ),
      ),
    );
  }
}
