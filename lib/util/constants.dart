import 'package:flutter/material.dart';

const kDefaultPadding = EdgeInsets.symmetric(
  vertical: 36.0,
  horizontal: 26.0,
);

const kPrimaryColor = Color(0xFFEB6271);
const kSecondaryColor = Colors.white;
const kAccentColor = Color(0xFFF4C470);

const kColorPrimaryVariant = Color(0xFF424242);

const kBackgroundColor = Color(0xFFEB6271);
const kBackgroundColorInt = 0xFFEB6271;
const kFontFamily = 'Nunito';

const kTextTheme = TextTheme(
  headline1: TextStyle(),
  bodyText1: TextStyle(),
  bodyText2: TextStyle(),
);

const kButtonTheme = ButtonThemeData(
  splashColor: Colors.transparent,
  padding: EdgeInsets.symmetric(vertical: 14),
  buttonColor: Color(0xFFF4C470),
  textTheme: ButtonTextTheme.accent,
  highlightColor: Color.fromRGBO(0, 0, 0, .3),
  focusColor: Color.fromRGBO(0, 0, 0, .3),
);

const Map<int, Color> kThemeMaterialColor = {
  50: Color.fromRGBO(235, 98, 113, .1),
  100: Color.fromRGBO(235, 98, 113, .2),
  200: Color.fromRGBO(235, 98, 113, .3),
  300: Color.fromRGBO(235, 98, 113, .4),
  000: Color.fromRGBO(235, 98, 113, .5),
  500: Color.fromRGBO(235, 98, 113, .6),
  600: Color.fromRGBO(235, 98, 113, .7),
  700: Color.fromRGBO(235, 98, 113, .8),
  800: Color.fromRGBO(235, 98, 113, .9),
  900: Color.fromRGBO(235, 98, 113, 1),
};
