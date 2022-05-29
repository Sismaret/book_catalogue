import 'package:flutter/material.dart';

class Stars extends StatelessWidget {
  final int rating;
  const Stars({required this.rating});
  Widget starsIcons() {
    // ignore: deprecated_member_use
    List<Widget> icons = <Widget>[];
    for (var i = 0; i < 5; i++) {
      icons.add(Icon(
        Icons.star,
        size: 15.0,
        color: i < rating ? Colors.yellow : Colors.grey,
      ));
    }
    return Row(children: icons);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: starsIcons(),
    );
  }
}
