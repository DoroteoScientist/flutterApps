import 'package:flutter/material.dart';

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
    color: Color.fromARGB(255, 14, 12, 129),
  ),
  JuiceEntity(
    name: 'Besom Orange Juice',
    image: AssetImage('assets/tarjeta.png'),
    price: '25.99',
    color: Color.fromARGB(255, 14, 153, 153),
  ),
];