import 'package:flutter/material.dart';

class BabyStateButton extends StatelessWidget {
  final String label;
  final Function onTap;

  BabyStateButton({@required this.label, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/endbtn.png"))
        ),
        // width: MediaQuery.of(context).size.width - 32,
        width: 200,
        height: 48,
        // width: MediaQuery.of(context).size.width,
        // height: 48,
        child: Center(
          child: Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
