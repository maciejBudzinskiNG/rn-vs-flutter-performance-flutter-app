import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter_app/list.dart';
import 'package:flutter_app/helpers.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  List data;

  loadJsonData() async {
    var jsonText = await rootBundle.loadString(('data/shows.json'));
    setState(() {
      data = json.decode(jsonText);
    });
  }

  @override
  void initState() {
    this.loadJsonData();

    super.initState();
  }

  handleShuffleButtonPress() {
    setState(() {
      data = shuffle(data);
    });
  }

  handleSortButtonPress() {
    setState(() {
      data = sort(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: <Widget>[
      Expanded(child: Episodes(data)),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
              child: RaisedButton(
            onPressed: () {
              handleShuffleButtonPress();
            },
            child: Text('Shuffle'),
          )),
          Expanded(
              child: RaisedButton(
            onPressed: () {
              handleSortButtonPress();
            },
            child: Text('Sort'),
          )),
        ],
      )
    ])));
  }
}
