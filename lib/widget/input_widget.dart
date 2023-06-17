import 'package:flutter/material.dart';
import 'package:izam_task/helper/app_colors.dart';

class InputWidget extends StatelessWidget {
  final Widget? icon;
  final String hint;
  final TextEditingController? textEditingController;
  final bool obscureText, enabled;
  final TextInputType? textInputType;
  final Function()? onTap;
  final String? Function(String? val)? validator;
  final Function(String val)? onChange;
  final Function(String val)? onFieldSubmitted;
  final FocusNode? focusNode;

  const InputWidget(
    this.hint, {
    Key? key,
    this.icon,
    this.textEditingController,
    this.obscureText = false,
    this.enabled = true,
    this.textInputType,
    this.onTap,
    this.validator,
    this.onChange,
    this.onFieldSubmitted,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.5),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        child: TextFormField(
          controller: textEditingController,
          obscureText: obscureText,
          keyboardType: textInputType,
          validator: validator,
          onChanged: onChange,
          onTap: onTap,
          enabled: enabled,
          onFieldSubmitted: onFieldSubmitted,
          focusNode: focusNode,
          decoration: InputDecoration(
              filled: true,
              constraints: const BoxConstraints(maxWidth: 500),
              fillColor: AppColors.backgroundColor,
              border: InputBorder.none,
              errorMaxLines: 3,
              hintText: hint,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 22, vertical: 17),
              icon: icon),
        ),
      ),
    );
  }
}
