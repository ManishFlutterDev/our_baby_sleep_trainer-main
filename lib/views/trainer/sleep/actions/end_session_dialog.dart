import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectionButton extends StatelessWidget {
  final String label;
  final Function onTap;

  SelectionButton({@required this.label, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/dialon_btn.png"))
        ),
        width: MediaQuery.of(context).size.width,
        height: 48,
        child: Center(
          child: Text(
            label,
            style:  GoogleFonts.inter(fontWeight: FontWeight.w700,fontSize: 20),
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}

class DynamicDialog extends StatefulWidget {
  final Function endSession;
  final bool unsuccessful;

  DynamicDialog({
    @required this.endSession,
    this.unsuccessful,
  });

  @override
  State<StatefulWidget> createState() {
    return _DynamicDialogState();
  }
}

class _DynamicDialogState extends State<DynamicDialog> {
  bool _unsuccessful = false;

  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _unsuccessful = widget.unsuccessful ?? false;
  }

  void _submit() {
    Navigator.pop(context, true);
    widget.endSession(
      null,
      'Unsuccessful',
      _textController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_unsuccessful) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Material(
          //   child: SizedBox(
          //     width: MediaQuery.of(context).size.width,
          //     child: TextField(
          //       minLines: 2,
          //       maxLines: 2,
          //       autofocus: true,
          //       controller: _textController,
          //       decoration: InputDecoration(
          //         hintText: 'Add a note (optional)',
          //         border: OutlineInputBorder(),
          //         label: Text("test")
          //       ),
          //       onSubmitted: (_) => _submit,
          //     ),
          //   ),
          // ),
          Material(
            child: Container(

              width: 300,
              height: 249,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/edibox.png"),fit: BoxFit.fill)
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 19),
                child: TextField(
                  minLines: 2,
                  maxLines: 19,
                  autofocus: true,
                  controller: _textController,
                  decoration: InputDecoration(
                      hintText: 'Add a note (optional)',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Color(0xFFFFC1C1),fontSize: 20),
                  ),
                  onSubmitted: (_) => _submit,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
             // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                 // color: Theme.of(context).primaryColor,
                  child: Text(
                    'Back',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (widget.unsuccessful == null)
                      setState(() => _unsuccessful = false);
                    else
                      Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 12),
                TextButton(
                  //color: Theme.of(context).primaryColor,
                  child: Text(
                    'Submit',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () => _submit(),
                ),
              ],
            ),
          ),
        ],
      );
    } else
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SelectionButton(
            label: 'Done Sleeping',
            onTap: () async {
              Navigator.pop(context, true);
              await widget.endSession();
            },
          ),

          SizedBox(height: 5,),

          SelectionButton(
            label: 'Unsuccessful',
            onTap: () => setState(() => _unsuccessful = true),
          ),
          SizedBox(height: 5,),

          SelectionButton(
            label: 'Cancel',
            onTap: () => Navigator.pop(context),
          ),


          // SelectionButton(
          //   label: 'Done Sleeping',
          //   onTap: () async {
          //     Navigator.pop(context, true);
          //     await widget.endSession();
          //   },
          // ),
          // Divider(),
          // SelectionButton(
          //   label: 'Unsuccessful',
          //   onTap: () => setState(() => _unsuccessful = true),
          // ),
          // Divider(),
          // SelectionButton(
          //   label: 'Cancel',
          //   onTap: () => Navigator.pop(context),
          // ),
        ],
      );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

class EndSessionDialog extends StatelessWidget {
  final Function endSession;
  final bool unsuccessful;

  EndSessionDialog({
    @required this.endSession,
    this.unsuccessful,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 32,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: DynamicDialog(
            endSession: endSession,
            unsuccessful: unsuccessful,
          ),
        ),
      ),
    );
  }
}
