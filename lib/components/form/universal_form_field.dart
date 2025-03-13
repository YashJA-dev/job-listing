import 'package:flutter/material.dart';

import 'field_configs.dart';
import 'fields/text_form_field.dart';

class UniversalFormField {
  final Key? key;
  final bool updateKey;
  final UFFType fieldType;
  final String label;
  final dynamic initialValue;
  final void Function(dynamic val) onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool hide;
  final bool fullWidth;
  final bool useController;
  final bool withTitle;
  final TextStyle? labelStyle;
  UniversalFormField({
    this.key,
    this.updateKey = false,
    required this.fieldType,
    required this.label,
    this.initialValue,
    required this.onChanged,
    this.validator,
    this.controller,
    this.hide = false,
    this.fullWidth = false,
    this.useController = false,
    this.withTitle = false,
    this.labelStyle,
  });

  TextEditingController textEditingController = TextEditingController();

  Widget build({
    TextInputConfig textInputConfig = const TextInputConfig(),
    DropdownConfig dropdownConfig = const DropdownConfig(),
    MultiTextConfig multiTextConfig = const MultiTextConfig(),
    MultiSelectConfig multiSelectConfig = const MultiSelectConfig(),
    DateTimeYearConfig dtyConfig = const DateTimeYearConfig(),
    SearchConfig searchConfig = const SearchConfig(),
    SingleCheckboxConfig singleCheckboxConfig = const SingleCheckboxConfig(),
    CheckboxConfig checkboxConfig = const CheckboxConfig(),
    SliderConfig sliderConfig = const SliderConfig(),
    SwitchConfig switchConfig = const SwitchConfig(),
    IncDecConfig incDecConfig = const IncDecConfig(),
    MultiChipConfig multiChipConfig = const MultiChipConfig(),
    UploadConfig uploadConfig = const UploadConfig(),
  }) {
    Widget returningWidget = const SizedBox();
    if (controller != null) {
      textEditingController = controller!;
    } else {
      textEditingController.text = initialValue?.toString() ?? '';
      textEditingController.selection =
          TextSelection.collapsed(offset: initialValue?.toString().length ?? 0);
    }
    var formField = CTextFormField(
      key: updateKey ? Key(initialValue ?? '') : null,
      label: withTitle ? "" : label,
      autofocus: textInputConfig.autofocus,
      textAlign: textInputConfig.textAlign ?? TextAlign.start,
      autovalidateMode: textInputConfig.autovalidateMode,
      controller: useController
          ? textEditingController
          : initialValue == null
              ? textEditingController
              : null,
      initialValue: !useController ? initialValue?.toString() : null,
      decorator: textInputConfig.decorator,
      enabled: textInputConfig.enabled,
      focusNode: textInputConfig.focusNode,
      inputFormatters: textInputConfig.inputFormatters,
      maxLength: textInputConfig.maxLength,
      maxLines: textInputConfig.maxLines,
      onFieldSubmitted: textInputConfig.onFieldSubmitted,
      onEditingComplete: textInputConfig.onEditingComplete,
      obscureText: textInputConfig.obscureText,
      prefix: textInputConfig.prefix,
      readOnly: textInputConfig.readOnly,
      textInputType: textInputConfig.textInputType,
      validator: validator ??
          (_) {
            return null;
          },
      onChanged: onChanged,
    );

    switch (fieldType) {
      case UFFType.text:
        returningWidget = formField;
        break;
      default:
        return Container();
    }
    return hide
        ? const SizedBox.shrink()
        : SizedBox(
            child: AnimatedSize(
              duration: const Duration(milliseconds: 300),
              child: returningWidget,
            ),
          );
  }
}
