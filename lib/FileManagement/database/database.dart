import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'Dao/FileCacheDao.dart';
import 'Entity/EFile.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [EFile])
abstract class AppDatabase extends FloorDatabase {
	FileCacheDao get getCache;
}