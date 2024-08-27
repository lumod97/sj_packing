import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sj_packing/widgets/dialogs/crearSolicitud.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;


import 'widgets/solicitudes/solicitudesWidget.dart';

// INICIALIZAR LISTA DE SOLICITUDES
List<Map<String, dynamic>> listaSolicitudesGlobal = [];
io.Socket socket = io.io('https://superb-zigzag-behavior.glitch.me');


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
                          return CrearSolicitudDialog(
                              socket: socket); // Pasar el socket aquí
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
