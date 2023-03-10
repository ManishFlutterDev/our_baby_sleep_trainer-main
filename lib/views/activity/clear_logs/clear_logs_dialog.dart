import 'package:baby_sleep_scheduler/global/values.dart';
import 'package:baby_sleep_scheduler/logic/cache/db.dart';
import 'package:baby_sleep_scheduler/logic/cache/prefs.dart';
import 'package:baby_sleep_scheduler/views/trainer/trainer_view.dart';
import 'package:flutter/material.dart';

class ClearLogsDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ClearLogsDialogState();
  }
}

class _ClearLogsDialogState extends State<ClearLogsDialog> {
  bool _deleting = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _deleting
          ? CircularProgressIndicator()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  // color: Theme.of(context).scaffoldBackgroundColor,
                  image: DecorationImage(image: AssetImage("assets/images/edibox.png"),fit: BoxFit.fill),
                  border: Border.all(color: Theme.of(context).primaryColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          'Delete all recorded activity? This action is irreversible.',style: TextStyle(fontSize: 18)
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                     //       color: Theme.of(context).primaryColor,
                            child: const Text(
                              'Yes',
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () async {
                              setState(() => _deleting = true);
                              for (var key in Prefs.instance.getKeys())
                                if (key != Cached.sessionType.label)
                                  await Prefs.instance.remove(key);
                              await DB.db.rawDelete(
                                'DELETE FROM Logs WHERE type IS NOT NULL',
                              );
                              Navigator.pop(context, true);
                              TrainerView.state.refresh();
                            },
                          ),
                          const SizedBox(width: 12),
                          TextButton(
                          //  color: Theme.of(context).primaryColor,
                            child: const Text(
                              'No',
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () => Navigator.pop(context, false),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
