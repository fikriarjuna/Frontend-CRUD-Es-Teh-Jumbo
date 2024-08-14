import 'package:flutter/material.dart';
import 'package:tehjumbofirebase/Widget/Button.dart';
import 'package:tehjumbofirebase/shared/theme.dart';
import 'package:tehjumbofirebase/view/Payment.dart';

class ProductDetailPage extends StatefulWidget {
  final dynamic product;

  ProductDetailPage({required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _quantity = 1;

  void incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String cleanPrice =
        widget.product['price'].replaceAll(RegExp(r'[^0-9]'), '');
    int price = int.parse(cleanPrice);
    int totalPrice = price * _quantity;

    return Scaffold(
      body: Stack(children: [
        Container(
          height: 400,
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/images/empty_image.png',
            image: widget.product['image_url'],
            width: double.infinity,
            height: 300,
            fit: BoxFit.fill,
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset('assets/images/empty_image.png',
                  fit: BoxFit.fill);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: BackBtn(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 370),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.product['name'], style: titleStyle),
                            Text(widget.product['price'], style: subtitleStyle),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            incrementBtn(
                                icon: Icons.remove,
                                onPressed: decrementQuantity),
                            SizedBox(width: 8),
                            Text(_quantity.toString()),
                            SizedBox(width: 8),
                            incrementBtn(
                                icon: Icons.add, onPressed: incrementQuantity),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Es teh jumbo penuh rasa adalah minuman segar yang terbuat dari campuran teh hitam yang disajikan dingin dengan tambahan perisa alami yang segar.',
                        style: textStyle,
                      ),
                      SizedBox(height: 18),
                      Text('Ingredients:', style: textStyle),
                      Text('Teh hitam dan perisa alami', style: textStyle),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 100),
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text('Total Price:', style: textStyle),
                          Text('Rp.$totalPrice',
                              style: textStyle.copyWith(
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(width: 100),
                      Expanded(
                        child: CustomFillButton(
                          title: 'Order now',
                          width: 500,
                          onPressed: _quantity > 0
                              ? () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PaymentPage(
                                        product: widget.product,
                                        quantity: _quantity,
                                      ),
                                    ),
                                  );
                                }
                              : () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Minimal order 1 produk'),
                                    ),
                                  );
                                },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
