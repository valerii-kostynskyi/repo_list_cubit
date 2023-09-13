import 'package:flutter/material.dart';
import 'package:repo_list_cubit/presentation/components/svg_icon_widget.dart';

class InputTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function()? onTapSuffix;
  final ValueChanged<String>? onChanged;
  final String hintText;

  const InputTextFieldWidget({
    super.key,
    required this.controller,
    this.onTapSuffix,
    this.onChanged,
    this.hintText = 'Search',
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        // suffix: GestureDetector(
        //   onTap: onTapSuffix,
        //   child: Transform.translate(
        //     offset: const Offset(0.0, 3.0),
        //     child: const SVGIconWidget(
        //       icon: 'icon_close',
        //     ),
        //   ),
        // ),
        suffixIcon: GestureDetector(
          onTap: onTapSuffix,
          child: const Padding(
            padding: EdgeInsets.only(
              left: 18.0,
              right: 10,
            ),
            child: SVGIconWidget(
              icon: 'icon_search',
            ),
          ),
        ),
      ),
    );
  }
}
