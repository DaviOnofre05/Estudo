import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../util/format_funcs.dart';

import '/framework/inputs/custom_text_input.dart';
import '/framework/mask_text_input_formatter.dart';
import '/util/format_funcs.dart';

class CustomTimeInput extends StatelessWidget {
  final String? hint;
  final String? label;
  final ValueChanged<String>? onFieldSubmitted;
  final EdgeInsetsGeometry? padding;
  final bool required;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction textInputAction;
  final bool autofocus;
  final bool readOnly;
  final bool enabled;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final String? suffixText;
  final TextAlign textAlign;
  final FormFieldValidator<String>? validator;

  late final TextEditingController controller;
  final timeMask = MaskTextInputFormatter(mask: "##:##");

  CustomTimeInput({
    super.key,
    this.hint,
    this.label,
    this.onFieldSubmitted,
    this.keyboardType = TextInputType.number,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.next,
    this.required = true,
    this.padding,
    this.autofocus = false,
    this.readOnly = false,
    this.maxLength,
    this.inputFormatters,
    this.onChanged,
    this.enabled = true,
    this.suffixText,
    this.textAlign = TextAlign.start,
    this.validator,
    TextEditingController? controller,
    String? initialValue,
  }) {
    this.controller = controller ?? TextEditingController(text: initialValue ?? "");
    // Aplica o conteúdo na máscara para não dar problema na primeira edição
    timeMask.formatEditUpdate(
      const TextEditingValue(text: ""),
      TextEditingValue(text: this.controller.text),
    );
  }

  // Efetua a reformatação do conteúdo do textinput
  void reformat([TimeOfDay? time]) {
    // Formata/Reformata o texto para o padrão certo
    const t = "HH:mm";
    var newString = time != null ? formatTime(time, t) : reformatTime(controller.text, t);
    if (newString != null) {
      // Reaplica máscara nova string na máscara
      newString = timeMask
          .formatEditUpdate(
            TextEditingValue(text: controller.text),
            TextEditingValue(text: newString),
          )
          .text;
      // Se mudou do que já estava -> atualiza controller e onChange
      if (controller.text != newString) {
        controller.text = newString;
        if (onChanged != null) onChanged!(controller.text);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      canRequestFocus: false,
      // Se perdeu o foco -> reformata
      onFocusChange: (hasFocus) {
        if (!hasFocus) reformat();
      },
      child: CustomTextInput(
        hint: hint,
        label: label,
        onFieldSubmitted: onFieldSubmitted,
        controller: controller,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization,
        textInputAction: textInputAction,
        required: required,
        padding: padding,
        autofocus: autofocus,
        readOnly: readOnly,
        icon: readOnly
            ? null
            : Focus(
                // Impede foco no botão (via teclado, foco somente no textinput)
                canRequestFocus: false,
                descendantsAreFocusable: false,
                child: IconButton(
                  icon: const Icon(Icons.schedule),
                  splashRadius: 24,
                  onPressed: () async {
                    TimeOfDay? oldTime = str2Time(controller.text);
                    var newTime = await showTimePicker(
                      context: context,
                      initialTime: oldTime ?? TimeOfDay.now(),
                    );
                    if (newTime != null) {
                      reformat(newTime);
                    }
                  },
                ),
              ),
        maxLength: maxLength,
        inputFormatters: inputFormatters ?? [timeMask],
        onChanged: onChanged,
        enabled: enabled,
        suffixText: suffixText,
        textAlign: textAlign,
        validator: validator ??
            (value) {
              if (!enabled) return null; // Componente desabilitado não faz validação
              if (!required && (value == null || value.isEmpty)) return null;
              if (str2Time(value) == null) return "Inválido";
              return null;
            },
      ),
    );
  }
}
