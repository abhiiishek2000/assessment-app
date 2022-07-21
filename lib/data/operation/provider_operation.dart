import 'package:assessment_app/data/local/shared_pref.dart';
import 'package:assessment_app/data/models/product_offline.dart';
import 'package:assessment_app/utils/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../local/DataBaseProvider.dart';
import '../models/cart_model.dart';

class OperationProvider extends ChangeNotifier {
  List<Product>?  product;
  List<Cart>? cart;
  double total =0.0;
  bool? isLogin=false;


   getLogin() async {
    isLogin = await getLogin();
    notifyListeners();
  }
  void getProduct()async {
    String? userId = await getId();
    product = await DBProvider.db.getProduct(userID: userId);
    notifyListeners();
  }
  void getCartList()async{
    String? userId = await getId();
    cart = await DBProvider.db.getCartList(userId: userId);

    notifyListeners();
  }
  void addToCart({required String prodId,required String quantity,required BuildContext context})async{
      String userId = await getId();
      DBProvider.db.addToCart(prodId: prodId, userId: userId, quantity: quantity);
       getProduct();
       getCartList();
       findTotal();
      showSnackBar(context: context, message: 'Added to Cart', isError: false);
      notifyListeners();
    }
 void inCreaseQuantity(int tempQuantity,String prodId,BuildContext context) async{
   String userId = await getId();
   int quantity=tempQuantity+1;
   DBProvider.db.changeQuantity(userId: userId, quantity: quantity.toString(),prodId: prodId);
   getCartList();
   getProduct();
   findTotal();
   showSnackBar(context: context, message: 'Cart is Updated', isError: false);
   notifyListeners();
 }
  void decreaseQuantity(int tempQuantity,String prodId,BuildContext context) async{
    String userId = await getId();
    int quantity=tempQuantity-1;
    DBProvider.db.changeQuantity(userId: userId, quantity: quantity.toString(),prodId: prodId);
    getCartList();
    getProduct();
    findTotal();
    showSnackBar(context: context, message: 'Cart is Updated', isError: false);
    notifyListeners();
  }
  void deleteQuantity(String prodId,BuildContext context) async{
    String userId = await getId();
    DBProvider.db.deleteQuantity(userId: userId,prodId: prodId);
    getCartList();
    getProduct();
    findTotal();
    showSnackBar(context: context, message: 'Removed', isError: true);
    notifyListeners();
  }
  void placedOrder(String prodId) async{
    String userId = await getId();
    DBProvider.db.placedOrder(userId: userId,prodId: prodId);
    getCartList();
    getProduct();
  }
  void findTotal() async{
    String userId = await getId();
    total= await DBProvider.db.calTotal(userId: userId);
    notifyListeners();
  }

}