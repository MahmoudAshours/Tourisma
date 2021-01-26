import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:places_recommendation/Provider/RatingBloc/rating_bloc.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class TripList extends StatefulWidget {
  final uid;

  TripList({Key key, this.uid}) : super(key: key);

  @override
  _TripListState createState() => _TripListState();
}

class _TripListState extends State<TripList> {
  var value;
  addToMap(_bloc) async {
    Stream<QuerySnapshot> s = _bloc.getUserPlaces(userID: widget.uid);

    for (int i = 0; i < 16; i++) {
      s.forEach(
        (element) {
          print(element.docs[i].data());
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
            "http://10.0.2.2:5000/api",
            data: formData,
            options: Options(
                method: 'POST',
                contentType: 'application/json',
                responseType: ResponseType.json),
          )
          .then((value) => setState(() => value = value.data));
    } catch (e) {
      print('object');
    } 
    print(value.runtimeType);
  }

  Map sd = Map();

  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<PlacesBloc>(context);
    return FadeInUp(
      child: Column(
        children: [
          Text('PortSaid', style: TextStyle(color: Colors.white)),
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
                        'Recommend me!',
                        style: TextStyle(fontSize: 21, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          value == null
              ? SizedBox()
              : Swiper(
                  itemCount: 3,
                  curve: Curves.decelerate,
                  itemBuilder: (BuildContext context, int index) => Container(
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'Places in Ismailia to rate!',
                            style: TextStyle(fontSize: 21, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
