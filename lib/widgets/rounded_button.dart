import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String imageSrc;
  final VoidCallback press;

  const RoundedButton({Key? key, required this.imageSrc, required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0, bottom: 30.0 / 2),
        child: Container(
          padding: EdgeInsets.all(30.0 / 2),
          width: 65,
          height: 65,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
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
          child: Image.asset(imageSrc),
        ),
      ),
    );
  }
}
