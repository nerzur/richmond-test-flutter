import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class sharedPreferences extends StatefulWidget {
  const sharedPreferences({Key? key}) : super(key: key);

  @override
  State<sharedPreferences> createState() => _sharedPreferencesState();
}

class _sharedPreferencesState extends State<sharedPreferences> {
  SharedPreferences? _preferences;
  bool _boolPref = false;
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
