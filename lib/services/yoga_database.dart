import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:yoga_app/model/yoga_model.dart';

class YogaDatabase {
  static final YogaDatabase instance = YogaDatabase._init();
  static Database? _database;

  YogaDatabase._init();

  // initialize database
  Future<Database> initializeDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: createDB);
  }

  // initialize database end
  // get database
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initializeDB("YogaStpesDB.db");
    return database;
  }

  // get database end
  // create Database
  Future createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    await db.execute('''
       CREATE TABLE BeginnerYoga(
        ${YogaModel.IDName} $idType,
        ${YogaModel.YogaName} $textType,
        ${YogaModel.ImageName} $textType,
        ${YogaModel.SecondsOrNot} $boolType,
       ),
       ''');
  }
// create database end
}