import 'package:flutter/material.dart';

/*
class _JuiceDetailsPageState extends State<JuiceDetailsPage> {
  var count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: CounterScreen(
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
      ),
    );
  }
}


class CounterScreen extends StatelessWidget {


 final int currentCount;
  final Color color;
  final VoidCallback? onIncreaseClicked;
  final VoidCallback? onDecreaseClicked;
  final textStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18);
  CounterScreen({
    required this.currentCount,
    required this.color,
    this.onIncreaseClicked,
    this.onDecreaseClicked,
  });

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: AspectRatio(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final imageHeight = constraints.maxHeight * 0.7;
          final imageHorizontalMargin = constraints.maxWidth * 0.15;
          final imageBottomMargin = constraints.maxHeight * 0.07;
          return Container(
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
          );
        },
      ),
      aspectRatio: 0.86,
    ),
  );
}
}

*/