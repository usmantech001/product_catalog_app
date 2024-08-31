import 'package:flutter/services.dart';

class CapitalizedFirstLetterFormatter extends TextInputFormatter{
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.text.isNotEmpty){
      String capitalizedText = newValue.text[0].toUpperCase() + newValue.text.substring(1);
      return newValue.copyWith(text: capitalizedText, selection: TextSelection.collapsed(offset: capitalizedText.length));
    }
    return newValue;
  }
  
}