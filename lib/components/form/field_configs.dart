import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum UFFType {
  text,
  date,
  time,
  year,
  address,
  radio,
  switchBtn,
  multiSelect,
  dropdown,
  multiText,
  slider,
  search,
  checkbox,
  upload,
  singleCheckbox,
  incDec,
  dateTimePicker,
  locationWithTextSearch,
  multiChipField,
  richTextEditor,
  multiDocumentSelect,
}

class TextInputConfig {
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final int maxLines;
  final int? maxLength;
  final Widget? prefix;
  final bool obscureText;
  final Function(String)? onFieldSubmitted;
  final AutovalidateMode autovalidateMode;
  final Iterable<String>? autofillHints;
  final MouseCursor? mouseCursor;
  final InputDecoration? decorator;
  final bool autofocus;
  final FocusNode? focusNode;
  final bool? enabled;
  final Function()? onEditingComplete;
  final TextAlign? textAlign;
  const TextInputConfig({
    this.textInputType,
    this.inputFormatters,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.prefix,
    this.obscureText = false,
    this.onFieldSubmitted,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.autofillHints,
    this.mouseCursor,
    this.decorator,
    this.focusNode,
    this.enabled,
    this.onEditingComplete,
    this.textAlign,
    this.autofocus = false,
  });
}

class DateTimeYearConfig {
  final BuildContext? context;
  final bool isDateField;
  final bool isTimeField;
  final bool isYearField;
  final bool prevDateRestriction;
  final bool futureDateRestriction;
  final bool readOnly;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool Function(DateTime day)? selectableDayPredicate;
  final bool makeInitialDateNull;
  const DateTimeYearConfig({
    this.context,
    this.isDateField = false,
    this.isTimeField = false,
    this.isYearField = false,
    this.prevDateRestriction = false,
    this.futureDateRestriction = false,
    this.readOnly = false,
    this.startDate,
    this.endDate,
    this.makeInitialDateNull = false,
    this.selectableDayPredicate,
  });
}

class DropdownConfig {
  final List<DropdownOption> dropdownOptions;
  final String? Function(dynamic)? dropdownValidator;
  const DropdownConfig({
    this.dropdownOptions = const [],
    this.dropdownValidator,
  });
}

// for dropdown option
class DropdownOption {
  final dynamic key;
  final String value;
  const DropdownOption({
    required this.key,
    required this.value,
  });
}

enum WidgetOrder { NORMAL, REVERSED }

class SingleCheckboxConfig {
  final bool checkboxValue;
  final WidgetOrder widgetOrder;
  const SingleCheckboxConfig({
    this.checkboxValue = false,
    this.widgetOrder = WidgetOrder.NORMAL,
  });
}

class SwitchConfig {
  final bool value;

  const SwitchConfig({
    this.value = false,
  });
}

class CheckboxConfig {
  final List<String>? options;
  final List<String>? selectedItems;
  const CheckboxConfig({
    this.options,
    this.selectedItems,
  });
}

class MultiSelectConfig {
  final Map<dynamic, dynamic> options;
  final List<dynamic>? selectedItems;
  final void Function(List<dynamic> selectedItems)? onChanged;
  final String? Function(List<dynamic>?)? validator;
  const MultiSelectConfig(
      {this.options = const {},
      this.selectedItems,
      this.onChanged,
      this.validator});
}

class MultiTextConfig {
  final List<String>? editableStringItems;
  final void Function(List<String>)? updateListInState;
  const MultiTextConfig({
    this.editableStringItems,
    this.updateListInState,
  });
}

class SliderConfig {
  final double? minVal;
  final double? maxVal;

  const SliderConfig({
    this.minVal,
    this.maxVal,
  });
}

class SearchConfig {
  final FutureOr<Iterable<Object>> Function(String)? optionsBuilder;
  final void Function(Object)? onSuggestionSelected;
  final Widget Function(BuildContext, Object)? itemBuilder;

  const SearchConfig({
    this.optionsBuilder,
    this.onSuggestionSelected,
    this.itemBuilder,
  });
}

class FileUploadConfig {
  final String? url;

  const FileUploadConfig({
    this.url,
  });
}

class IncDecConfig {
  final void Function()? onIncrement;
  final void Function()? onDecrement;

  const IncDecConfig({
    this.onIncrement,
    this.onDecrement,
  });
}

class MultiChipConfig {
  final List<String>? initialValue;
  final String? Function(String?)? onSumbitValidator;
  const MultiChipConfig({this.onSumbitValidator, this.initialValue});
}

class UploadConfig {
  final dynamic value;
  final bool? isReadOnly;
  final bool? enableCopy;
  final bool? allowMultiple;
  final int? limit;
  final List<String>? docTypes;
  final String? Function()? validate;
  final double? maximumDocumentSize;
  final bool? enablePreview;
  const UploadConfig({
    this.value,
    this.isReadOnly,
    this.enableCopy,
    this.allowMultiple,
    this.limit,
    this.docTypes,
    this.validate,
    this.maximumDocumentSize,
    this.enablePreview,
  });
}
