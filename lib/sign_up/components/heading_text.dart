import 'package:flutter/material.dart';

class HeadText extends StatelessWidget {
  const HeadText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0 / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          Text(
            'Informe seus dados para cadastrar',
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Criar Conta',
            style: TextStyle(
                fontSize: 36,
                color: Colors.white30,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
