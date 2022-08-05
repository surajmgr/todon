import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "file1DB.db";
  static final _databaseVersion = 1;
  static final table = 'tb_db';

  static final id = 1;
  static final stCol1 = "stCol1";
  static final stCol2 = "stCol2";

  //Singleton Class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database?> get database async {}
}
