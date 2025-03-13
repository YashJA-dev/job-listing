import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:joblisting/components/form/decorator/field_decorator.dart';
import 'package:joblisting/configs/app_colors.dart';

class CTextFormField extends StatefulWidget {
  final String label;
  final Widget? prefix;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final String? initialValue;
  final EdgeInsets? padding;
  final int maxLines;
  final bool obscureText;
  final AutovalidateMode autovalidateMode;
  final String? Function(String? value) validator;
  final void Function(String value) onChanged;
  final void Function(String value)? onFieldSubmitted;
  final void Function()? onTap;
  final bool? readOnly;
  final TextInputType? textInputType;
  final bool isDateField;
  final bool isTimeField;
  final bool isYearField;
  final FocusNode? focusNode;
  final Function()? onEditingComplete;
  final bool? enabled;
  final TextInputType? keyboardType;
  final int? maxLength;
  final InputDecoration? decorator;
  final bool autofocus;
  final TextAlign textAlign;
  const CTextFormField({
    super.key,
    required this.label,
    this.controller,
    this.initialValue,
    this.padding,
    this.maxLines = 1,
    this.obscureText = false,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    required this.validator,
    this.onFieldSubmitted,
    required this.onChanged,
    this.onTap,
    this.prefix,
    this.readOnly,
    this.textInputType,
    this.isDateField = false,
    this.isTimeField = false,
    this.isYearField = false,
    this.focusNode,
    this.onEditingComplete,
    this.enabled = true,
    this.inputFormatters,
    this.keyboardType,
    this.maxLength,
    this.decorator,
    this.autofocus = false,
    this.textAlign = TextAlign.start,
  });

  CTextFormField copyWith({
    Key? key,
    String? label,
    TextEditingController? controller,
    String? initialValue,
    EdgeInsets? padding,
    int? maxLines,
    bool? obscureText,
    AutovalidateMode? autovalidateMode,
    String? Function(String? value)? validator,
    void Function(String value)? onChanged,
    void Function(String value)? onFieldSubmitted,
    void Function()? onTap,
    bool? readOnly,
    TextInputType? textInputType,
    bool isDateField = false,
    bool isTimeField = false,
    bool isYearField = false,
    FocusNode? focusNode,
    Function()? onEditingComplete,
    bool? autofocus,
    InputDecoration? decorator,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return CTextFormField(
      key: key ?? this.key,
      label: label ?? this.label,
      controller: controller ?? this.controller,
      initialValue: initialValue,
      padding: padding ?? this.padding,
      maxLines: maxLines ?? this.maxLines,
      obscureText: obscureText ?? this.obscureText,
      autovalidateMode: autovalidateMode ?? this.autovalidateMode,
      validator: validator ?? this.validator,
      onChanged: onChanged ?? this.onChanged,
      onFieldSubmitted: onFieldSubmitted ?? this.onFieldSubmitted,
      onTap: onTap ?? this.onTap,
      readOnly: readOnly ?? this.readOnly,
      textInputType: textInputType ?? this.textInputType,
      isDateField: isDateField,
      isTimeField: isTimeField,
      inputFormatters: inputFormatters ?? this.inputFormatters,
      isYearField: isYearField,
      focusNode: focusNode ?? this.focusNode,
      onEditingComplete: onEditingComplete ?? this.onEditingComplete,
      autofocus: autofocus ?? this.autofocus,
      decorator: decorator ?? this.decorator,
    );
  }

  @override
  State<CTextFormField> createState() => _CTextFormFieldState();
}

class _CTextFormFieldState extends State<CTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.key,
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      inputFormatters: widget.inputFormatters,
      onFieldSubmitted: widget.onFieldSubmitted,
      controller: widget.controller,
      initialValue: widget.initialValue,
      enabled: widget.enabled,
      decoration: widget.isDateField
          ? FieldDecorator(label: widget.label, contentPadding: widget.padding)
              .copyWith(
              suffixIcon: GestureDetector(
                onTap: widget.onTap,
                child: const Icon(
                  Icons.calendar_month_outlined,
                ),
              ),
              suffixIconColor: AppColors.primary,
            )
          : widget.isTimeField
              ? FieldDecorator(
                      label: widget.label, contentPadding: widget.padding)
                  .copyWith(
                  suffixIcon: const Icon(
                    Icons.watch_later_outlined,
                  ),
                  suffixIconColor: AppColors.primary,
                )
              : widget.isYearField
                  ? FieldDecorator(
                          label: widget.label, contentPadding: widget.padding)
                      .copyWith(
                      suffixIcon: GestureDetector(
                        onTap: widget.onTap,
                        child: const Icon(
                          Icons.calendar_month,
                        ),
                      ),
                      suffixIconColor: AppColors.primary,
                    )
                  : widget.decorator ??
                      FieldDecorator(
                              label: widget.label,
                              contentPadding: widget.padding)
                          .copyWith(prefix: widget.prefix),
      // style: TextThem,
      cursorColor: AppColors.primary,
      obscureText: widget.obscureText,
      maxLines: widget.maxLines,
      autovalidateMode: widget.autovalidateMode,
      validator: widget.validator,
      onChanged: widget.onChanged,
      //! for now it is set only for time field once the time is converted to enterable field then it can be removed
      onTap: widget.isTimeField ? widget.onTap ?? () {} : () {},
      readOnly: widget.readOnly ?? false,
      keyboardType: widget.textInputType,
      onEditingComplete: widget.onEditingComplete,
      maxLength: widget.maxLength,
      textAlign: widget.textAlign,
    );
  }
}
