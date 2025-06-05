import 'package:flutter/material.dart';
import 'package:flutter_application_1/scripts/cuonter_screen.dart';
import 'package:flutter_application_1/utils/entity.dart';
import 'package:flutter_application_1/utils/my_button.dart';

class JuiceDetailsPage extends StatefulWidget {
  final JuiceEntity juice;

  const JuiceDetailsPage(this.juice);

  @override
  _JuiceDetailsPageState createState() => _JuiceDetailsPageState();
}

class SimpleRatingBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) => Icon(
          Icons.star,
          color: Color(0xFFFFBA00),
          size: 18,
        ),
      ),
    );
  }
}

final List<String> reviewImages = [
  'https://flutter4fun.com/wp-content/uploads/2021/09/1.png',
  'https://flutter4fun.com/wp-content/uploads/2021/09/2.png',
  'https://flutter4fun.com/wp-content/uploads/2021/09/3.png',
  'https://flutter4fun.com/wp-content/uploads/2021/09/4.png',
];
final addImageUrl = 'https://flutter4fun.com/wp-content/uploads/2021/09/add.png';

class ReviewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, index) => SizedBox(width: 18),
        itemBuilder: (_, index) {
          if (index == reviewImages.length) {
            return Image.network(addImageUrl);
          }

          return Image.network(reviewImages[index]);
        },
        itemCount: reviewImages.length + 1,
      ),
    );
  }
}

class _JuiceDetailsPageState extends State<JuiceDetailsPage> {
  var count = 0;
  double bottomSectionHeight = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.only(bottom: bottomSectionHeight),
            children: [
              AspectRatio(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final imageHeight = constraints.maxHeight * 0.7;
                    final imageHorizontalMargin = constraints.maxWidth * 0.15;
                    final imageBottomMargin = constraints.maxHeight * 0.07;
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: widget.juice.color,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(32),
                              bottomRight: Radius.circular(32),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: imageHorizontalMargin,
                                right: imageHorizontalMargin,
                                bottom: imageBottomMargin,
                              ),
                              child: Image.network(
                                'https://flutter4fun.com/wp-content/uploads/2021/09/full.png',
                                height: imageHeight,
                              ),
                            ),
                          ),
                          margin: EdgeInsets.only(bottom: 26),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: CounterWidget(
                            currentCount: count,
                            color: widget.juice.color,
                            onIncreaseClicked: () {
                              setState(() {
                                count++;
                              });
                            },
                            onDecreaseClicked: () {
                              setState(() {
                                count--;
                              });
                            },
                          ),
                        )
                      ],
                    );
                  },
                ),
                aspectRatio: 0.86,
              ),
              SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Besom Orange Juice',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SimpleRatingBar()
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Drinking Orange Juice is not only enhances health body also strengthens muscles',
                      style: TextStyle(color: Color(0xFFB0B1B4), fontSize: 16),
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Reviews',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'See all',
                          style: TextStyle(
                            color: Color(0xFFD81C33),
                            decoration: TextDecoration.underline,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 16),
                    ReviewsList(),
                  ],
                ),
              )
            ],
          ),
          Container(
            color: widget.juice.color,
            padding: EdgeInsets.only(left: 24, right: 24, top: 26, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Image.network(
                    'https://flutter4fun.com/wp-content/uploads/2021/09/back.png',
                    width: 32,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                Text(
                  'Besom.',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                Image.network(
                  'https://flutter4fun.com/wp-content/uploads/2021/09/shop_white.png',
                  width: 32,
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: bottomSectionHeight,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: '\$',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: '25.99',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    height: 48,
                    child: MyButton(
                      text: 'Buy Now',
                      bgColor: widget.juice.color,
                      textColor: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
