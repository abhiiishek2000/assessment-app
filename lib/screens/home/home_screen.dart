import 'package:assessment_app/constants.dart';
import 'package:assessment_app/data/local/shared_pref.dart';
import 'package:assessment_app/data/operation/operations.dart';
import 'package:assessment_app/screens/login/login_screen.dart';
import 'package:assessment_app/screens/product/product_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/font_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading =false;

@override
  void initState() {
    Operations().checkProduct(context);
    init();
    super.initState();
  }

  init() async{
  setState(() {
    isLoading = true;
  });
  String? customer = await getCustomer();
  setState(() {
    isLoading = false;
  });
  if(customer.isNotEmpty) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>ProductListScreen()), (route) => false);
  }
}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title:  Text("Check-in",style: appbarTextStyle,),
        centerTitle: true,
        actions: [
          IconButton(onPressed: ()async{
            setState(() {
              isLoading =true;
            });
           try{
             SharedPreferences prefs = await SharedPreferences
                 .getInstance();
             prefs.remove('login');
             prefs.remove('Id');
             prefs.remove("customerName");
             Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
           }catch(e){
             setState(() {
               isLoading =false;
             });
           }
          }, icon: const Icon(Icons.logout))
        ],
      ),
      body: isLoading ==true ? Center(child: CircularProgressIndicator()) :
      Column(
          children:[
            Expanded(
              child: Container(
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          saveCustomer("Customer ${index+1}");
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>ProductListScreen()), (route) => false);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          height: size.height *0.1,
                          decoration:  BoxDecoration(
                              border: Border(
                                left: BorderSide(color: kPrimaryColor,width: 6),
                              ),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.09),
                                  blurRadius: 6,
                                )
                              ]
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Text("Customer ${index+1}",style: semititle,),
                              ),

                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ]),
    );
  }
}
