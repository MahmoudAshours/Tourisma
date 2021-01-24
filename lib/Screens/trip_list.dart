import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class TripList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Column(
        children: [
          Text('PortSaid', style: TextStyle(color: Colors.white)),
          Container(
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Recommend me!',
                        style: TextStyle(fontSize: 21, color: Colors.white),
                      ),
                    ],
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
