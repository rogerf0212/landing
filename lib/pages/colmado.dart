class Colmado {
  final String nombre;
  final String cedula;
  final String telefono;
  final String email;
  final String codigoProducto;

  Colmado({
    required this.nombre,
    required this.cedula,
    required this.telefono,
    required this.email,
    required this.codigoProducto,
  });

  // Constructor fromMap para convertir datos de Firestore a objetos Colmado
  Colmado.fromMap(Map<String, dynamic> map)
      : nombre = map['nombre'],
        cedula = map['cedula'],
        telefono = map['telefono'],
        email = map['email'],
        codigoProducto = map['codigoProducto'];

  // Método toMap para convertir objetos Colmado a datos de Firestore
  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'cedula': cedula,
      'telefono': telefono,
      'email': email,
      'codigoProducto': codigoProducto,
    };
  }
}
