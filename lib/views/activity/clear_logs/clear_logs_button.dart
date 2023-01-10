import 'package:baby_sleep_scheduler/global/values.dart';
import 'package:baby_sleep_scheduler/theme/theme.dart';
import 'package:baby_sleep_scheduler/views/activity/clear_logs/clear_logs_dialog.dart';
import 'package:flutter/material.dart';

class ClearLogsButton extends StatelessWidget {
  final Function refresh;

  ClearLogsButton({@required this.refresh});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/delete_black_btn.png"))
          ),
          width: MediaQuery.of(context).size.width,
          height: 48,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  'Clear training activity',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white
                  ),
                ),
                const Icon(Icons.delete,color: Colors.white,),
              ],
            ),
          ),
        ),
        onTap: Values.sessionActive
            ? () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                elevation: 0,
                margin: const EdgeInsets.all(8),
                behavior: SnackBarBehavior.floating,
                content: Text(
                  'Can\'t clear logs while a session is in progress.',
                )))
            : () async {
                final bool delete = await showDialog(
                  context: context,
                  barrierColor: CustomTheme.nightTheme
                      ? Colors.black87
                      : Colors.white.withOpacity(0.87),
                  builder: (context) => ClearLogsDialog(),
                );
                if (delete != null && delete) refresh();
              },
      ),
    );
  }
}
