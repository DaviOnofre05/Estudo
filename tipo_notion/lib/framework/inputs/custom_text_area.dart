import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/framework/layouts/custom_form_style.dart';

class CustomTextArea extends StatelessWidget {
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
  final TextAlign? textAlign;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final int minLines;
  final int maxLines;

  const CustomTextArea({
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
    this.textAlign,
    this.validator,
    this.onSaved,
    this.minLines = 3,
    this.maxLines = 3,
    this.contentPadding,
  });

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
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        textAlign: textAlign ?? TextAlign.start,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          alignLabelWithHint: true,
          border: const OutlineInputBorder(),
          // fillColor: enabled ? Colors.white : Colors.white70,
          // filled: true,
          contentPadding: contentPadding,
          prefix: prefix,
          suffixIcon: icon,
          suffixText: suffixText,
        ),
        autofocus: autofocus,
        keyboardType: keyboardType ?? TextInputType.multiline,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        textInputAction: textInputAction ?? TextInputAction.newline,
        onSaved: onSaved,
        validator: validator ??
            (value) {
              if (!enabled) return null; // Componente desabilitado não faz validação
              if (required && (value == null || value.isEmpty)) return "Obrigatório";
              return null;
            },
        onFieldSubmitted: onFieldSubmitted,
        minLines: minLines,
        maxLines: max(minLines, maxLines),
      ),
    );
  }
}
