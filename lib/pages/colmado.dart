import 'dart:typed_data';

class Colmado {
  final int? id;
  final String nombre;
  final String cedula;
  final String telefono;
  final String email;
  final String codigoProducto;
  final Uint8List imagen;

  Colmado({
    this.id,
    required this.nombre,
    required this.cedula,
    required this.telefono,
    required this.email,
    required this.codigoProducto,
    required this.imagen,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'cedula': cedula,
      'telefono': telefono,
      'email': email,
      'codigoProducto': codigoProducto,
      'imagen': imagen,
    };
  }
}
