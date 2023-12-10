enum SexualOrientation {
  MAN,
  WOMAN,
  BYONDBINARY,
}

extension SexsualEnumExtension on SexualOrientation? {
  String toEnString() {
    switch (this) {
      case SexualOrientation.MAN:
        return 'Man';
      case SexualOrientation.WOMAN:
        return 'Woman';
      case SexualOrientation.BYONDBINARY:
        return 'Beyond Binary';
      default:
        return '';
    }
  }
}

extension SexualStringExtension on String? {
  SexualOrientation toSexualOrientation() {
    return {
          'Man': SexualOrientation.MAN,
          'Woman': SexualOrientation.WOMAN,
          'Beyond Binary': SexualOrientation.BYONDBINARY,
        }[this] ??
        SexualOrientation.BYONDBINARY;
  }
}
