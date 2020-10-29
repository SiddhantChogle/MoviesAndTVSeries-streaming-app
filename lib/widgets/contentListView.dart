import 'package:flutter/material.dart';

class ContentListView extends StatelessWidget {
  final String title;
  final String imageInitialUrl;
  final List contentList;

  const ContentListView(
      {Key key, this.title, this.imageInitialUrl, this.contentList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 200,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            scrollDirection: Axis.horizontal,
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: contentList.length,
            itemBuilder: (BuildContext context, int index) => Container(
              margin: EdgeInsets.all(6.0),
              width: 140,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      imageInitialUrl + contentList[index]["poster_path"]),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
