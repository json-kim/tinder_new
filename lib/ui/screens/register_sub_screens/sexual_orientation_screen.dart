import 'package:flutter/material.dart';
import 'package:tinder_new/data/model/enum/sexual_orientation.dart';
import 'package:tinder_new/util/constants.dart';

class SexualOrientationScreen extends StatefulWidget {
  final Function(SexualOrientation) onChanged;

  const SexualOrientationScreen({super.key, required this.onChanged});

  @override
  SexualOrientationScreenState createState() => SexualOrientationScreenState();
}

class SexualOrientationScreenState extends State<SexualOrientationScreen> {
  SexualOrientation? sexualOrientation;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My',
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              'Sexual Orientation is',
              style: Theme.of(context).textTheme.headline3,
            ),
          ],
        ),
        Expanded(
          child: Center(
            child: DropdownButton<SexualOrientation?>(
              value: sexualOrientation,
              isExpanded: true,
              hint: const Text('Sexual Orientation'),
              focusColor: kPrimaryColor,
              dropdownColor: kPrimaryColor,
              style: Theme.of(context)
                  .textTheme
                  .button
                  ?.copyWith(color: kSecondaryColor),
              items: SexualOrientation.values
                  .map((e) => DropdownMenuItem<SexualOrientation>(
                      value: e, child: Text(e.toEnString())))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  sexualOrientation = value;
                });

                if (value != null) {
                  widget.onChanged(value);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
