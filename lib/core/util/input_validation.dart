import 'package:moia_services/core/util/regular_expression.dart';

class InputValidation {
  bool required(String str) {
    if (str == null) return false;
    if (str == "") return false;
    return true;
  }

  bool email(String str) {
    RegExp exp = new RegExp(RegularExpression.email);
    Iterable<RegExpMatch> matches = exp.allMatches(str);
    if (matches.length <= 0) return false;
    return true;
  }
}
