import 'package:flutter/material.dart';
import 'package:shoes_store/shake_transition.dart';
import 'package:shoes_store/shoes.dart';
import 'package:shoes_store/shopping_cart.dart';

class ShoesDetails extends StatelessWidget {
  final Shoes shoes;
  final ValueNotifier<bool> notifierButtonsVisible = ValueNotifier(false);

  ShoesDetails({Key key, @required this.shoes}) : super(key: key);

  Widget _buildCarousel(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.5,
      child: Stack(
        children: [
          Positioned.fill(
            child: Hero(
              tag: 'background_${shoes.model}',
              child: Container(
                color: Color(shoes.color),
              ),
            ),
          ),
          Positioned(
            left: 70,
            right: 70,
            top: 10,
            child: Hero(
              tag: 'number_${shoes.model}',
              child: ShakeTransition(
                axis: Axis.vertical,
                offset: 15,
                duration: const Duration(milliseconds: 1400),
                child: Material(
                  color: Colors.transparent,
                  child: FittedBox(
                    child: Text(
                      shoes.modelNumber.toString(),
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.05),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          PageView.builder(
            itemCount: shoes.images.length,
            itemBuilder: (context, index) {
              final tag = index == 0
                  ? 'image_${shoes.model}'
                  : 'image_${shoes.model}_$index';
              return Container(
                alignment: Alignment.center,
                child: ShakeTransition(
                  axis: Axis.vertical,
                  duration: index == 0
                      ? const Duration(milliseconds: 900)
                      : Duration.zero,
                  child: Hero(
                    tag: tag,
                    child: Image.asset(
                      shoes.images[index],
                      height: 200,
                      width: 200,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifierButtonsVisible.value = true;
    });
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset(
          'assets/images/nike_logo.png',
          height: 40,
        ),
        leading: BackButton(color: Colors.black),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildCarousel(context),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ShakeTransition(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              shoes.model,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.0),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '\$${shoes.oldPrice.toInt().toString()}',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 13.0,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  Text(
                                    '\$${shoes.currentPrice.toInt().toString()}',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      ShakeTransition(
                        duration: const Duration(milliseconds: 1100),
                        child: Text(
                          'AVAILABLE SIZES',
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ShakeTransition(
                        duration: const Duration(milliseconds: 1100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _ShoesSizeItem(text: '6'),
                            _ShoesSizeItem(text: '7'),
                            _ShoesSizeItem(text: '8'),
                            _ShoesSizeItem(text: '9'),
                            _ShoesSizeItem(text: '10'),
                            _ShoesSizeItem(text: '11'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'DESCRIPTION',
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ValueListenableBuilder<bool>(
              valueListenable: notifierButtonsVisible,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: 'fav_1',
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.favorite,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    ),
                    Spacer(),
                    FloatingActionButton(
                      heroTag: 'fav_2',
                      backgroundColor: Colors.black,
                      child: Icon(Icons.shopping_cart),
                      onPressed: () {
                        openShoppingCart(context);
                      },
                    ),
                  ],
                ),
              ),
              builder: (context, value, child) {
                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 250),
                  left: 0,
                  right: 0,
                  bottom: value ? 0.0 : -kToolbarHeight * 1.5,
                  child: child,
                );
              }),
        ],
      ),
    );
  }

  void openShoppingCart(BuildContext context) async {
    notifierButtonsVisible.value = false;
    await Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, animation1, __) {
          return FadeTransition(
            opacity: animation1,
            child: ShoppingCart(
              shoes: shoes,
            ),
          );
        },
      ),
    );
    notifierButtonsVisible.value = true;
  }
}

class _ShoesSizeItem extends StatelessWidget {
  final String text;

  const _ShoesSizeItem({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text(
        'US $text',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 11.0,
        ),
      ),
    );
  }
}
