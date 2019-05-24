import 'package:flutter/material.dart';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
  // List data;

  @override
  void initState() {
    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));
    super.initState();
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
        body: new Container(
      child: new Center(
          child: new FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString('data/shows.json'),
        builder: (context, snapshot) {
          var data = jsonDecode(snapshot.data.toString());
          return new ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return new Card(
                  child: new Padding(
                      padding: EdgeInsets.all(10.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Text(
                            data[index]["name"],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          new Padding(
                            padding: EdgeInsets.all(15.0),
                            child: new RotationTransition(
                              turns: Tween(begin: 0.0, end: 1.0)
                                  .animate(animationController),
                              child: new Text("S" +
                                  data[index]["season"].toString() +
                                  "E" +
                                  data[index]["number"].toString()),
                            ),
                          ),
                          new Image.network(
                            data[index]['image']['medium'],
                            height: 200,
                            width: 300,
                            fit: BoxFit.cover,
                          )
                        ],
                      )));
            },
            itemCount: data == null ? 0 : data.length,
          );
        },
      )),
    ));
  }
}

class Episode {
  final String id;
  final int season;
  final int number;
  final String imageUrl;

  Episode({this.id, this.season, this.number, this.imageUrl});

  factory Episode.fromJson(Map<String, dynamic> json) {
    return new Episode(
      id: json['id'].toString(),
      season: json['season'],
      number: json['number'],
      imageUrl: json['image'],
    );
  }
}
