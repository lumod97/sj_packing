import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;


class CrearSolicitudDialog extends StatefulWidget {
  final io.Socket socket; // Instancia del socket

  const CrearSolicitudDialog({required this.socket, Key? key}) : super(key: key);

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<CrearSolicitudDialog> {
  String? _selectedLinea;
  String? _selectedFruta;
  String? _selectedVariedad;
  String? _selectedCantidad;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        elevation: 5,
        title: const Text('Nueva solicitud'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              // PRUEBA DE COMBO
              SizedBox(
                child: DropdownButtonFormField<String>(
                  hint: Text('Linea'),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(13),
                      border: OutlineInputBorder()),
                  value: _selectedLinea,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedLinea = newValue!;
                    });
                  },
                  items: <String>[
                    'Linea 1',
                    'Linea 2',
                    'Linea 3',
                    'Linea 4',
                    'Linea 5',
                    'Linea 6'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 5),
              SizedBox(
                child: DropdownButtonFormField<String>(
                  hint: Text('Fruta'),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(13),
                      border: OutlineInputBorder()),
                  value: _selectedFruta,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedFruta = newValue!;
                      _selectedVariedad =
                          null; // Reinicia la variedad al cambiar la fruta
                    });
                  },
                  items: <String>[
                    'Uva',
                    'Caña',
                    'Palta',
                    'Limón',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 5),
              SizedBox(
                child: DropdownButtonFormField<String>(
                  hint: Text('Variedad'),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(13),
                      border: OutlineInputBorder()),
                  value: _selectedVariedad,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedVariedad = newValue!;
                    });
                  },
                  items: (_selectedFruta != null)
                      ? (() {
                          switch (_selectedFruta) {
                            case 'Uva':
                              return <String>[
                                'Ivory',
                                'Red Globe',
                                'Sweet Globe',
                                'Sweet Saphire',
                                'Candy nocq',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList();
                            case 'Caña':
                              return <String>[
                                'Caña 1',
                                'Caña 2',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList();
                            case 'Palta':
                              return <String>[
                                'Palta 1',
                                'Palta 2',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList();
                            case 'Limón':
                              return <String>[
                                'Limón 1',
                                'Limón 2',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList();
                            default:
                              return <String>[
                                'Sin opciones'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList();
                          }
                        })()
                      : <DropdownMenuItem<String>>[],
                ),
              ),
              SizedBox(height: 5),
              // TextField(
              //   decoration: InputDecoration(
              //     label: Text('Cantidad'),
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              TextFormField(
                keyboardType: TextInputType
                    .number, // Define el tipo de teclado como numérico
                decoration: InputDecoration(
                  labelText: 'Número', // Etiqueta del campo
                  border: OutlineInputBorder(), // Borde del campo de entrada
                ),
                onChanged: (value) {
                  // Aquí puedes manejar el cambio en el valor del campo
                  _selectedCantidad = value;
                },
              ),
              // SizedBox(height: 5),
              // TextField(
              //   decoration: InputDecoration(
              //     label: Text('Hora'),
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              // SizedBox(height: 5),
              // TextField(
              //   decoration: InputDecoration(
              //     label: Text('Usuario'),
              //     border: OutlineInputBorder(),
              //   ),
              // ),
            ],
          ),
        ),
        actions: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.blue, // Color de fondo del contenedor
              borderRadius:
                  BorderRadius.circular(23), // Opcional: bordes redondeados
            ),
            child: IconButton(
              onPressed: () {
                // Aquí emites el mensaje al servidor cuando se presiona el botón "Guardar"
                widget.socket.emit('message', 'Hello server!');
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.save_outlined,
                color: Colors.white, // Color del ícono
                size: 35,
              ),
            ),
          )
        ]);
  }
}
