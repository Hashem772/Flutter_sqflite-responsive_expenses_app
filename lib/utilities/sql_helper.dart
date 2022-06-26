import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/transaction.dart';
import 'package:sqflite/sqflite.dart' as sqlflite;
class SQL_Helper {
  static SQL_Helper? dbHelper;
  static sqlflite.Database? _database;

  SQL_Helper._createInstance();

  factory SQL_Helper() {
    if (dbHelper == null) {
      dbHelper = SQL_Helper._createInstance();
    }
    return dbHelper!;
  }

  String tableName = "TBL_EXP";
  String _id = "id";
  String __title = "title";
  String __amount = "amount";
  String __date = "date";

  Future<sqlflite.Database> get database async {
    if (_database == null) {
      _database = await initializedDatabase();
    }
    return _database!;
  }


  Future<sqlflite.Database> initializedDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "expenses.db";
    var expDb = sqlflite.openDatabase(path, version: 1, onCreate: createDatabase);
    return expDb;
  }

  void createDatabase(sqlflite.Database db, int version) async {
    await db.execute(
        '''CREATE TABLE $tableName($_id INTEGER PRIMARY KEY AUTOINCREMENT, $__title TEXT
        ,$__amount DOUBLE, $__date TEXT)''');
  }

  Future<int> insert_exp(Transaction transaction) async {
    sqlflite.Database db = await this.database;
    var result = await db.insert(tableName, transaction.toJson());
    return result;
  }
  Future<List<Transaction>> getData() async {
    sqlflite.Database db = await this.database;
    var result = await db.query(tableName, orderBy: "$_id ASC");
    int count = result.length;
    List<Transaction> transaction = [];
    for (int i = 0; i < count; i++){
      transaction.add(Transaction.fromJson(result[i]));
    }
    return transaction;
  }
  Future<int> update_exp(Transaction transaction) async{
    sqlflite.Database db = await this.database;
    var result = await db.update(tableName, transaction.toJson(), where: "$_id = ?", whereArgs: [transaction.id]);
    return result;
  }

  Future<int> delete_exp(int id) async {
    var db = await this.database;
    int result = await db.rawDelete("DELETE FROM $tableName WHERE $_id = $id");
    return result;
  }
  /*Future<int> delete_exp(int id) async {
    var db = await this.database;
    int result = await db.rawDelete("DELETE FROM $tableName WHERE $_id = $id");
    return result;
  }*/
  }
