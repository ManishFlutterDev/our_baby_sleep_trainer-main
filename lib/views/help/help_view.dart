import 'package:baby_sleep_scheduler/views/help/alarm_option.dart';
import 'package:baby_sleep_scheduler/views/help/night_theme_option.dart';
import 'package:baby_sleep_scheduler/views/help/q_and_a.dart';
import 'package:baby_sleep_scheduler/views/main/main_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/theme.dart';

class HelpView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HelpViewState();
  }
}

class _HelpViewState extends State<HelpView> {
  Key _key = UniqueKey();


  void _refresh() => setState(() => _key = UniqueKey());

  bool _obscureText = true;
  bool _obscureText2 = true;

  void _togglePasswordView() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _togglePasswordView2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/bgmain.png"),fit: BoxFit.fill)
      ),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
            child: Center(
              child: Text(
                'Settings',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 27,
                ),
              ),
            ),
          ),
          const Divider(height: 0, indent: 16, endIndent: 16),

          // SizedBox(width: double.infinity,
          //   height: 50,
          //   child: Expanded(
          //     child: TabBar(
          //       indicator: BoxDecoration(
          //           borderRadius: BorderRadius.only(
          //               topRight: Radius.circular(5 ),
          //               bottomRight: Radius.circular(5 ),
          //               topLeft: Radius.circular(5 ),
          //               bottomLeft: Radius.circular(5 )),
          //           color: Color(0xff0E9278)),
          //       controller: tabController,
          //       labelColor: Colors.white,
          //       unselectedLabelColor: Colors.black,
          //       labelStyle: GoogleFonts.poppins(
          //           fontSize: 16 ,
          //           fontWeight: FontWeight.w600),
          //       tabs: [
          //         Tab(
          //           text: "POS Login",
          //         ),
          //         Tab(
          //           text: "ERP Login",
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          //
          //
          //
          // NightThemeOption(_refresh),
          AlarmOption(),
          const Divider(height: 0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: SizedBox(
              width: double.infinity,
              height: 64,
              child: Center(
                child: GestureDetector(
                  child: Container(
                    width: 300,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                       image: DecorationImage(image: AssetImage("assets/images/custom_method_btn.png"),fit:  BoxFit.fill)
                    ),
                    child: Center(
                      child: Text(
                        'TUTORIAL',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  onTap: () => MainView.state.displayTutorial(),
                ),
              ),
            ),
          ),
          // const Divider(height: 0),
          // Padding(
          //   padding: const EdgeInsets.only(left: 16, bottom: 16, top: 20),
          //   child: Text(
          //     'FAQ',
          //     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          //   ),
          // ),
          // const Divider(height: 0, indent: 16, endIndent: 16),
          // QandA(_key),

        ],
      ),
    );
  }
}
