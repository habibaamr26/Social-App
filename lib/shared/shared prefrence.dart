

import 'package:shared_preferences/shared_preferences.dart';


class CachHelper{

  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences =await SharedPreferences.getInstance() ;
  }

  static setdata(
  {
    required String key,
    required dynamic value,
}
      )
  {
    if(value is int) {
      sharedPreferences?.setInt(key,value);
    } else if(value is double) {
      sharedPreferences?.setDouble(key,value);
    } else if(value is String) {
      sharedPreferences?.setString(key,value);
    } else if(value is bool) {
      sharedPreferences?.setBool(key,value);
    }
  }


  static Object? getdata ({
    required String key,
})
{
return sharedPreferences?.get(key);
}
}