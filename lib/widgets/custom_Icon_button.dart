import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key key,
    @required this.color,
    @required this.icon,
    @required this.label,
    @required this.onPressed,
  }) : super(key: key);

  final Color color;
  final IconData icon;
  final String label;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(
        icon,
        color: color,
      ),
      onPressed: onPressed,
      label: Text(
        label,
        style: TextStyle(
          fontFamily: 'Quicksand',
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: color.withOpacity(0.3),
        padding: EdgeInsets.symmetric(vertical: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          side: BorderSide(
            color: color,
            width: 4,
          ),
        ),
      ),
    );
  }
}
