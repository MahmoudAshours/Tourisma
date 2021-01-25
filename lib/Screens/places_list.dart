import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:places_recommendation/Provider/RatingBloc/rating_bloc.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PlacesList extends StatelessWidget {
  final uid;
  PlacesList(this.uid);
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<PlacesBloc>(context);
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.only(top: 60.0),
        child: FadeInUp(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder(
              stream: _bloc.getUserPlaces(userID: uid),
              builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) => !snapshot
                      .hasData
                  ? SizedBox()
                  : Container(
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
                                  Text(
                                    'Places in Ismailia to rate!',
                                    style: TextStyle(
                                        fontSize: 21, color: Colors.white),
                                  ),
                                  RatingBar.builder(
                                    initialRating: snapshot.data.docs[index]
                                            .data()['Rate'] *
                                        1.0,
                                    minRating: 0,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      _bloc.addUsersRate(
                                          context,
                                          snapshot.data.docs[index].id,
                                          rating,
                                          uid);
                                    },
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.network(
                                      '${snapshot.data.docs[index].data()['Image']}',
                                      height: 300,
                                    ),
                                  ),
                                  FadeInUp(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${snapshot.data.docs[index].id}',
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
                                        '${snapshot.data.docs[index].data()['Longitude']}',
                                        '${snapshot.data.docs[index].data()['Latitude']}'),
                                  )
                                ],
                              ),
                            ),
                          ),
                          itemCount: snapshot.data.docs.length,
                          duration: 6,
                          itemWidth: 400,
                          fade: 0.3,
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
 
  Future pickFile(BuildContext context) async {
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/places.json");
    final jsonResult = json.decode(data);

    return jsonResult;
  }

  Future _launchURL(String long, String lat) async {
    var uri = Uri.parse("google.navigation:q=$lat,$long&mode=d");
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }
}
