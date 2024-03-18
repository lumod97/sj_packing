import 'package:flutter/material.dart';
import 'package:sj_packing/main.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:audioplayers/audioplayers.dart';

class SolicitudCard extends StatelessWidget {
  final dynamic numeroLinea;
  final dynamic fruta;
  final dynamic variedad;
  final dynamic cantidad;
  final dynamic hora;
  final dynamic usuario;
  final dynamic estado;

  const SolicitudCard({
    required this.numeroLinea,
    required this.fruta,
    required this.variedad,
    required this.cantidad,
    required this.hora,
    required this.usuario,
    required this.estado,
  });

  // DIALOGO DE DETALLES
  AlertDialog dialogDetails(BuildContext context) {
    return AlertDialog(
      title: Text('Detalles de la solicitud'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Número de Línea: $numeroLinea'),
          Text('Fruta: $fruta'),
          Text('Variedad: $variedad'),
          Text('Cantidad: $cantidad'),
          Text('Hora: $hora'),
          Text('Usuario: $usuario'),
          Text('Estado: $estado'),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cerrar'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.white;
    switch (estado) {
      case 'AP':
        backgroundColor = const Color.fromRGBO(200, 230, 201, 1);
        break;
      case 'PE':
        backgroundColor = const Color.fromRGBO(255, 205, 210, 1);
        break;
    }
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return dialogDetails(context);
          },
        );
      },
      child: Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Container(
          color: backgroundColor,
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Número de Línea: $numeroLinea',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    'Fruta: $fruta',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Variedad: $variedad',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Cantidad: $cantidad',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class SocketIoPage extends StatefulWidget {
  SocketIoPage(List<Map<String, dynamic>> listaSolicitudesGlobal);
  
  @override
  _SocketIoPageState createState() => _SocketIoPageState();
}

class _SocketIoPageState extends State<SocketIoPage> {
  late io.Socket socket;
  List<Map<String, dynamic>> miJson = listaSolicitudesGlobal;

  @override
  void initState() {
    super.initState();

    // CONSUMIMOS EL SOCKET
    final String host = 'https://superb-zigzag-behavior.glitch.me';

    // Establece la conexión con el servidor
    try {
      socket = io.io(host, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false
      });

      socket.onConnect((_) {
        // socket.emit('message', 'Hello server!');
      });

      socket.on('message', (data) {
        // Agregar el elemento recibido a miJson y actualizar la vista
        setState(() {
          miJson.add({
            'numeroLinea': 1,
            'fruta': 'Uva',
            'variedad': 'Red Globe',
            'cantidad': 5,
            'hora': '10:30 AM',
            'usuario': 'Jessica Morocho',
            'estado': 'PE',
          });
          playSound();
        });
      });

      socket.connect();
    } catch (e) {
      print('Error al conectarse al servidor: $e');
    }
  }

  void playSound() async {
    final player = AudioPlayer();
    await player.setSourceAsset('sounds/beep.mp3');
    player.resume();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: miJson.length,
      itemBuilder: (context, index) {
        final solicitud = miJson[index];
        return SolicitudCard(
          numeroLinea: solicitud['numeroLinea'],
          fruta: solicitud['fruta'],
          variedad: solicitud['variedad'],
          cantidad: solicitud['cantidad'],
          hora: solicitud['hora'],
          usuario: solicitud['usuario'],
          estado: solicitud['estado'],
        );
      },
    );
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }
}