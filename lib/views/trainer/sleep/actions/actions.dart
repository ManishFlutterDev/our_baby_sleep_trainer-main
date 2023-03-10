import 'package:baby_sleep_scheduler/global/values.dart';
import 'package:baby_sleep_scheduler/theme/theme.dart';
import 'package:baby_sleep_scheduler/views/trainer/sleep/actions/end_session_dialog.dart';
import 'baby_state_button.dart';
import 'end_session_button.dart';
import 'package:flutter/material.dart';

class SleepActions extends StatelessWidget {
  final Function(States) pause;
  final Function resume, endSession;
  final String mode;
  final bool cryTimeOver;

  SleepActions({
    @required this.pause,
    @required this.resume,
    @required this.endSession,
    @required this.mode,
    @required this.cryTimeOver,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
      child: Column(
       // mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              BabyStateButton(
                label: mode == States.playing.label
                    ? 'Baby Asleep'
                    : mode == States.sleeping.label
                    ? 'Baby Awake'
                    : cryTimeOver
                    ? 'End Training'
                    : 'Baby Awake',
                onTap: () async {
                  mode == States.playing.label
                      ? await resume()
                      : cryTimeOver
                      ? await showDialog(
                    context: context,
                    barrierColor: CustomTheme.nightTheme
                        ? Colors.black87
                        : Colors.white70,
                    builder: (context) => EndSessionDialog(
                      endSession: endSession,
                    ),
                  )
                      : await pause(States.playing);
                },
              ),

            ],
          ),
          SizedBox(height: 4,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              BabyStateButton(
                label: mode == States.crying.label
                    ? cryTimeOver
                        ? 'Checked on baby'
                        : 'Baby Asleep'
                    : 'Baby Crying',
                onTap: () async {
                  mode == States.crying.label
                      ? cryTimeOver
                          ? await pause(States.playing)
                          : await resume()
                      : await pause(States.crying);
                },
              ),
            ],
          ),
          // if (!cryTimeOver || mode != States.crying.label)
          //   EndSessionButton(endSession: endSession, mode: mode),
          if (!cryTimeOver || mode != States.crying.label)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                EndSessionButton(endSession: endSession, mode: mode),
              ],
            ),
        ],
      ),
    );
  }
}
