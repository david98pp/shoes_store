class Shoes {
  Shoes(
      {this.model,
      this.oldPrice,
      this.currentPrice,
      this.images,
      this.modelNumber,
      this.color});

  final String model;
  final double oldPrice;
  final double currentPrice;
  final List<String> images;
  final int modelNumber;
  final int color;
}

final shoes = <Shoes>[
  Shoes(
    model: 'AIR MAX 90 EZ BLACK',
    currentPrice: 149,
    oldPrice: 299,
    images: [
      'assets/images/shoes1_1.png',
      'assets/images/shoes1_2.png',
      'assets/images/shoes1_3.png'
    ],
    modelNumber: 90,
    color: 0XFFF6F6F6,
  ),
  Shoes(
    model: 'AIR MAX 270 Gold',
    currentPrice: 199,
    oldPrice: 349,
    images: [
      'assets/images/shoes2_1.png',
      'assets/images/shoes2_2.png',
      'assets/images/shoes2_3.png'
    ],
    modelNumber: 270,
    color: 0XFFFCF5EB,
  ),
  Shoes(
    model: 'AIR MAX 95 Red',
    currentPrice: 299,
    oldPrice: 399,
    images: [
      'assets/images/shoes3_1.png',
      'assets/images/shoes3_2.png',
      'assets/images/shoes3_3.png'
    ],
    modelNumber: 95,
    color: 0XFFFEEFEF,
  ),
  Shoes(
    model: 'AIR MAX 98 FREE',
    currentPrice: 149,
    oldPrice: 299,
    images: [
      'assets/images/shoes4_1.png',
      'assets/images/shoes4_2.png',
      'assets/images/shoes4_3.png'
    ],
    modelNumber: 98,
    color: 0XFFEDF3FE,
  ),
];
