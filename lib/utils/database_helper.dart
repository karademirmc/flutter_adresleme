import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_adresleme/models/adres.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

class DatabaseHelper {
  //sınıfı ve database i singleton yapman gerek veri tabanı lock olmasın
  //veri tutarsızlığın önüne geçmek içinde faydalıdır singleton dizayn pattern
  static DatabaseHelper _databaseHelper;
  static Database _database;

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._internal();
      return _databaseHelper;
    } else {
      return _databaseHelper;
    }
  }

  DatabaseHelper._internal();

  Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await _initializeDatabase();
      return _database;
    } else {
      return _database;
    }
  }

  Future<Database> _initializeDatabase() async {
    var lock = Lock();
    Database _db;
    if (_db == null) {
      await lock.synchronized(() async {
        if (_db == null) {
          var databasesPath = await getDatabasesPath();
          var path = join(databasesPath, "appDB.db");
          print("Oluşcak db nin pathi $path");
          var file = new File(path);

          // check if file exists
          if (!await file.exists()) {
            // Copy from asset
            ByteData data =
                await rootBundle.load(join("assets", "tumAdres.db"));
            List<int> bytes =
                data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
            await new File(path).writeAsBytes(bytes);
          }
          // open the database
          _db = await openDatabase(path);
        }
      });
    }

    return _db;
  }

//
//  Future<List<Map<String, dynamic>>> kategorileriGetir() async {
//    var db = await _getDatabase();
//    var sonuc = await db.query("kategori");
//    return sonuc;
//  }
//  Future<List<Adres>> kategoriListeleriniGetir() async
//  {
//
//    var kategoriListesi = await kategorileriGetir();
//    return kategoriListesi.map((gelenKategoriMap)=> Adres.fromMap(gelenKategoriMap)).toList();
//  }

  Future<List<Adres>> sqlCalistir(String kod) async {
    var db = await _getDatabase();
    String sql = "SELECT * FROM AdresTbl WHERE  idKod like '$kod'";
    List<Adres> adresler;
    await db.rawQuery(sql).then((gelenMap) {
      adresler = gelenMap.map((gelenMap) => Adres.fromMap(gelenMap)).toList();
    });
    return adresler;
  }
}
