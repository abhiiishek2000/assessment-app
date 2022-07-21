
import 'package:assessment_app/constants.dart';
import 'package:assessment_app/screens/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/font_styles.dart';

class PlacedOrderScreen extends StatefulWidget {
  const PlacedOrderScreen({Key? key}) : super(key: key);

  @override
  _PlacedOrderScreenState createState() => _PlacedOrderScreenState();
}

class _PlacedOrderScreenState extends State<PlacedOrderScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
       backgroundColor: Colors.black.withOpacity(0.7),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          height: size.height * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white
          ),
          child: Stack(
            children: [
              // Align(
              //   alignment: Alignment.topCenter,
              //   // child: Container(
              //   //     height: 64,
              //   //     width: 64,
              //   //     decoration: BoxDecoration(
              //   //       color: kPrimaryColor,
              //   //       shape: BoxShape.circle,
              //   //     ),
              //   //     child:Icon(Icons.check,color: Colors.white,)
              //   // ),
              // ),
             Column(
               mainAxisSize: MainAxisSize.max,
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Text("Purchase Order",style: subtitle,),
                 Text("Saved Successfully",style: subheading,),
                 Text("Do you want to check out?",style: subheading,),
                 Row(
                   mainAxisSize: MainAxisSize.max,
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     ElevatedButton(onPressed: ()=>Navigator.pop(context), child: Text("No")),
                     ElevatedButton(onPressed: () async {
                       SharedPreferences prefs = await SharedPreferences
                           .getInstance();
                       prefs.remove('customerName');
                       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
                     }, child: Text("Yes")),

                   ],
                 )
             ],
             )

            ],
          ),

        ),
      ),
    );
  }
}
