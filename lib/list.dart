import 'package:flutter/material.dart';

String placeholderUrl =
    'https://cdn.shopify.com/s/files/1/0533/2089/files/placeholder-images-image_large.png?v=1530129081';

class Episodes extends StatefulWidget {
  final List episodes;
  Episodes(this.episodes);

  @override
  _EpisodesState createState() => _EpisodesState();
}

class _EpisodesState extends State<Episodes>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

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

  Widget _buildItem(BuildContext context, int index) {
    String name = widget.episodes[index]['name'];
    String season = widget.episodes[index]["season"].toString();
    String episode = widget.episodes[index]["number"].toString();
    String imgUrl = widget.episodes[index]["image"] != null
        ? widget.episodes[index]["image"]["medium"]
        : placeholderUrl;

    return Card(
        child: new Padding(
            padding: EdgeInsets.all(6),
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
    animationController.repeat();

    return ListView.builder(
        itemBuilder: _buildItem,
        itemCount: widget.episodes == null ? 0 : widget.episodes.length);
  }
}
