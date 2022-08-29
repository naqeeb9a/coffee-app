import 'dart:math';

final _names = [
  "Espresso",
  "Americano",
  "Cappuccino",
  "Latte",
  "Mochaccino",
  "Iced coffee",
  "Latte macchiato",
  "Café au lait"
];

class Coffee {
  final String name;
  final String image;
  final double price;
  Coffee(this.image, this.name, this.price);
}

final random = Random();

final coffees = List.generate(
    _names.length,
    (index) => Coffee(
        "assets/${index + 1}.png", _names[index], random.nextDouble() * 120));
