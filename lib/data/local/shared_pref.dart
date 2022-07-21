import 'package:shared_preferences/shared_preferences.dart';

Future<String> getId() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString("Id") ?? "";
}

Future<bool> saveId(String name) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setString("Id", name);
}
Future<bool?> getLogin() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getBool("login") != null
      ? preferences.getBool("login")
      : false;
}

Future<bool> saveLogin(bool isLogin) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setBool("login", isLogin);
}
Future<String> getCustomer() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString("customerName") ?? "";
}

Future<bool> saveCustomer(String customerName) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setString("customerName", customerName);
}