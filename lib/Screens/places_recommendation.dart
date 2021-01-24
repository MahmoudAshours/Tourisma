import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlacesRecommendation extends StatefulWidget {
  @override
  _PlacesRecommendationState createState() => _PlacesRecommendationState();
}

class _PlacesRecommendationState extends State<PlacesRecommendation> {
  @override
  Widget build(BuildContext context) {
    pickFile(context);
    return Scaffold(
      backgroundColor: Color(0xff47516C),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.red),
                  ),
                  Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.red),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                  future: pickFile(context),
                  builder: (_, AsyncSnapshot snapshot) => Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Swiper(
                        curve: Curves.decelerate,
                        itemBuilder: (BuildContext context, int index) =>
                            Container(
                          child: Center(
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.network(
                                    '${snapshot.data[index]['Image']}',
                                    height: 300,
                                  ),
                                ),
                                FadeInUp(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${snapshot.data[index]['Name']}',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 21),
                                    ),
                                  ),
                                ),
                                FlatButton(
                                  child: Container(
                                    width: 300,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Check on Google Maps',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 19),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Icon(Icons.map_rounded),
                                        )
                                      ],
                                    ),
                                  ),
                                  onPressed: () => _launchURL(
                                      '${snapshot.data[index]['Longitude']}',
                                      '${snapshot.data[index]['Latitude']}'),
                                )
                              ],
                            ),
                          ),
                        ),
                        itemCount: snapshot.data.length,
                        autoplay: true,
                        duration: 6,
                        itemWidth: 400,
                        fade: 0.3,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getData(index) async {
    Response response;
    Dio dio = Dio();
    response = await dio.get("http://10.0.2.2:5000/api/$index");
    print(response);
  }

  pickFile(context) async {
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/places.json");
    final jsonResult = json.decode(data);
    return jsonResult;
  }

  _launchURL(long, lat) async {
    var uri = Uri.parse("google.navigation:q=$lat,$long&mode=d");
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }
}
