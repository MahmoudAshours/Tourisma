import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:places_recommendation/Provider/RatingBloc/rating_bloc.dart';
import 'package:provider/provider.dart';

class TripList extends StatelessWidget {
  final uid;

  addToMap(_bloc) async {
    Stream<QuerySnapshot> s = _bloc.getUserPlaces(userID: uid);

    for (int i = 0; i < 16; i++) {
      s.forEach(
        (element) => sd.putIfAbsent(
          element.docs[i].id,
          () => element.docs[i].data(),
        ),
      );
    }

    await Dio()
        .post(
          "http://10.0.2.2:5000/api",
          data: sd,
        )
        .then((value) => print(value.data));
  }

  Map sd = Map();
  TripList({Key key, this.uid}) : super(key: key);

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
        ],
      ),
    );
  }
}
