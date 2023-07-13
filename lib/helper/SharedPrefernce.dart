import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  static String userLoggedInKey = "LOGGEDINKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String ProfileImage = "";
  static String flag = "false";

  // ignore: non_constant_identifier_names
  static Future<bool> SaveUserLoggedInStatus(bool isUserloggedin) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInKey, isUserloggedin);
  }

  static Future<bool> Content(bool flag1) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(flag, flag1);
  }

  static Future<bool> SaveUserphotoStatus(String Photourl) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(ProfileImage, Photourl);
  }

  static Future<bool> SaveUserEmail(String UserEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, UserEmail);
  }

  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }

  static Future<bool?> getContent() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(flag);
  }

  static Future getUseremail() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userEmailKey);
  }

  static Future getUserphoto() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(ProfileImage);
  }
}
