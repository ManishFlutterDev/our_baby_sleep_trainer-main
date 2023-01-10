import 'package:baby_sleep_scheduler/global/values.dart';
import 'package:baby_sleep_scheduler/logic/cache/prefs.dart';
import 'package:baby_sleep_scheduler/views/scheduler/by_day_view.dart';
import 'package:baby_sleep_scheduler/views/scheduler/bloc/method_controller.dart';
import 'package:baby_sleep_scheduler/views/scheduler/time_label.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimesModel {
  final int first, second, third, subsequent;

  TimesModel({
    this.first,
    this.second,
    this.third,
    this.subsequent,
  });
}

class MethodOption extends StatelessWidget {
  final String option, label, initial;
  final String description;

  MethodOption({
    @required this.option,
    @required this.label,
    @required this.initial,
    @required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: StreamBuilder(
                stream: MethodController.stream,
                initialData: initial,
                builder: (context, mode) => Row(
                  children: [
                    Text(
                      label + ' ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? 26
                            : 17,
                      ),
                    ),
                    if (mode.data == option)
                      Icon(
                        Icons.check,
                        color: Colors.green,
                        size: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? 24
                            : 20,
                      ),
                  ],
                ),
              ),
            ),
            Text(description, style: const TextStyle(fontSize: 20))
          ],
        ),
      ),
      onTap: () async {
        await Prefs.instance.setString(Cached.sessionType.label, option);
        MethodController.change(option);
        Navigator.pop(context);
      },
    );
  }
}

class Display extends StatefulWidget {
  final String sessionType;
  final List<Map<String, dynamic>> customTimes;

  Display({@required this.sessionType, this.customTimes});

  @override
  State<StatefulWidget> createState() {
    return _DisplayState();
  }
}

class _DisplayState extends State<Display> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: double.infinity,
            height: 5,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/divider.png"),fit: BoxFit.fill)
            ),
          ),
          ByDayView(day: 0, type: widget.sessionType),
          Container(
            width: double.infinity,
            height: 5,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/divider.png"),fit: BoxFit.fill)
            ),
          ),
          ByDayView(day: 1, type: widget.sessionType),
          Container(
            width: double.infinity,
            height: 5,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/divider.png"),fit: BoxFit.fill)
            ),
          ),
          ByDayView(day: 2, type: widget.sessionType),
          Container(
            width: double.infinity,
            height: 5,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/divider.png"),fit: BoxFit.fill)
            ),
          ),
          ByDayView(day: 3, type: widget.sessionType),
          Container(
            width: double.infinity,
            height: 5,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/divider.png"),fit: BoxFit.fill)
            ),
          ),
          ByDayView(day: 4, type: widget.sessionType),
          Container(
            width: double.infinity,
            height: 5,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/divider.png"),fit: BoxFit.fill)
            ),
          ),
          ByDayView(day: 5, type: widget.sessionType),
          Container(
            width: double.infinity,
            height: 5,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/divider.png"),fit: BoxFit.fill)
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: ByDayView(
              day: 6,
              type: widget.sessionType,
            ),
          ),
        ],
      ),
    );
  }
}

class SchedulerView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SchedulerViewState();
  }
}

class _SchedulerViewState extends State<SchedulerView> {
  String _sessionType;
  void _setSessionType() => _sessionType =
      Prefs.instance.getString(Cached.sessionType.label) ?? 'regular';

  @override
  void initState() {
    super.initState();
    MethodController.init();
    _setSessionType();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/bgmain.png"),fit: BoxFit.fill)
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
                16, MediaQuery.of(context).padding.top + 16, 16, 14),
            child: GestureDetector(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(8),
                  // color: Theme.of(context).backgroundColor,
                  // border: Border.all(color: Colors.grey.shade200),
                  image: DecorationImage(image: AssetImage("assets/images/custom_method_btn.png"))
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StreamBuilder(
                        stream: MethodController.stream,
                        initialData: _sessionType,
                        builder: (context, mode) => Text(
                          '${mode.data[0].toUpperCase()}${mode.data.substring(1)} ' +
                              (!mode.data.contains('custom') ? 'Ferber ' : '') +
                              'Method ',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                       Text(
                        'TAP TO CHANGE',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF666666),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              onTap: Prefs.instance.getBool(Cached.paused.label) != null
                  ? () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.all(12),
                      content: Text('Cant edit while session is active')))
                  : () {
                      _setSessionType();
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Theme.of(context).backgroundColor,
                        isScrollControlled: true,
                        builder: (context) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: MethodOption(
                                option: 'regular',
                                initial: _sessionType,
                                label: 'Regular Ferber Method',
                                description: 'Dr. Richad Ferber recommends standard time as a guide',
                              ),
                            ),
                            Divider(height: 0),
                            MethodOption(
                              option: 'mild',
                              initial: _sessionType,
                              label: 'Mild Ferber Method',
                              description:
                                  'Checking on baby earlier for less crying due to reduced check-in times',
                            ),
                            Divider(height: 0),
                            MethodOption(
                              option: 'custom',
                              initial: _sessionType,
                              label: 'Custom Method',
                              description:
                                  'Custom method: Set your own check-in times. Once selected, you can edit any time in the table.',
                            ),
                          ],
                        ),
                      );
                    },
            ),
          ),
          TimeLabel(),
          //Divider(indent: 16, endIndent: 16),
          SizedBox(height: 10,),
          StreamBuilder(
            stream: MethodController.stream,
            initialData: _sessionType,
            builder: (context, mode) => Display(sessionType: mode.data),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    MethodController.dispose();
    super.dispose();
  }
}
