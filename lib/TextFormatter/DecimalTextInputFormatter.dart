import 'package:flutter/services.dart';
import 'dart:math' as math;

//Author: Ajay Kumar
//https://stackoverflow.com/questions/54454983/allow-only-two-decimal-number-in-flutter-input/54456978
class DecimalTextInputFormatter extends TextInputFormatter {
	DecimalTextInputFormatter({this.decimalRange})
			: assert(decimalRange == null || decimalRange > 0);

	final int decimalRange;

	@override
	TextEditingValue formatEditUpdate(
			TextEditingValue oldValue, // unused.
			TextEditingValue newValue,
			) {
		TextSelection newSelection = newValue.selection;
		String truncated = newValue.text;

		if (decimalRange != null) {
			String value = newValue.text;
			if (value.contains(".") &&
					value.substring(value.indexOf(".") + 1).length > decimalRange) {
				truncated = oldValue.text;
				newSelection = oldValue.selection;
			} else if (value == ".") {
				truncated = "0.";

				newSelection = newValue.selection.copyWith(
					baseOffset: math.min(truncated.length, truncated.length + 1),
					extentOffset: math.min(truncated.length, truncated.length + 1),
				);
			}

			return TextEditingValue(
				text: truncated,
				selection: newSelection,
				composing: TextRange.empty,
			);
		}
		return newValue;
	}
}