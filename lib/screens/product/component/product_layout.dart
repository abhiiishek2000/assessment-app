import 'package:assessment_app/data/operation/provider_operation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../utils/font_styles.dart';
import '../../../utils/snack_bar.dart';

class ProductLayout extends StatefulWidget {
  const ProductLayout({Key? key,required this.productName,required this.productId,required this.productImage,required this.productPrice, this.quantity}) : super(key: key);
  final String productName;
  final String productPrice;
  final String productId;
  final String productImage;
  final String? quantity;


  @override
  _ProductLayoutState createState() => _ProductLayoutState();
}

class _ProductLayoutState extends State<ProductLayout> {
  OperationProvider? _operationProvider;







@override
  void initState() {
   _operationProvider = Provider.of<OperationProvider>(context,listen:false);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(vertical: 10),
      height: size.height*0.18,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.09),
                offset: Offset(0,3),
                blurRadius: 6
            )
          ]
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(widget.productImage,fit: BoxFit.contain,height: size.height*0.1,width: size.width*0.4,)),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.productName,style: semititle,),
                const SizedBox(height: 4),
                const Text("Style ",style: subtitle2,),
                const SizedBox(height: 4),
                Text("₹ ${widget.productPrice}",style: subtitle3,)

              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if(widget.quantity != null && widget.quantity != "0")   Row(
                  children: [
                    InkWell(
                      onTap: (){
                        int.parse("${widget.quantity}") <= 1 ?_operationProvider?.deleteQuantity(widget.productId,context)
                        : _operationProvider?.decreaseQuantity(int.parse("${widget.quantity}"),widget.productId,context);
                      },
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: kPrimaryColor,width: 1)
                        ),
                        child: const Center(
                          child: Icon(Icons.remove),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text("${widget.quantity}",style: semititle,),
                    ),
                    InkWell(
                      onTap: (){
                      _operationProvider?.inCreaseQuantity(int.parse("${widget.quantity}"),widget.productId,context);
                      },
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: kPrimaryColor,
                        ),
                        child: const Center(
                          child: Icon(Icons.add,color: kPrimaryTxtColor,),
                        ),
                      ),
                    ),
                  ],
                )
                else ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            )
                        )
                    ),
                    onPressed: (){
                      _operationProvider?.addToCart(prodId: widget.productId, quantity: "1",context: context);
                    }, child: const Text("ADD",style:subtitle4,))

              ],
            ),
          ),
        ],
      ),
    );
  }
}
