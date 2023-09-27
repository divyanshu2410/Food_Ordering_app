import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget icon;
  final Size size;
  final String text;

  CustomOutlineButton({
    required this.text,
    required this.icon,
    required this.size,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    var OutlineButton;
    return Container(
      width: size.width,
      height: size.height,
      child: OutlineButton.icon(
        onPressed: onPressed,
        highlightedBorderColor: Colors.black,
        borderSide: BorderSide(width: 1.5, color: Colors.black),
        shape: OutlineInputBorder(borderRadius: BorderRadius.zero),
        icon: icon,
        label: Text(
          text,
          style: Theme.of(context).textTheme.caption.copyWith(
                fontSize: 18.0,
                fontWeight: FontWeight.w200,
                color: Colors.black,
              ),
        ),
        color: Colors.white,
        highlightColor: Colors.white,
        splashColor: Theme.of(context).accentColor,
      ),
    );
  }
}
