import 'package:flutter/material.dart';
import 'package:flutter_assignment/app/utilities/extra_colors.dart';

class GlobalTextField {
  static view(
          {required TextEditingController controller,
          required String hint,
          TextInputType? inputType,
          String? labelText,
          bool obsecure = false,
          Widget? suffix,
          Widget? prefix,
          TextStyle? labelStyle,
          TextStyle? floatinglabelStyle,
          String? initialValue,
          void Function()? onTap,
          void Function()? onEditingComplete,
          Function(String value)? onChange,
          double height = 55,
          bool enable = true,
          FocusNode? focusNode,
          bool readOnly = false,
          int maxLine = 1}) =>
      Container(
        height: height,
        child: TextFormField(
          keyboardType: inputType ?? TextInputType.text,
          controller: controller,
          obscureText: obsecure,
          initialValue: controller == null ? initialValue : null,
          onChanged: onChange,
          onTap: onTap,
          onEditingComplete: onEditingComplete,
          readOnly: readOnly,
          enabled: enable,
          maxLines: maxLine,
          focusNode: focusNode,
          cursorColor: ExtraColors.PRIMARY_100,
          decoration: InputDecoration(
              fillColor: Color(0xfffbfbfb),
              filled: true,
              suffixIcon: suffix,
              prefixIcon: prefix,
              enabled: true,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              focusedBorder: inputFocusBorderStyle(),
              border: inputBorderStyle(),
              enabledBorder: inputBorderStyle(),
              disabledBorder: inputBorderStyle(),
              hintText: hint,
              labelText: labelText,
              contentPadding: EdgeInsets.all(
                12,
              ),
              suffixIconColor: MaterialStateColor.resolveWith((states) =>
                  states.contains(MaterialState.focused)
                      ? ExtraColors.PRIMARY_100
                      : Colors.grey.shade600),
              prefixIconColor: MaterialStateColor.resolveWith((states) =>
                  states.contains(MaterialState.focused)
                      ? ExtraColors.PRIMARY_100
                      : Colors.grey.shade600),
              hintStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400),
              labelStyle: TextStyle(color: Colors.black),
              floatingLabelStyle: TextStyle(color: ExtraColors.PRIMARY_100)),
        ),
      );

  static inputBorderStyleNormal() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(100),
        borderSide: BorderSide(color: ExtraColors.PRIMARY_100, width: .5),
      );
  static inputFocusBorderStyleNormal() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: Colors.black, width: .25),
      );

  static inputBorderStyle() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: Colors.black, width: .25),
      );
  static inputFocusBorderStyle() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: ExtraColors.PRIMARY_100, width: 1),
      );
}
