import 'package:flutter/material.dart';
import 'package:richmond_test/controller/value.dart';

import '../controller/quest.dart';

AppBar customAppbar(String title) {
  return AppBar(
    title: Text(title,
        style: const TextStyle(
            color: Colors.white)
    ),
    backgroundColor: Colors.blue.shade500,
  );
}

Text h1(String text) {
  return Text(
    text,
    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
    textAlign: TextAlign.center,
  );
}

Text h2(String text) {
  return Text(
    text,
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    textAlign: TextAlign.center,
  );
}

Padding testCard(List<Widget> content, BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      elevation: 10,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: content,
        ),
      ),
    ),
  );
}

List<RadioListTile> questValues(List<Quest> quests, Value val, State state) {
  List<RadioListTile> list = [];
  for (var element in quests) {
    list.add(
      RadioListTile<int>(
        title: Text(element.text),
        activeColor: Colors.blue.shade500,
        value: element.value,
        groupValue: val.val,
        onChanged: (int? value) {
          if (value != null) {
            state.setState(() {
              val.val = value;
            });
          }
        },
      ),
    );
  }
  return list;
}
