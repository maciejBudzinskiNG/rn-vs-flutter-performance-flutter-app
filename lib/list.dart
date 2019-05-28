import 'package:flutter/material.dart';

String placeholderUrl =
    'https://cdn.shopify.com/s/files/1/0533/2089/files/placeholder-images-image_large.png?v=1530129081';

class Episodes extends StatelessWidget {
  final List episodes;
  final AnimationController animationController;
  Episodes(this.episodes, this.animationController);

  Widget _buildItem(BuildContext context, int index) {
    String name = episodes[index]['name'];
    String season = episodes[index]["season"].toString();
    String episode = episodes[index]["number"].toString();
    String imgUrl = episodes[index]["image"] != null
        ? episodes[index]["image"]["medium"]
        : placeholderUrl;

    return Card(
        child: new Padding(
            padding: EdgeInsets.all(10.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Text(
                  '${index + 1}. $name',
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
                    child: new Text('S${season}E$episode'),
                  ),
                ),
                new Image.network(
                  imgUrl,
                  height: 200,
                  width: 300,
                  fit: BoxFit.cover,
                )
              ],
            )));
  }

  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: _buildItem,
        itemCount: episodes == null ? 0 : episodes.length);
  }
}
