import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:video_streaming_app/widgets/widgets.dart';

import 'pages.dart';

class StreamingAppHomePage extends StatefulWidget {
  StreamingAppHomePage({Key key}) : super(key: key);

  @override
  _StreamingAppHomePageState createState() => _StreamingAppHomePageState();
}

class _StreamingAppHomePageState extends State<StreamingAppHomePage> {
  double scrollOffset = 0.0;
  ScrollController scrollController;
  final String imageInitialUrl = "https://image.tmdb.org/t/p/w500/";
  final String trending1 =
      "https://api.themoviedb.org/3/trending/all/day?api_key=856c19aa64378a011d5fddff184c20da";
  final String trending2 =
      "https://api.themoviedb.org/3/trending/all/week?api_key=856c19aa64378a011d5fddff184c20da";
  final String popularMovies =
      "https://api.themoviedb.org/3/discover/movie?api_key=856c19aa64378a011d5fddff184c20da&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1";
  final String popularTVShows =
      "https://api.themoviedb.org/3/discover/tv?api_key=856c19aa64378a011d5fddff184c20da&language=en-US&sort_by=popularity.desc&page=1&timezone=America%2FNew_York&include_null_first_air_dates=false";
  var trendingJsonData1;
  var trendingJsonData2;
  var popularMoviesJsonData;
  var popularTVShowsJsonData;

  @override
  void initState() {
    _fetchData();

    scrollController = new ScrollController()
      ..addListener(() {
        setState(() {
          scrollOffset = scrollController.offset;
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _fetchData() async {
    var trendingResponse1 = await http.get(trending1);
    trendingJsonData1 = jsonDecode(trendingResponse1.body);
    // print(trendingJsonData1["results"][5]["title"]);

    var trendingResponse2 = await http.get(trending2);
    trendingJsonData2 = jsonDecode(trendingResponse2.body);
    // print(trendingJsonData2["results"][1]["title"]);

    var popularMoviesResponse = await http.get(popularMovies);
    popularMoviesJsonData = jsonDecode(popularMoviesResponse.body);
    // print(popularMoviesJsonData["results"][1]["title"]);

    var popularTVShowsResponse = await http.get(popularTVShows);
    popularTVShowsJsonData = jsonDecode(popularTVShowsResponse.body);
    // print(popularTVShowsJsonData["results"][1]["name"]);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    // int carouselIndex = 0;
    return Scaffold(
      drawer: Drawer(),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Image(
          height: 70.0,
          image: AssetImage(
            "lib/assets/images/netflixImage.png",
          ),
        ),
        toolbarHeight: 60,
        centerTitle: true,
        backgroundColor: Colors.black
            .withOpacity((scrollOffset / 230).clamp(0, 1).toDouble()),
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => print("Search"),
          ),
        ],
      ),
      body: (trendingJsonData1 == null ||
              trendingJsonData2 == null ||
              popularMoviesJsonData == null ||
              popularTVShowsJsonData == null)
          ? Center(child: CircularProgressIndicator())
          : CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: screenSize.height * 0.42,
                      viewportFraction: 1.0,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 5),
                      autoPlayCurve: Curves.fastOutSlowIn,
                    ),
                    items: [
                      trendingJsonData1["results"][1],
                      trendingJsonData1["results"][2],
                      trendingJsonData1["results"][3],
                      trendingJsonData1["results"][4],
                      trendingJsonData1["results"][5],
                    ].map(
                      (i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ContentPage(
                                    content: i,
                                  ),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Hero(
                                    tag: imageInitialUrl + i["backdrop_path"],
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          alignment: Alignment.bottomCenter,
                                          fit: BoxFit.cover,
                                          image: NetworkImage(imageInitialUrl +
                                              i["backdrop_path"]),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 30.0, horizontal: 15.0),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                            Colors.transparent,
                                            Colors.transparent,
                                            Colors.black54,
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 30.0,
                                    left: 20.0,
                                    child: Container(
                                      child: i["title"] == null
                                          ? SizedBox()
                                          : Text(
                                              i["title"],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25.0,
                                              ),
                                              overflow: TextOverflow.fade,
                                              maxLines: 1,
                                              softWrap: false,
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ).toList(),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
                  sliver: SliverToBoxAdapter(
                    child: ContentListView(
                      title: "Trending",
                      imageInitialUrl: imageInitialUrl,
                      contentList: trendingJsonData2["results"],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  sliver: SliverToBoxAdapter(
                    child: ContentListView(
                      title: "Movies",
                      imageInitialUrl: imageInitialUrl,
                      contentList: popularMoviesJsonData["results"],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  sliver: SliverToBoxAdapter(
                    child: ContentListView(
                      title: "TV Shows",
                      imageInitialUrl: imageInitialUrl,
                      contentList: popularTVShowsJsonData["results"],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
