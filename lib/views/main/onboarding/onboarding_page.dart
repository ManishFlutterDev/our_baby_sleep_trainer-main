import 'package:baby_sleep_scheduler/views/main/onboarding/bloc/color_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingPage extends StatelessWidget {
   var img;
  final String text;
  final String subtext;

  OnboardingPage({@required this.img, @required this.text,this.subtext});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/bgmain.png"),fit: BoxFit.cover)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 16),
          //   child: StreamBuilder(
          //     stream: ColorController.stream,
          //     initialData: Theme.of(context).primaryColor,
          //     builder: (context, color) => Icon(
          //       icon,
          //       color: color.data,
          //       size: MediaQuery.of(context).size.width * 0.6,
          //     ),
          //   ),
          // ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style:  GoogleFonts.lato(fontSize: 20,color: Color(0xFFD40000),fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4,),
                Text(
                  subtext,
                  textAlign: TextAlign.center,
                  style:  GoogleFonts.lato(fontSize: 20,color: Color(0xFF000000),fontWeight: FontWeight.bold),
                ),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 108),
            child: Image.asset(img,width: 222,height: 222,),
          ),
        ],
      ),
    );
  }
}
