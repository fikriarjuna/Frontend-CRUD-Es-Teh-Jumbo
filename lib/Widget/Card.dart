import 'package:flutter/material.dart';
import 'package:tehjumbofirebase/shared/theme.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.title,
    required this.price,
    required this.img,
    this.rating = 3, // Rating default value is 0
    this.onTap,
  }) : super(key: key);

  final String title;
  final String img;
  final String price;
  final double rating; // Added rating
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 30, top: 14),
            width: 215,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: FadeInImage.assetNetwork(
                placeholder:
                    'assets/images/empty_image.png', // Gambar placeholder
                image: img,
                fit: BoxFit.fill,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                      'assets/images/empty_image.png'); // Gambar error
                },
              ),
            ),
          ),
          Container(
            width: 215,
            margin: EdgeInsets.only(left: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(title, style: menuStyle),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(price, style: textStyle),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < rating ? Icons.star : Icons.star_border,
                            color: index < rating ? Colors.green : Colors.grey,
                            size: 18,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustCard extends StatelessWidget {
  const CustCard({
    Key? key,
    required this.title,
    required this.price,
    required this.img,
    this.rating = 3, // Rating default value is 0
    this.onTap,
  }) : super(key: key);

  final String title;
  final String img;
  final String price;
  final double rating; // Added rating
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 30, top: 14),
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.assetNetwork(
                placeholder:
                    'assets/images/empty_image.png', // Gambar placeholder
                image: img,
                fit: BoxFit.fill,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                      'assets/images/empty_image.png'); // Gambar error
                },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: menuStyle,
                ),
                Text(price, style: textStyle),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: index < rating ? Colors.green : Colors.grey,
                      size: 18,
                    );
                  }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
