import 'package:flutter/material.dart';

import '../configs/app_colors.dart';

class DividerComponent extends StatelessWidget {
  final double height;
  final Color color;

  const DividerComponent({
    super.key,
    this.height = 1.0,
    this.color = AppColors.darkGray,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: color,
    );
  }
}
