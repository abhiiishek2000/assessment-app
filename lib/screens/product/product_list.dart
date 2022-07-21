import 'package:assessment_app/data/operation/provider_operation.dart';
import 'package:assessment_app/screens/cart/cart_screen.dart';
import 'package:assessment_app/utils/font_styles.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/product_offline.dart';
import 'component/product_layout.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  OperationProvider? _operationProvider;




  @override
  void initState() {
    _operationProvider = Provider.of<OperationProvider>(context,listen: false);
    _operationProvider?.getProduct();
    _operationProvider?.getCartList();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Purchase Order",
              style: appbarTextStyle,
            ),
            Text(
              "Retailer Purchase Order",
              style: subtitle1,
            )
          ],
        ),
        actions: [
          // IconButton(onPressed: () => null, icon: Icon(Icons.search)),
          Consumer<OperationProvider>(builder: (context,provider,child){
            return Badge(
              position: BadgePosition.topEnd(top: 0, end: 3),
              animationDuration: Duration(milliseconds: 300),
              animationType: BadgeAnimationType.slide,
              badgeContent: Text(
                provider.cart==null? "0" : provider.cart!.length.toString(),
                style: TextStyle(color: Colors.white),
              ),
              child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartScreen()))),
            );
    }),
        ],
      ),
      body: Consumer<OperationProvider>(
        builder: (context,provider,child){
          return Column(
            children: [
              Expanded(
                child: Container(
                  child: ListView.builder(
                      itemCount: provider.product?.length,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemBuilder: (context, index) {
                        Product? details = provider.product?[index];
                        return ProductLayout(
                          productName: "${details?.prodName}",
                          productId: "${details?.prodId}",
                          productImage: "${details?.prodImage}",
                          productPrice: "${details?.prodPrice}",
                          quantity: details?.quantity,
                          // quantity: provider.checkProd?.length==0 ? null :details?.prodId == provider.checkProd?[index].prodId ? '${provider.checkProd?[index].quantity}' :null,
                        );
                      }),
                ),
              ),
            ],
          );
        },

      ),
    );
  }
}
