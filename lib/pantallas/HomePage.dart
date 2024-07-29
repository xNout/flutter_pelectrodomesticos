import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prfinal/layout/BtCard.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../AppConstants.dart';
import '../layout/LoadingIndicator.dart';
import '../layout/MainLayout.dart';
import '../models/Category.dart';
import '../models/Product.dart';
import 'HomeProductList.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late YoutubePlayerController _controller;
  final List<String> imgList = [
    'images/banner-01.jpg',
    'images/banner-02.jpg',
    'images/banner-03.png',
    'images/banner-04.jpg',
  ];

  @override
  void initState() {
    super.initState();
    /* _controller = YoutubePlayerController(
      initialVideoId: "RLkhnAN4PBQ",
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        loop: true,
      ),
    ); */
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      content: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 135,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 7),
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
              ),
              items: imgList
                  .map(
                    (item) => Container(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Image.asset(
                          item,
                          fit: BoxFit.fill,
                          height: 125,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 2),
            /* BtCard(
              child: SizedBox(
                height: 200, // Ajusta la altura según necesites
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  onReady: () {
                    _controller.addListener(() {});
                  },
                ),
              ),
            ), */

            // productos y categorias
            const ProductList(),
          ],
        ),
      ),
    );
  }
}
