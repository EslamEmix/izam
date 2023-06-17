import 'package:izam_task/helper/keys.dart';
import 'package:izam_task/model/User.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:developer' as developer;

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  factory DatabaseHelper() {
    return _instance ??= DatabaseHelper._();
  }

  DatabaseHelper._();

  Future<Database> get database async {
    return _database ??= await initializeDatabase();
  }

  Future<Database> initializeDatabase() async {
    final String path = join(await getDatabasesPath(), 'login.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE users(${Keys.email} TEXT, ${Keys.password} TEXT, ${Keys.loginCount} INTEGER)',
        );
      },
    );
  }

  Future<int> addUser(User user) async {
    final Database db = await database;
    return await db.insert('users', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<bool> updateUser(User user) async {
    final Database db = await database;
    await db.update('users', user.toMap(),
        where: '${Keys.email} = ?', whereArgs: [user.email]);
    return true;
  }

  Future<User?> getUser(String email, String password) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: '${Keys.email} = ? AND ${Keys.password} = ?',
      whereArgs: [email, password],
    );
    developer.log('getUser $maps');
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<List<User>> getAllUsers() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    developer.log('all users $maps');
    return maps.map((e) => User.fromMap(e)).toList();
  }
}
