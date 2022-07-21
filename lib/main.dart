import 'package:assessment_app/data/local/shared_pref.dart';
import 'package:assessment_app/data/operation/provider_operation.dart';
import 'package:assessment_app/screens/home/home_screen.dart';
import 'package:assessment_app/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'data/local/DataBaseProvider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider(
      create: (_) => OperationProvider(), child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? checkLogin=false;

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    checkLogin = await getLogin();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Assessment app',
        theme: ThemeData(
            primarySwatch: kPrimaryColor,
            scaffoldBackgroundColor: scaffoldColor),
        home: checkLogin == false ? LoginScreen() : HomeScreen());
  }
}
