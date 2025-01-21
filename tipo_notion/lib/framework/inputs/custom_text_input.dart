import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/framework/layouts/custom_form_style.dart';

class CustomTextInput extends StatelessWidget {
  final String? hint;
  final String? label;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final TextEditingController? controller;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? contentPadding;
  final bool required;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final String? initialValue;
  final bool readOnly;
  final bool enabled;
  final Widget? icon;
  final Widget? prefix;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final String? suffixText;
  final String? prefixText;
  final TextAlign? textAlign;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final int? minLines;
  final int? maxLines;

  const CustomTextInput({
    super.key,
    this.hint,
    this.label,
    this.onFieldSubmitted,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textCapitalization,
    this.textInputAction,
    this.required = true,
    this.obscureText = false,
    this.padding,
    this.autofocus = false,
    this.initialValue,
    this.readOnly = false,
    this.icon,
    this.prefix,
    this.maxLength,
    this.inputFormatters,
    this.onChanged,
    this.enabled = true,
    this.suffixText,
    this.prefixText,
    this.textAlign,
    this.validator,
    this.onSaved,
    this.minLines,
    this.maxLines,
    this.contentPadding,
  });

  List<TextInputFormatter>? defaultInputFormatters() {
    return null;
  }

  String? _internalValidator(String? value) {
    if (!enabled) return null; // Componente desabilitado não faz validação
    return defaultValidator(value);
  }

  String? defaultValidator(String? value) {
    if (!enabled) return null; // Componente desabilitado não faz validação
    if (required && (value == null || value.isEmpty)) return "Obrigatório";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var theme = CustomFormStyle.of(context);

    return Padding(
      padding: padding ?? theme?.itemPadding ?? const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: TextFormField(
        controller: controller,
        initialValue: initialValue,
        focusNode: focusNode,
        readOnly: readOnly,
        enabled: enabled,
        maxLength: maxLength,
        inputFormatters: inputFormatters ?? defaultInputFormatters(),
        onChanged: onChanged,
        textAlign: textAlign ?? TextAlign.start,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          //border: const OutlineInputBorder(),
          //fillColor: enabled ? Colors.white : Colors.white70,
          //filled: true,
          contentPadding: contentPadding,
          prefix: prefix,
          suffixIcon: icon,
          suffixText: suffixText,
          prefixText: prefixText,
        ),
        autofocus: autofocus,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        textInputAction: textInputAction ?? TextInputAction.next,
        onSaved: onSaved,
        validator: validator ?? _internalValidator,
        onFieldSubmitted: onFieldSubmitted,
        minLines: minLines ?? 1, // Padrão é 1 se não informado (para não expandir no enter)
        maxLines: max(minLines ?? 1, maxLines ?? 1),
      ),
    );
  }
}

class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var loText = newValue.text.toLowerCase();
    var loNewValue = newValue.copyWith(text: loText);
    return loNewValue;
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var loText = newValue.text.toUpperCase();
    var loNewValue = newValue.copyWith(text: loText);
    return loNewValue;
  }
}
