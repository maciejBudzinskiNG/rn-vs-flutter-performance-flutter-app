import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter_app/list.dart';
import 'package:flutter_app/helpers.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  List data;

  loadJsonData() async {
    var jsonText = await rootBundle.loadString(('data/shows.json'));
    setState(() {
      data = json.decode(jsonText);
    });
  }

  @override
  void initState() {
    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));

    this.loadJsonData();

    super.initState();
  }

  shuffleCards() {
    setState(() {
      data = shuffle(data);
    });
  }

  sortCards() {
    setState(() {
      data = sort(data);
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    animationController.repeat();

    return Scaffold(
        body: SafeArea(
            child: Column(children: <Widget>[
      Expanded(child: Episodes(data, animationController)),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
              child: RaisedButton(
            onPressed: () {
              shuffleCards();
            },
            child: Text('Shuffle'),
          )),
          Expanded(
              child: RaisedButton(
            onPressed: () {
              sortCards();
            },
            child: Text('Sort'),
          )),
        ],
      )
    ])));
  }
}
