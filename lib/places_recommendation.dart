import 'dart:convert';

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
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
            future: pickFile(context),
            builder: (_, AsyncSnapshot snapshot) => Container(
              width: MediaQuery.of(context).size.width,
              height: 400,
              child: Center(
                child: Swiper(
                  curve: Curves.decelerate,
                  itemBuilder: (BuildContext context, int index) => Container(
                    child: Center(
                      child: Column(
                        children: [
                          Image.network(
                            '${snapshot.data[index]['Image']}',
                            width: MediaQuery.of(context).size.width,
                            height: 300,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${snapshot.data[index]['Name']}'),
                          ),
                          FlatButton(
                            child: Container(
                              width: 300,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Check on Google Maps'),
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
                  autoplayDelay: 5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
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
