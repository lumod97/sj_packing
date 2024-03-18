import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:audioplayers/audioplayers.dart';

import 'widgets/solicitudes/solicitudesWidget.dart';

// INICIALIZAR LISTA DE SOLICITUDES
List<Map<String, dynamic>> listaSolicitudesGlobal = [];

// CONSUMO DE API EN DART
Future<List<dynamic>> fetchSolicitudes() async {
  try {
    final response =
        await http.get(Uri.parse('http://192.168.30.23:8000/api/get-logs'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  } catch (e) {
    print(e);
    throw Exception(e);
  }
}

void main() async {
  // INICIALIZAR SOLICITUDES
  List listaSolicitudes = await fetchSolicitudes();
  for (dynamic element in listaSolicitudes) {
    listaSolicitudesGlobal.add({
      'numeroLinea': element['numeroLinea'],
      'fruta': element['fruta'],
      'variedad': element['variedad'],
      'cantidad': element['cantidad'],
      'hora': element['hora'],
      'usuario': element['usuario'],
      'estado': element['estado'],
    });
  }
  // INICIALIZAR APP
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  TextEditingController numeroLineaController = TextEditingController();
  FocusNode numeroLineaFocusNode = FocusNode();
  TextStyle style = const TextStyle(
      fontSize: 16, // Tamaño de la fuente
      fontWeight: FontWeight.normal, // Peso de la fuente
      color: Colors.black,
      decorationColor: Colors.red
      // Puedes agregar más propiedades según sea necesario
      );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Solicitudes'),
          actions: [
            Center(
              child: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            elevation: 5,
                            title: const Text('Diálogo de ejemplo'),
                            content: const SingleChildScrollView(
                                child: Flexible(
                                    flex: 7,
                                    child: Column(
                                      children: [
                                        // NUMERO DE LINEA
                                        TextField(
                                          decoration: InputDecoration(
                                            hintText: 'Número de linea',
                                            border:
                                                OutlineInputBorder(), // Borde del campo de entrada
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        // FRUTA
                                        TextField(
                                          decoration: InputDecoration(
                                            hintText: 'Fruta',
                                            border:
                                                OutlineInputBorder(), // Borde del campo de entrada
                                          ),
                                        ),
                                        // VARIEDAD
                                        TextField(
                                          decoration: InputDecoration(
                                            hintText: 'Fruta',
                                            border:
                                                OutlineInputBorder(), // Borde del campo de entrada
                                          ),
                                        ),
                                        // CANTIDAD
                                        TextField(
                                          decoration: InputDecoration(
                                            hintText: 'Cantidad',
                                            border:
                                                OutlineInputBorder(), // Borde del campo de entrada
                                          ),
                                        ),
                                        // HORA
                                        TextField(
                                          decoration: InputDecoration(
                                            hintText: 'Hora',
                                            border:
                                                OutlineInputBorder(), // Borde del campo de entrada
                                          ),
                                        ),
                                        // USUARIO
                                        TextField(
                                          decoration: InputDecoration(
                                            hintText: 'Usuario',
                                            border:
                                                OutlineInputBorder(), // Borde del campo de entrada
                                          ),
                                        ),
                                      ],
                                    ))),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cerrar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    // child: Text('Mostrar Diálogo'),
                  );
                },
              ),
            )
          ],
        ),
        body: SocketIoPage(listaSolicitudesGlobal),
      ),
    );
  }
}
