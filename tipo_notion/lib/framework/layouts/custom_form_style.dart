import 'package:flutter/material.dart';

class CustomFormStyle extends InheritedWidget {
  final EdgeInsets? itemPadding;
  final EdgeInsets? horizontalPadding;
  final EdgeInsets? boxPadding;
  final EdgeInsets? formPadding;
  final EdgeInsets? buttonPadding;
  final double? rowGap;

  const CustomFormStyle({
    super.key,
    this.itemPadding,
    this.formPadding,
    this.horizontalPadding,
    this.boxPadding,
    this.buttonPadding,
    this.rowGap,
    required super.child,
  });

  static CustomFormStyle? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CustomFormStyle>();
  }

  @override
  bool updateShouldNotify(covariant CustomFormStyle oldWidget) {
    return (itemPadding != oldWidget.itemPadding ||
        formPadding != oldWidget.formPadding ||
        horizontalPadding != oldWidget.horizontalPadding ||
        boxPadding != oldWidget.boxPadding ||
        buttonPadding != oldWidget.buttonPadding ||
        rowGap != oldWidget.rowGap);
  }
}
