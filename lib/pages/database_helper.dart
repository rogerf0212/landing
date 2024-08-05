import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'colmado.dart'; 

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'colmado.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE colmado(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT,
        cedula TEXT,
        telefono TEXT,
        email TEXT,
        codigoProducto TEXT,
        imagen BLOB
      )
    ''');
  }

  Future<int> insertColmado(Colmado colmado) async {
    Database db = await database;
    return await db.insert('colmado', colmado.toMap());
  }

  Future<List<Colmado>> getColmados() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('colmado');
    return List.generate(maps.length, (i) {
      return Colmado(
        id: maps[i]['id'],
        nombre: maps[i]['nombre'],
        cedula: maps[i]['cedula'],
        telefono: maps[i]['telefono'],
        email: maps[i]['email'],
        codigoProducto: maps[i]['codigoProducto'],
        imagen: maps[i]['imagen'],
      );
    });
  }
}
