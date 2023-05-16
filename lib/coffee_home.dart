import 'package:coffeeapp/home.dart';
import 'package:coffeeapp/utils.dart';
import 'package:flutter/material.dart';

class CoffeeHome extends StatelessWidget {
  const CoffeeHome({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: const Duration(seconds: 1),
                pageBuilder: (context, animation, secondaryAnimation) {
                  return FadeTransition(
                    opacity: animation,
                    child: const Home(),
                  );
                },
              ));
        },
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0xffa89276),
                Colors.white,
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            ),
            Positioned(
              height: size.height * 0.4,
              left: 0,
              right: 0,
              top: size.height * 0.15,
              child: Hero(
                tag: coffees[2].name,
                child: Image.asset(
                  coffees[2].image,
                ),
              ),
            ),
            Positioned(
              height: size.height * 0.7,
              left: 0,
              right: 0,
              bottom: 0,
              child: Hero(
                tag: coffees[3].name,
                child: Image.asset(
                  coffees[3].image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              height: size.height,
              left: 0,
              right: 0,
              bottom: -size.height * 0.8,
              child: Hero(
                tag: coffees[4].name,
                child: Image.asset(
                  coffees[4].image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              height: size.height * 0.7,
              left: size.width * 0.3,
              right: size.width * 0.3,
              bottom: 0,
              child: Image.asset(
                "assets/logo.png",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
