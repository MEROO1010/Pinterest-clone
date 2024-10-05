import 'package:flutter/material.dart';
import 'package:pinterest_clone/widgets/text_field_container.dart';

class RectangularInputField extends StatelessWidget {
  final String hintText;
  final IconData incon;
  final bool obscureText;
  final TextEditingController textEditingController;

  const RectangularInputField({
    Key? key,
    required this.hintText,
    required this.incon,
    required this.obscureText,
    required this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextField(
      cursorColor: Colors.white,
      obscureText: obscureText,
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        helperStyle: TextStyle(color: Colors.white, fontSize: 18),
        prefixIcon: Icon(
          incon,
          color: Colors.white,
          size: 20,
        ),
        border: InputBorder.none,
      ),
    ));
  }
}
