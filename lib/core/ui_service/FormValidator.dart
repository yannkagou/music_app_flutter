import 'package:client/core/constants/constants.dart';
import 'package:client/core/ui_service/ui.dart';
import 'package:flutter/material.dart';

class FormValidator {
  static bool isEmptyFields(List<String> value) {
    if (value.length == 3 &&
        (value[0].isEmpty || value[1].isEmpty || value[2].isEmpty)) {
      // showCustomSnackBar(Texts.ERROR, Texts.ALL_FIELD_REQUIRED);
      const SnackBar(content: Text("Error"));
      return true;
    } else if (value.length == 2 && (value[0].isEmpty || value[1].isEmpty)) {
      // showCustomSnackBar(Texts.ERROR, Texts.ALL_FIELD_REQUIRED);
      const SnackBar(content: Text("Error"));
      return true;
    }
    return false;
  }

  static bool isAllFieldsRequired(List<String> value) {
    for (var i = 0; i < value.length; i++) {
      if (value[i].isEmpty) {
        // showCustomSnackBar(Texts.ERROR, Texts.ALL_FIELD_REQUIRED);
        const SnackBar(content: Text("Error"));
        return true;
      }
    }
    return false;
  }
}
