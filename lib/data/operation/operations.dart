import 'package:assessment_app/data/local/shared_pref.dart';
import 'package:assessment_app/data/models/product_add.dart';
import 'package:assessment_app/data/models/product_offline.dart';
import 'package:assessment_app/data/models/product_response_model.dart';
import 'package:flutter/material.dart';
import '../../screens/home/home_screen.dart';
import '../../utils/snack_bar.dart';
import '../local/DataBaseProvider.dart';
import '../remote/repository.dart';

class Operations{
  void login(String mobile,BuildContext context){
    try {
      DBProvider.db.addUsers(mobile);
      saveLogin(true);
      saveId(mobile);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
      showSnackBar(context: context, message: "Login successfully", isError: false);
    }catch(e){
      print(e);
      showSnackBar(context: context, message: "Something went wrong", isError: true);
    }

  }
  void checkProduct(BuildContext context) async{
    List<AddProduct> product;
    String? userID = await getId();
    product = await DBProvider.db.getInitialProduct();
    if(product.length==0){
      addProduct(context);
    }else{
      null;
    }
  }
  void addProduct(BuildContext context) async{
    List<ProductGetResponseDataProducts?>? products;
    ProductGetResponse  productGetResponse = await Repo().getProductList(context, {});
    if(productGetResponse.status==true){
      products = productGetResponse.data?.products;
      for(int i=0; i<products!.length;i++)
        {
          DBProvider.db.addProducts(prodImage: "${products[i]!.prodImage}", prodId: "${products[i]!.prodId}", prodName: "${products[i]!.prodName}", prodPrice: "${products[i]!.prodPrice}");
        }
    }
  }

}