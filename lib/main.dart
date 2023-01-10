import 'package:baby_sleep_scheduler/views/splace_screen.dart';

import 'logic/cache/db.dart';
import 'logic/cache/prefs.dart';
import 'logic/notifications/notifications.dart';
import 'theme/theme.dart';
import 'package:wakelock/wakelock.dart';
import 'package:flutter/material.dart';
import 'global/values.dart' as values;
import 'views/main/main_view.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';


void main() async {
  // Required by framework
  WidgetsFlutterBinding.ensureInitialized();

  // Initialise notification plugin
  //await Notifications.init();

  // Initialise SQLite database used for log storage
  await DB.init();

  // Initialise session / cache storage
  await Prefs.init();

  // Get custom session times
  await values.initSessionTimes();

  /*if (io.Platform.isAndroid) {
    // Initialise background services
    await BackgroundServices.init();
  }*/

  // Set custom theme data
  CustomTheme.init();

  // Apparently shared prefs don't work so this is a fallback
  final List userInfo = await DB.db.rawQuery('SELECT * FROM UserInfo');
  final bool onboarded = userInfo.isNotEmpty;

  runApp(SleepTrainer(onboarded));

  // Keep screen turned on while the user is in the app
  Wakelock.enable();
}

class SleepTrainer extends StatefulWidget {
  final bool onboarded;

  SleepTrainer(this.onboarded);

  @override
  State<SleepTrainer> createState() => _SleepTrainerState();
}

class _SleepTrainerState extends State<SleepTrainer> {


  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    // ignore_for_file: avoid_print
    print('ready in 3...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 2...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 1...');
    await Future.delayed(const Duration(seconds: 1));
    print('go!');
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: CustomTheme.stream,
      builder: (context, nightTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: CustomTheme.themeData,
       //home: MainView(onboarded),
        home: SplaceScreen(onboarded: widget.onboarded),
      ),
    );
  }
}
