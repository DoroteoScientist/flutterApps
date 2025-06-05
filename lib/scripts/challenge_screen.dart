import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flutter_application_1/utils/entity.dart';
import 'package:flutter_application_1/utils/my_button.dart';

class ChallengeScreen extends StatelessWidget {
  const ChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          // Barra superior
          Container(
            height: 48,
            margin: const EdgeInsets.only(left: 20, top: 32, right: 20, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/barraMenu.png', height: 24),
                const Text('Besom.', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800)),
                Image.asset('assets/maletin.png', height: 24),
              ],
            ),
          ),

          // Lista de jugos
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: juiceList.length,
              itemBuilder: (context, index) {
                return JuiceWidget(juice: juiceList[index]);
              },
            ),
          ),

          // Menú inferior con desenfoque
          Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  child: Container(
                    color: Colors.white.withOpacity(0.2),
                    height: 64,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 18.0, sigmaY: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset('assets/home.png'),
                          Image.asset('assets/lupa.png'),
                          Image.asset('assets/cora.png'),
                          Image.asset('assets/persona.png'),
                          ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
class JuiceWidget extends StatelessWidget {
  final JuiceEntity juice;
  final VoidCallback? onTap;

  const JuiceWidget({super.key, required this.juice, this.onTap});

  @override
  Widget build(BuildContext context) {
    final textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );
    return AspectRatio(
      aspectRatio: 1.25,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final topPadding = constraints.maxHeight * 0.2;
          final leftPadding = constraints.maxWidth * 0.1;
          final imageWidth = constraints.maxWidth * 0.35;

          return GestureDetector(
            onTap: onTap,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: topPadding),
                  decoration: BoxDecoration(
                    color: juice.color,
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: topPadding, left: leftPadding),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              juice.name,
                              style: textStyle.copyWith(fontSize: 20),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '\$',
                                    style: textStyle.copyWith(fontSize: 16),
                                  ),
                                  TextSpan(
                                    text: juice.price,
                                    style: textStyle.copyWith(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 32,
                              width: 80,
                              child: MyButton(
                                text: 'Buy Now',
                                textColor: juice.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: imageWidth,
                        child: Image(image: juice.image, fit: BoxFit.contain),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
