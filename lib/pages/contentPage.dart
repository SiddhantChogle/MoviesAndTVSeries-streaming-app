import 'package:flutter/material.dart';
import 'package:video_streaming_app/widgets/widgets.dart';

import 'package:video_streaming_app/repository/repository.dart';

class ContentPage extends StatefulWidget {
  final content;
  final String imageInitialUrl = "https://image.tmdb.org/t/p/w500/";

  ContentPage({this.content});

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    // print(widget.content);
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Container(
        transform: Matrix4.translationValues(0.0, -25.0, 0.0),
        child: ListView(
          children: [
            Stack(
              children: [
                Container(
                  transform: Matrix4.translationValues(0, -30, 0),
                  child: Hero(
                    tag: widget.imageInitialUrl +
                        widget.content["backdrop_path"],
                    child: ClipShadowPath(
                      clipper: CircularClipper(),
                      shadow: Shadow(blurRadius: 20.0),
                      child: Image(
                        height: screenSize.height * 0.5,
                        image: NetworkImage(
                          widget.imageInitialUrl +
                              widget.content["backdrop_path"],
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                      iconSize: 30.0,
                      color: Colors.white,
                    ),
                    Image(
                      image: AssetImage('lib/assets/images/netflixImage.png'),
                      height: 70.0,
                    ),
                    IconButton(
                      icon: Icon(Icons.favorite_border),
                      onPressed: () => print('Add to Favorite'),
                      iconSize: 30.0,
                      color: Colors.white,
                    ),
                  ],
                ),
                Positioned.fill(
                  bottom: 2.0,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: MaterialButton(
                      onPressed: () => print('Play'),
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.red,
                        size: 40.0,
                      ),
                      color: Colors.white,
                      shape: CircleBorder(),
                      height: 60.0,
                      elevation: 10.0,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -10.0,
                  left: 10.0,
                  child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () => print('Add'),
                    color: Colors.white,
                    iconSize: 30.0,
                  ),
                ),
                Positioned(
                  bottom: -10.0,
                  right: 10.0,
                  child: IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () => print('Share'),
                    color: Colors.white,
                    iconSize: 30.0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Column(
                children: [
                  // widget.content['name'] == null
                  //     ? Text(widget.content['title'])
                  //     : widget.content['name'],
                  Text(
                    widget.content['name'] == null
                        ? widget.content['title']
                        : widget.content['name'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    widget.content['genre_ids']
                        .map((item) => genreList[item])
                        .join(', ')
                        .replaceAll('null, ', ''),
                    // widget.content['genre_ids'].join(' '),
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    widget.content['first_air_date'] == null
                        ? widget.content['release_date'].substring(0, 4)
                        : widget.content['first_air_date'].substring(0, 4),
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '⭐ ⭐ ⭐ ⭐',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    // height: 120.0,
                    child: SingleChildScrollView(
                      child: Text(
                        widget.content['overview'],
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
