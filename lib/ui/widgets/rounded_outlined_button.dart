import 'package:flutter/material.dart';
import 'package:tinder_new/util/constants.dart';

class RoundedOutlinedButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const RoundedOutlinedButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: OutlinedButton(
          //highlightedBorderColor: kAccentColor,
          //borderSide: BorderSide(color: kSecondaryColor, width: 2.0),
          onPressed: () {  },
          child: Text(text, style: Theme.of(context).textTheme.button),
          //shape: RoundedRectangleBorder(
           // borderRadius: BorderRadius.circular(25),
          //),
        ));
  }
}
