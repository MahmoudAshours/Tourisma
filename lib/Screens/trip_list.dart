import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:places_recommendation/Provider/RatingBloc/rating_bloc.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TripList extends StatefulWidget {
  final uid;

  TripList({Key key, this.uid}) : super(key: key);

  @override
  _TripListState createState() => _TripListState();
}

class _TripListState extends State<TripList> {
  var result;
  var ipaddress = "192.168.1.22";
  Map sd = Map();
  addToMap(_bloc) async {
    Stream<QuerySnapshot> s = _bloc.getUserPlaces(userID: widget.uid);

    for (int i = 0; i < 16; i++) {
      s.forEach(
        (element) {
          return sd.putIfAbsent(
            element.docs[i].id,
            () {
              return element.docs[i].data();
            },
          );
        },
      );
    }
    FormData formData = new FormData();
    Dio().options.headers = {"content-type": 'application/json'};
    formData.fields.add(MapEntry('data', json.encode(sd)));

    try {
      await Dio()
          .post(
            "http://$ipaddress:5000/api",
            data: formData,
            options: Options(
                method: 'POST',
                contentType: 'application/json',
                responseType: ResponseType.json),
          )
          .then((value) => setState(() => result = value.data));
    } catch (e) {
      print('object');
    }
  }

  @override
  Widget build(BuildContext context) {
    print(result);
    final _bloc = Provider.of<PlacesBloc>(context);
    return FadeInUp(
      child: Column(
        children: [
          Text('PortSaid', style: TextStyle(color: Colors.white)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'IP address'),
                onChanged: (value) {
                  setState(() => ipaddress = value);
                },
              ),
            ),
          ),
          GestureDetector(
            onTap: () => addToMap(_bloc),
            child: Container(
              child: Center(
                child: GestureDetector(
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        colors: [
                          Color(0xff7558FF),
                          Color(0xff3396FF),
                          Color(0xff1AB0FF)
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Recommend!',
                        style: TextStyle(fontSize: 21, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          result == null
              ? SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child: Swiper(
                      itemCount: 3,
                      curve: Curves.decelerate,
                      itemBuilder: (BuildContext context, int index) =>
                          Container(
                        child: Center(
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.network(
                                  '${result['$index'][0]['Image']}',
                                  height: 200,
                                ),
                              ),
                              FadeInUp(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '${result['$index'][0]['Name']}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 21),
                                  ),
                                ),
                              ),
                              FlatButton(
                                child: Container(
                                  width: 300,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Check on Google Maps',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 19),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Icon(Icons.map_rounded),
                                      )
                                    ],
                                  ),
                                ),
                                onPressed: () {
                                  _launchURL(
                                      '${result['$index'][0]['Longitude']}',
                                      '${result['$index'][0]['Latitude']}');
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
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
