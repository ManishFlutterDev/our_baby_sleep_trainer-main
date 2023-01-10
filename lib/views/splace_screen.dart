import 'dart:async';

import 'package:baby_sleep_scheduler/views/main/main_view.dart';
import 'package:flutter/material.dart';


class SplaceScreen extends StatefulWidget {
  final bool onboarded;
   SplaceScreen({Key key,this.onboarded}) : super(key: key);

  @override
  State<SplaceScreen> createState() => _SplaceScreenState();
}

class _SplaceScreenState extends State<SplaceScreen> {

  // final bool onboarded;



  void initState() {
    super.initState();
    Timer(Duration(seconds: 5),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => MainView(widget.onboarded)
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset("assets/images/splacescreenmain.png"),
      ),
    );
  }
}


