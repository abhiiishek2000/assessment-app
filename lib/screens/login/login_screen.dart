import 'package:assessment_app/component/custom_button.dart';
import 'package:assessment_app/screens/home/home_screen.dart';
import 'package:assessment_app/screens/otp/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/operation/provider_operation.dart';
import '../../utils/font_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController mobile = TextEditingController();
  final _formKey = GlobalKey<FormState>();






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Welcome,', style: titleText),
                    Text('Login to Continue...', style: subtitle)
                  ],
                ),
                Form(
                  key: _formKey,
                  child: TextFormField(
                      controller: mobile,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text('Phone Number'),
                        prefix: Text('+91  '),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green,
                              width: 1,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF565656),
                              width: 0.5,
                            )),
                        counterText: "",
                      ),
                      validator: (value)
                      {
                        if(value!.isEmpty || value.length <10)
                          {
                            return "Please Enter Valid Number";
                          }else{
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPScreen(phone: mobile.text)));
                        }
                      },
                      style: subheading),
                ),
                CustomButton(
                    onPress: () {
                      _formKey.currentState?.validate();
                    },
                    btnTxt: 'Send OTP',
                  ),
              ],
            ),
          )),
    );
  }
}
