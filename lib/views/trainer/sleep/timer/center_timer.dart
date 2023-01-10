import 'package:baby_sleep_scheduler/global/values.dart';
import 'package:baby_sleep_scheduler/views/trainer/sleep/bloc/sleep_session.dart';
import 'package:baby_sleep_scheduler/views/trainer/sleep/timer/animated_guide.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'timer.dart';

class CenterTimer extends StatelessWidget {
  final Stream stream;
  final int initial;
  final bool cryTimeOver;

  CenterTimer({
    @required this.stream,
    @required this.initial,
    @required this.cryTimeOver,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/bg_timer.png"))
            ),
              child: Padding(
                padding: EdgeInsets.all(30),
                child: SessionTimer(stream: stream, initial: initial),

              )),
          StreamBuilder(
            stream: SleepSession.stream,
            initialData: SleepSession.data,
            builder: (context, mode) => Text(
              mode.data == States.crying.label
                  ? 'wait for'
                  : mode.data == States.playing.label
                  ? 'awake time'
                  : 'sleep time',
              style: GoogleFonts.inter(color:Color(0xFF666666), fontSize: 22,fontWeight: FontWeight.w900),
            ),
          ),
          if (cryTimeOver) AnimatedGuide(),
        ],
      ),
    );
  }
}
