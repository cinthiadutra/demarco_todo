import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class CarouselWidget extends StatelessWidget {
  @observable
  final List<String> imagens;

  const CarouselWidget({Key? key, required this.imagens}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 16 / 9,
          viewportFraction: 0.9,
          autoPlay: true,
        ),
        items: imagens.map((imagem) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width * .8,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Image.network(
                  imagem,
                  fit: BoxFit.cover,
                  scale: 3.0,
                ),
              );
            },
          );
        }).toList(),
      );
    });
  }
}
