
import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // 숫자만 추출
    final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // 하이픈 삽입
    final buffer = StringBuffer();
    for(int i=0; i<digits.length; i++) {
      if(i==3 || i==7) buffer.write('-');
      buffer.write(digits[i]);
    }
    final formatted = buffer.toString();

    // 커서를 맨 끝으로
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length)
    );
  }
}