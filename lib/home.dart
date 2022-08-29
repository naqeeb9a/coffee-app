import 'package:coffeeapp/utils.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _pageCoffeeController = PageController(viewportFraction: 0.3);
  final _pageTextController = PageController();
  double _currentPage = 0.0;
  double _currentText = 0.0;
  void coffeeScrollListener() {
    setState(() {
      _currentPage = _pageCoffeeController.page!;
    });
  }

  void textScrollListener() {
    _currentText = _currentPage;
  }

  @override
  void initState() {
    _pageCoffeeController.addListener(() {
      coffeeScrollListener();
    });
    _pageTextController.addListener(() {
      textScrollListener();
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageCoffeeController.removeListener(() {
      coffeeScrollListener();
    });
    _pageCoffeeController.dispose();
    _pageTextController.removeListener(() {
      coffeeScrollListener();
    });
    _pageTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned(
              left: 20,
              right: 20,
              bottom: -size.height * 0.2,
              height: size.height * 0.3,
              child: const DecoratedBox(
                  decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(color: Colors.brown, blurRadius: 90, spreadRadius: 45)
              ]))),
          Positioned(
              left: 0,
              top: 0,
              right: 0,
              height: 100,
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                        itemCount: coffees.length,
                        controller: _pageTextController,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final opacity = (1 - (index - _currentText).abs())
                              .clamp(0.0, 1.0);
                          return Center(
                            child: Opacity(
                                opacity: opacity,
                                child: Text(
                                  coffees[index].name,
                                  style: const TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold),
                                )),
                          );
                        }),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    key: Key(coffees[_currentPage.toInt()].name),
                    child: Text(
                      "\$ ${coffees[_currentPage.toInt()].price.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 20),
                    ),
                  )
                ],
              )),
          Transform.scale(
            scale: 1.6,
            alignment: Alignment.bottomCenter,
            child: PageView.builder(
                controller: _pageCoffeeController,
                scrollDirection: Axis.vertical,
                itemCount: coffees.length,
                onPageChanged: (value) {
                  _pageTextController.animateToPage(value,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut);
                },
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const SizedBox.shrink();
                  }
                  final coffee = coffees[index - 1];
                  final result = _currentPage - index + 1;
                  final value = -0.4 * result + 1;
                  final opacity = value.clamp(0.0, 1.0);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Transform(
                        alignment: Alignment.bottomCenter,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..translate(
                              0.0, size.height / 2.6 * (1 - value).abs())
                          ..scale(value),
                        child: Opacity(
                            opacity: opacity,
                            child: Image.asset(
                              coffee.image,
                              fit: BoxFit.fitHeight,
                            ))),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
