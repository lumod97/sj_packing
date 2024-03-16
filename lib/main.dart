import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Lista de Solicitudes'),
        ),
        body: ListView(
          padding: EdgeInsets.all(10.0),
          children: [
            SolicitudCard(
              numeroLinea: 1,
              fruta: 'Uva',
              variedad: 'Red Globe',
              cantidad: 5,
              hora: '10:30 AM',
              usuario: 'Jessica Morocho',
              estado: 'Pendiente',
            ),
            SolicitudCard(
              numeroLinea: 1,
              fruta: 'Uva',
              variedad: 'Red Globe',
              cantidad: 5,
              hora: '11:45 AM',
              usuario: 'Jessica Morocho',
              estado: 'Pendiente',
            ),
            SolicitudCard(
              numeroLinea: 3,
              fruta: 'Uva',
              variedad: 'Ivory',
              cantidad: 2,
              hora: '12:15 PM',
              usuario: 'Jessica Morocho',
              estado: 'Atendido',
            ),
            SolicitudCard(
              numeroLinea: 1,
              fruta: 'Uva',
              variedad: 'Sweet Globe',
              cantidad: 2,
              hora: '12:15 PM',
              usuario: 'Jessica Morocho',
              estado: 'Atendido',
            ),
            SolicitudCard(
              numeroLinea: 1,
              fruta: 'Uva',
              variedad: 'Red Globe',
              cantidad: 5,
              hora: '10:30 AM',
              usuario: 'Jessica Morocho',
              estado: 'Atendido',
            ),
            SolicitudCard(
              numeroLinea: 1,
              fruta: 'Uva',
              variedad: 'Red Globe',
              cantidad: 5,
              hora: '11:45 AM',
              usuario: 'Jessica Morocho',
              estado: 'Atendido',
            ),
            SolicitudCard(
              numeroLinea: 3,
              fruta: 'Uva',
              variedad: 'Ivory',
              cantidad: 2,
              hora: '12:15 PM',
              usuario: 'Jessica Morocho',
              estado: 'Atendido',
            ),
            SolicitudCard(
              numeroLinea: 1,
              fruta: 'Uva',
              variedad: 'Sweet Globe',
              cantidad: 2,
              hora: '12:15 PM',
              usuario: 'Jessica Morocho',
              estado: 'Atendido',
            ),
          ],
        ),
      ),
    );
  }
}

class SolicitudCard extends StatelessWidget {
  final int numeroLinea;
  final String fruta;
  final String variedad;
  final int cantidad;
  final String hora;
  final String usuario;
  final String estado;

  const SolicitudCard({
    required this.numeroLinea,
    required this.fruta,
    required this.variedad,
    required this.cantidad,
    required this.hora,
    required this.usuario,
    required this.estado,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Número de Línea: $numeroLinea',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'Fruta: $fruta',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 5),
            Text(
              'Variedad: $variedad',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 5),
            Text(
              'Cantidad: $cantidad',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 5),
            Text(
              'Hora: $hora',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 5),
            Text(
              '$usuario',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 5),
            Text(
              '$estado',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
