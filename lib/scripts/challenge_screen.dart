import 'package:flutter/material.dart';
import 'dart:ui';

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

  const JuiceWidget({super.key, required this.juice});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.25,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final topPadding = constraints.maxHeight * 0.2;
          final imageWidth = constraints.maxWidth * 0.35;
          return Stack(
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
                      padding: EdgeInsets.only(top: topPadding, left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            juice.name,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "\$${juice.price}",
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: imageWidth,
                    child: Image(image: juice.image),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class JuiceEntity {
  final String name;
  final AssetImage image;
  final String price;
  final Color color;

  JuiceEntity({
    required this.name,
    required this.image,
    required this.price,
    required this.color,
  });
}

final juiceList = [
  JuiceEntity(
    name: 'Besom Yellow Juice',
    image: AssetImage('assets/rele.png'),
    price: '19.99',
    color: const Color.fromARGB(255, 14, 12, 129),
  ),
  JuiceEntity(
    name: 'Besom Orange Juice',
    image: AssetImage('assets/tarjeta.png'),
    price: '25.99',
    color: const Color.fromARGB(255, 14, 153, 153),
  ),
];