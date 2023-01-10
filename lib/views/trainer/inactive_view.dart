import 'package:baby_sleep_scheduler/global/values.dart';
import 'package:baby_sleep_scheduler/logic/cache/prefs.dart';
import 'package:flutter/material.dart';
import 'package:baby_sleep_scheduler/logic/cache/db.dart';
import 'package:google_fonts/google_fonts.dart';

class InactiveView extends StatefulWidget {
  final Function startSleepMode;

  InactiveView(Key key, {@required this.startSleepMode}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _InactiveViewState();
  }
}

class _InactiveViewState extends State<InactiveView> {
  // Whether the user had gone through at least one session
  final bool _trainingStarted = Values.trainingStarted;

  // Current training day
  int _cachedDay = Values.currentDay;

  // Training logs
  List<Map> _logs;

  // Highest sleep session day
  int _lastRecordedDay = 0;
  Future<void> _getLastRecordedDay() async {
    _logs = await DB.db
        .rawQuery('SELECT * FROM Logs WHERE type IS NOT NULL ORDER BY id DESC');

    for (var log in _logs)
      if (log['day'] > _lastRecordedDay) _lastRecordedDay = log['day'];
  }

  @override
  void initState() {
    super.initState();
    _getLastRecordedDay().whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Image.asset('assets/images/curve_background.png'),
          Positioned(
            top: 50 + MediaQuery.of(context).padding.top,
            left: 16,
            right: 16,
            child: Column(
              //mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('FERBER',style: GoogleFonts.inter(color: Colors.black,fontSize: 30,letterSpacing: 10),),
                Text(
                  'SLEEP TRAINER',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(color: Colors.black,fontSize: 30,fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text('Help your baby learn to sleep better!',
                    style: GoogleFonts.lato(fontSize: 13,color: Colors.black,fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_trainingStarted != null)
                    IconButton(
                      icon: Icon(Icons.arrow_left),
                      onPressed: _cachedDay - 1 >= 0
                          ? () async {
                        await Prefs.instance
                            .setInt(Cached.day.label, _cachedDay - 1);
                        setState(() => _cachedDay--);
                      }
                          : null,
                    ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20),
                  //   child: Text(
                  //     _cachedDay == null ? 'Day 1' : 'Day ${_cachedDay + 1}',
                  //     style: const TextStyle(
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 26,
                  //     ),
                  //   ),
                  // ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/images/Group_day.png"))
                      ),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _cachedDay == null ? ' 1' : ' ${_cachedDay + 1}',
                              style:GoogleFonts.inter(fontSize: 25,color: Color(0xFFFFFFFF),fontWeight: FontWeight.w900),
                            ),
                            Text(
                              "Day",
                              style:GoogleFonts.inter(fontSize: 25,color: Color(0xFFFFFFFF),fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (_trainingStarted != null)
                    IconButton(
                      icon: Icon(Icons.arrow_right),
                      onPressed: _cachedDay + 1 <= _lastRecordedDay + 1
                          ? () async {
                        await Prefs.instance
                            .setInt(Cached.day.label, _cachedDay + 1);
                        setState(() => _cachedDay++);
                      }
                          : null,
                    ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 16,
            bottom: 16,
            right: 16,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                 Padding(
                  padding: EdgeInsets.only(bottom: 14),
                  child: Text(
                    'Baby Sleep Trainer is a mobile app that helps parents',
                    textAlign: TextAlign.center,
                    style:  GoogleFonts.lato(fontSize: 18,color: Color(0xFF000000),fontWeight: FontWeight.w500),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 48,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/images/placed_btn.png"))
                    ),
                    child:  Center(
                      child: Text(
                        'Placed Baby in Bed',
                        style:GoogleFonts.inter(fontSize: 20,color: Color(0xFFFFFFFF),fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                  onTap: () async {
                    // Check for previous training activity and insert a starting date if necessary
                    if (_trainingStarted == null)
                      await Values.setTrainingStarted();

                    if (_cachedDay == null) await Values.setDay(0);

                    // Get this day's total awake time
                    int _awakeTimeToday = 0;

                    if (_logs.isNotEmpty &&
                        _logs.first['day'] == Values.currentDay) {
                      for (var i = 0; i < _logs.length; i++) {
                        if (_logs[i]['day'] == Values.currentDay &&
                            _logs[i]['awakeTime'] > _awakeTimeToday)
                          _awakeTimeToday = _logs[i]['awakeTime'];
                        else
                          break;
                      }
                    }

                    await Prefs.instance
                        .setInt(Cached.awakeTime.label, _awakeTimeToday);

                    // Record day data to and get the entry ID from SQL DB.
                    final int id =
                    await DB.db.insert('Logs', {'day': Values.currentDay});

                    // Record SQL DB ID to cache
                    await Values.setTrainingID(id);

                    // Record sleep state to cache
                    await Prefs.instance.setBool(States.sleeping.label, true);

                    // Record sleep start time to cache
                    await Prefs.instance.setString(
                      Cached.sleepStarted.label,
                      DateTime.now().toIso8601String(),
                    );

                    // Go to timer view
                    widget.startSleepMode();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
