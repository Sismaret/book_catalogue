import 'package:flutter/material.dart';

class BoxCard extends StatelessWidget {
  BoxCard.title(
      {required this.imageUrl,
      required this.title,
      required this.subTitle,
      required this.price});

  final String title;
  final String subTitle;
  final String imageUrl;
  final String price;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
        child: Row(
          children: [
            Image.network(imageUrl),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    subTitle,
                    style: const TextStyle(fontSize: 10.0),
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    price,
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: price == "Free" ? Colors.green : Colors.red,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        elevation: 8,
        shadowColor: Colors.black,
        margin: const EdgeInsets.all(10),
      ),
    );
  }
}
