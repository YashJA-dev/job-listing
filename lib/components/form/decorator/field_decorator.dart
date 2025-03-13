import 'package:flutter/material.dart';
import 'package:joblisting/configs/app_colors.dart';

class FieldDecorator extends InputDecoration {
  FieldDecorator({
    required String label,
    EdgeInsets? contentPadding,
    bool isDropdown = false,
    final bool enabled = false,
    Widget? suffixIcon,
    FloatingLabelBehavior? floatingLabelBehavior,
  }) : super(
          label: isDropdown
              ? null
              : Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  textAlign: TextAlign.start,
                ),
          labelText: isDropdown ? label : null,
          hintStyle: const TextStyle(
            color: AppColors.darkGray,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          labelStyle: const TextStyle(
            color: AppColors.darkGray,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          hintMaxLines: 1,
          alignLabelWithHint: true,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          contentPadding:
              contentPadding ?? const EdgeInsets.fromLTRB(12, 12, 12, 16),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.58),
            borderSide: const BorderSide(
              color: AppColors.secondary,
              width: 1.25,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.58),
            borderSide: const BorderSide(
              color: AppColors.secondary,
              width: 1.25,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.58),
            borderSide: const BorderSide(
              color: AppColors.primary,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.58),
            borderSide: const BorderSide(
              color: AppColors.red,
              width: 0.8,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.58),
            borderSide: const BorderSide(
              color: AppColors.red,
              width: 0.8,
            ),
          ),
          hintTextDirection: TextDirection.ltr,
          suffixIcon: suffixIcon ??
              (isDropdown
                  ? const Icon(
                      Icons.keyboard_arrow_down,
                      size: 28,
                      weight: 20,
                      color: AppColors.black,
                    )
                  : const SizedBox.shrink()),
        );
}
