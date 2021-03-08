import 'package:flutter/material.dart';

class AppBanner extends StatelessWidget {
  const AppBanner({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      // color: Colors.yellow,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Odd',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Stick',
                fontSize: 72,
                fontWeight: FontWeight.w700,
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'T',
                children: [
                  TextSpan(
                    text: 'O',
                    style: TextStyle(color: Colors.amberAccent),
                  ),
                  TextSpan(
                    text: 'O',
                    style: TextStyle(color: Colors.indigoAccent),
                  ),
                  TextSpan(
                    text: 'L',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                  TextSpan(
                    text: 'S',
                    style: TextStyle(color: Colors.deepOrangeAccent),
                  ),
                ],
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontFamily: 'Quicksand',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
