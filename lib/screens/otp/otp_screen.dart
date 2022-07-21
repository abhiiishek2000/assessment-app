import 'dart:async';
import 'package:assessment_app/component/custom_button.dart';
import 'package:assessment_app/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import '../../data/operation/operations.dart';
import '../../utils/font_styles.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key,required this.phone}) : super(key: key);
  final String phone;

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final interval = const Duration(seconds: 1);
  final int timerMaxSeconds = 60;
  bool isVisibleTime = true;
  int currentSeconds = 0;
  String? otp;
  TextEditingController otpController = TextEditingController();



  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 48),
              const Text(
                'OTP Verification',
                style: titleText,
              ),
              Text.rich(
                  TextSpan(
                      text: 'Enter the OTP sent to',style: subheading,
                      children: <InlineSpan>[
                        TextSpan(
                          text: '  ${widget.phone}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ]
                  )
              ),

              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                child: OTPTextField(
                    length: 4,
                    width: MediaQuery.of(context).size.width,
                    spaceBetween: MediaQuery.of(context).size.width / 20,
                    textFieldAlignment: MainAxisAlignment.start,
                    fieldWidth: MediaQuery.of(context).size.width / 8,
                    fieldStyle: FieldStyle.box,
                    onChanged: (value) {
                      otp = value;
                    },
                    onCompleted: (value) {
                    },
                    style: subheading),
              ),
              isVisibleTime == true
                  ? Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                child:Text.rich(
                    TextSpan(
                        text: 'Resend OTP in   ',style: subheading,
                        children: <InlineSpan>[
                          TextSpan(
                            text: "2 min",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        ]
                    )
                ),
              )
                  : Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8, 16, 0, 0),
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      isVisibleTime = true;
                    });
                  },
                  child: const Text('Resend',
                      style: TextStyle(
                        fontFamily: 'regular',
                        color: Color(0xFF3d55b9),
                        fontSize: 16,
                      )),
                ),
              ),
              const Spacer(),
              isVisibleTime == true
                  ? CustomButton(
                      onPress: () {
                       if(otp=="1234")
                         {
                           Operations().login(widget.phone, context);
                         }else{
                         showSnackBar(context: context, message: "Wrong OTP", isError: true);
                       }
                      },
                      btnTxt: 'Verify',
                    )

                  : Container(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
