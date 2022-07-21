import 'package:assessment_app/data/local/DataBaseProvider.dart';
import 'package:assessment_app/data/operation/provider_operation.dart';
import 'package:assessment_app/screens/placed_order/place_order_screen.dart';
import 'package:assessment_app/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../data/models/cart_model.dart';
import '../../utils/font_styles.dart';
import '../product/component/product_layout.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  OperationProvider? _operationProvider;




  @override
  void initState() {
    _operationProvider = Provider.of<OperationProvider>(context,listen:false);
    _operationProvider?.getCartList();
    _operationProvider?.findTotal();
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
           Text("Cart",style: appbarTextStyle,),
           Text("Retailer Purchase Order",style: subtitle1,)
         ],
       ),
     ),
      body: Consumer<OperationProvider>(
        builder: (context,provider,child){
          return Column(
            children: [
              Expanded(
                child: Container(
                  child: provider.cart?.length ==0 ?Center(child: Text("Cart is Empty",style: subtitle,)):
                  ListView.builder(
                      itemCount: provider.cart?.length,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      itemBuilder: (context, index) {
                        Cart? details = provider.cart?[index];
                        return ProductLayout(productName: '${details?.prodName}',productId:'${details?.prodId}',productImage: '${details?.prodImage}',productPrice: '${details?.prodPrice}',quantity:'${details?.quantity}' ,);
                      }),
                ),
              ),
            ],
          );
        },
      ),
        bottomNavigationBar: Consumer<OperationProvider>(
          builder: (context,provider,child){
            return Container(
              height: 54,
              color: Colors.black87,
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${provider.cart?.length} Items | ₹ ${provider.cart?.length==0? "0": provider.total}",style: subtitle4,),
                          Text("VIEW DETAILS BILL",style: subtitle1,)
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: (){
                       if(provider.cart?.length ==0)
                         {
                           showSnackBar(context: context, message: "Cart is Empty", isError: true);
                         }else {
                         provider.cart?.forEach((element) {
                           provider.placedOrder("${element.prodId}");
                         });
                         Navigator.of(context).push(
                           PageRouteBuilder(
                             opaque: false, // set to false
                             pageBuilder: (_, __, ___) => PlacedOrderScreen(),
                           ),
                         );
                       }

                      },
                      child: Container(
                        color: kPrimaryColor,
                        child: Center(
                          child: Text("SUBMIT",style: btnTextStyle,),
                        ),
                      ),
                    ),
                  )

                ],
              ),
            );
          },
        ),
    );
  }
}
