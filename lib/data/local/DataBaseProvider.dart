import 'dart:async';
import 'dart:io';
import 'package:assessment_app/data/local/shared_pref.dart';
import 'package:assessment_app/data/models/cart_model.dart';
import 'package:assessment_app/data/models/product_add.dart';

import 'package:assessment_app/data/models/product_offline.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';



class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 4, onOpen: (db) {},
        onUpgrade: (db, oldVersion, newVersion) async {

        },
        onCreate: (Database db, int version) async {
          // User table
          await db.execute("CREATE TABLE USERS ("
              "id INTEGER PRIMARY KEY,"
              "user_id INTEGER UNIQUE"
              ")");
          //product table
          await db.execute("CREATE TABLE PRODUCTS ("
              "prodImage TEXT,"
              "prodId TEXT,"
              "prodName TEXT,"
              "prodPrice TEXT"
              ")");

          //cart table
          await db.execute("CREATE TABLE CARTS ("
              "prodId TEXT,"
              "quantity TEXT,"
              "user_id INTEGER,"
              "FOREIGN KEY(user_id) REFERENCES USERS(user_id)"
              ")");


        });


  }

// add users
  addUsers(String userId) async {
    final db = await database;
    try{
      var table = await db?.rawQuery("SELECT MAX(id)+1 as id FROM USERS");
      int? id = table!.first["id"] as int?;
      //insert to the table using the new id
      var raw = await db?.rawInsert(
          "INSERT Into USERS (id,user_id)"
              " VALUES (?,?)",
          [id,userId]);
      return raw;
    }catch(e){
      print(e);
    }
  }

// add products

  addProducts({required String prodImage,required String prodId, required String prodName,required String prodPrice }) async {
    final db = await database;
    var raw = await db?.rawInsert(
        "INSERT Into PRODUCTS (prodImage,prodId,prodName,prodPrice)"
            " VALUES (?,?,?,?)",
        [prodImage,prodId,prodName,prodPrice]);
    print(raw);
    return raw;
  }
  //get InitialProduct
  Future<List<AddProduct>> getInitialProduct() async {
    final db = await database;
    var res = await db?.rawQuery(
        "SELECT * from PRODUCTS");
    List<AddProduct> list = res!.isNotEmpty ? res.map((c) => AddProduct.fromMap(c))
        .toList() : [];

    return list;
  }

//get products
  Future<List<Product>> getProduct({required String userID}) async {
    final db = await database;
    var res = await db?.rawQuery(
        "SELECT PRODUCTS.prodImage,PRODUCTS.prodName,PRODUCTS.prodPrice,PRODUCTS.prodId,CARTS.quantity FROM PRODUCTS LEFT JOIN CARTS ON CARTS.prodId = PRODUCTS.prodId AND CARTS.user_id =$userID ");
    List<Product> list = res!.isNotEmpty ? res.map((c) => Product.fromMap(c))
        .toList() : [];

    return list;
  }
  //add to cart
  addToCart({required String prodId,required String userId,required String quantity}) async{
    final db = await database;
    var raw = await db?.rawInsert(
        "INSERT Into CARTS (prodId,user_id,quantity)"
            " VALUES (?,?,?)",
        [prodId,userId,quantity]);
    return raw;
  }

  //cart list
  Future<List<Cart>>getCartList({required String userId}) async {
    final db = await database;
    var res = await db?.rawQuery(
        "SELECT prodImage,prodName,prodPrice,quantity,CARTS.prodId FROM PRODUCTS INNER JOIN CARTS ON CARTS.prodId = PRODUCTS.prodId where CARTS.user_id =$userId and CARTS.quantity >0 " );
    List<Cart> list = res!.isNotEmpty ? res.map((c) => Cart.fromMap(c))
        .toList() : [];
    return list;
  }

  //update quantity
  changeQuantity ({required String userId,required String quantity,required String prodId}) async{
   final db = await database;
   final data = {
     'quantity': quantity
   };
   var raw = await db?.update(
       'CARTS', data, where: "user_id = ? and prodId= ?", whereArgs: [userId,prodId]);
   return raw;
 }
//delete
  deleteQuantity ({required String userId,required String prodId}) async{
    final db = await database;
    var raw = await db?.delete(
        'CARTS', where: "user_id = ? and prodId= ?", whereArgs: [userId,prodId]);
    return raw;
  }

 // placed order

 placedOrder({required String userId,required String prodId}) async{
   final db = await database;
   var raw = await db?.delete(
       'CARTS', where: "user_id = ? and prodId= ?", whereArgs: [userId,prodId]);
   return raw;
 }

//total

Future<double>calTotal({required String userId}) async {
    double total = 0.0;
  final db = await database;
  var res = await db?.rawQuery( "SELECT prodPrice,quantity FROM PRODUCTS INNER JOIN CARTS ON CARTS.prodId = PRODUCTS.prodId where CARTS.user_id =$userId" );
  for(int i=0; i<res!.length;i++){
    total += double.parse("${res[i]['prodPrice']}") * double.parse("${res[i]['quantity']}");
  }
  return total;
}
}

