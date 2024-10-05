import 'package:flutter/material.dart';

class RectangularButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color colors1;
  final Color colors2;

  const RectangularButton(
      {Key? key,
      required this.text,
      required this.press,
      required this.colors1,
      required this.colors2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: EdgeInsets.only(top: 6.0, bottom: 6.0),
        child: Container(
          width: double.infinity,
          height: 65,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.redAccent,
                    Colors.red,
                  ]),
              boxShadow: [
                BoxShadow(
                  offset: Offset(3, 3),
                  spreadRadius: 1,
                  blurRadius: 4,
                  color: Colors.red,
                ),
                BoxShadow(
                  offset: Offset(-5, -5),
                  spreadRadius: 1,
                  blurRadius: 4,
                  color: Colors.redAccent,
                ),
              ]),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
