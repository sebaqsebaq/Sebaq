import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../configrations/app_colors.dart';
import '../configrations/app_constant.dart';

class TextFieldHelper {
  static final TextFieldHelper shared = TextFieldHelper();
  Timer? _debounceTimer;

  TextStyle getTextStyle({double height = 1, double fontSize = 15}) =>
      TextStyle(
        fontSize: fontSize,
        height: height,
        color: Colors.black,
      );



  Widget createSemiSquareGradientField({
    TextInputType keyboardType = TextInputType.text,
    TextEditingController? controller,
    String? errorText,
    String? labelText = '',
    String hintText = '',
    String? textFieldHeader,
    IconData icon = Icons.filter_none,
    String prefixText = '',
    void Function(String)? onChanged,
    void Function(String)? onChangedDelayed,
    void Function()? onTap,
    void Function()? onEditingComplete,
    void Function(String s)? onSubmitted,
    FocusNode? focusNode,
    bool obscureText = false,
    bool enabled = true,
    List<FocusNode>? allFocusNode,
    ImageIcon? prefixIconData,
    ImageIcon? suffixIconData,
    List<TextInputFormatter>? inputFormatters,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Gradient? borderGradientColor,
    Gradient? focusedBorderGradientColor,
    Gradient? iconPrefixGradientColor,
    Gradient? iconSuffixGradientColor,
    InputBorder inputBorder = InputBorder.none,
    void Function()? onGradientPressed,
    TextInputType textInputType = TextInputType.text,
    TextInputAction inputAction = TextInputAction.done,
    required BuildContext context,
    String? hint,
    bool enableSuggestions = false,
    double strokeWidth = 2,
    bool autocorrect = false,
    bool readOnly = false,
    bool isCapitalAll = false,
    TextCapitalization textCapitalization = TextCapitalization.none,
    EdgeInsetsGeometry? contentPadding,
    FloatingLabelBehavior floatingLabelBehavior = FloatingLabelBehavior.auto,
    double height = 1,
    TextStyle? customErrorTextStyle,
    int maxLines = 1,
    TextStyle labelStyle = const TextStyle(),
    TextStyle hintStyle = const TextStyle(),
    double fontSize = 15,
    Color textHeaderColor = AppColors.textFieldHeaderColor,
    Color? filledColor,
    bool showErrorTextBelowField = true,
    TextStyle? style,
    String? Function(String?)? validator,
    BorderRadius? borderRadius,
    String? initialValue,
    bool isRequired = false,
    bool differentFocusedBorderColor = true,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    EdgeInsetsGeometry? suffixIconPadding,
    bool showTextFieldHeader = true,
  }) {
    borderGradientColor ??= const LinearGradient(
        colors: [AppColors.inputBorderColor, AppColors.inputBorderColor]);

    focusedBorderGradientColor ??=
        const LinearGradient(colors: [AppColors.primaryColor]);


    inputFormatters ??= [];

    if (isCapitalAll) {
      inputFormatters.add(UpperCaseTextFormatter());
    }

    contentPadding ??= const EdgeInsets.symmetric(horizontal: 10, vertical: 15);

    return Column(
      mainAxisAlignment: mainAxisAlignment,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showTextFieldHeader)
              getTextFieldHeader(
                  textFieldHeader: textFieldHeader,
                  context: context,
                  textHeaderColor: textHeaderColor,
                  isRequired: isRequired),
            if (showTextFieldHeader) const SizedBox(height: 6),
            SizedBox(
              child: TextFormField(
                initialValue: initialValue,
                validator: validator,
                textCapitalization: textCapitalization,
                autocorrect: autocorrect,
                maxLines: maxLines,
                readOnly: readOnly,
                enableSuggestions: enableSuggestions,
                cursorColor: Theme.of(context).primaryColor,
                keyboardType: keyboardType,
                textInputAction: inputAction,
                controller: controller,
                autofocus: false,
                focusNode: focusNode,
                onChanged: (value) {
                  onChanged?.call(value);
                  if (_debounceTimer?.isActive ?? false) {
                    _debounceTimer?.cancel();
                  }

                  _debounceTimer = Timer(const Duration(milliseconds: 500), () {
                    onChangedDelayed?.call(value);
                  });
                },
                enabled: enabled,
                onFieldSubmitted: onSubmitted,
                decoration: InputDecoration(
                  contentPadding: contentPadding,
                  prefixText:  prefixText,
                  hintText: hintText,
                  hintStyle: hintStyle,
                  errorMaxLines: 3,
                  prefixStyle: getTextStyle(),
                    fillColor: filledColor ?? AppColors.textFieldBackgroundColor,
                  errorText: (!showErrorTextBelowField) ? errorText : null,
                  disabledBorder: _getBorder(borderGradientColor, borderRadius),
                  enabledBorder: _getBorder(borderGradientColor, borderRadius),
                  focusedBorder: _getBorder(
                      differentFocusedBorderColor
                          ? focusedBorderGradientColor
                          : borderGradientColor,
                      borderRadius),
                  filled: true,
                  prefixIcon: prefixIcon == null
                      ? null
                      : Padding(
                          padding: const EdgeInsets.all(0),
                          child:  prefixIconData ?? prefixIcon,
                        ),
                  suffixIcon: suffixIcon == null
                      ? null
                      : Padding(
                          padding: suffixIconPadding ?? EdgeInsets.zero,
                          child: iconSuffixGradientColor != null
                              ? suffixIconData ?? suffixIcon
                              : suffixIconData ?? suffixIcon,
                        ),
                  border: _getBorder(borderGradientColor, borderRadius),
                ),
                obscureText: obscureText,
                style:
                    style ?? getTextStyle(height: height, fontSize: fontSize),
                inputFormatters: inputFormatters,
                onTap: () {
                  if (onTap != null) {
                    onTap();
                  }
                },
                onEditingComplete: onEditingComplete,
              ),
            ),
          ],
        ),
        if (showErrorTextBelowField &&
            (errorText != null && errorText.isNotEmpty))
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 0, left: 10, right: 10),
              child: Text(
                errorText,
                style: const TextStyle(color: Colors.blueAccent, fontSize: 11),
              ),
            ),
          ),
      ],
    );
  }

  RichText getTextFieldHeader(
      {String? textFieldHeader,
      required BuildContext context,
      Color textHeaderColor = AppColors.textFieldHeaderColor,
      required bool isRequired}) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: textFieldHeader,
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(color: textHeaderColor),
        ),
        if (isRequired)
          const TextSpan(text: " *", style: TextStyle(color: Colors.red)),
      ]),
    );
  }

  OutlineInputBorder _getBorder(Gradient borderGradientColor,
      [BorderRadius? borderRadius]) {
    return OutlineInputBorder(
        borderRadius: borderRadius ??
            BorderRadius.circular(AppConstants.fieldBorderRadius),
        borderSide: BorderSide(color: borderGradientColor.colors[0]));
  }

}
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
