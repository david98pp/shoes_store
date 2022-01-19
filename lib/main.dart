import 'package:flutter/material.dart';
import 'package:shoes_store/shoes.dart';
import 'package:shoes_store/shoes_details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: ShoesStoreHome(),
    );
  }
}

class ShoesStoreHome extends StatelessWidget {
  final ValueNotifier<bool> notifierBottomBarVisible = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Image.asset(
                    'assets/images/nike_logo.png',
                    height: 40,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: shoes.length,
                      padding: const EdgeInsets.only(bottom: 20),
                      itemBuilder: (context, index) {
                        final shoesItem = shoes[index];
                        return ShoesItem(
                          shoesItem: shoesItem,
                          onTap: () {
                            _onShoesPressed(shoesItem, context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: notifierBottomBarVisible,
              child: Container(
                color: Colors.white.withOpacity(0.7),
                child: Row(
                  children: [
                    Expanded(child: Icon(Icons.home)),
                    Expanded(child: Icon(Icons.search)),
                    Expanded(child: Icon(Icons.favorite_border)),
                    Expanded(child: Icon(Icons.shopping_cart_outlined)),
                    Expanded(child: Icon(Icons.person)),
                  ],
                ),
              ),
              builder: (context, value, child) {
                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  left: 0,
                  right: 0,
                  bottom: value ? 0.0 : -kToolbarHeight,
                  height: kToolbarHeight,
                  child: child,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onShoesPressed(Shoes shoesItem, BuildContext context) async {
    notifierBottomBarVisible.value = false;
    await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation1, animtation2) {
          return FadeTransition(
            opacity: animation1,
            child: ShoesDetails(shoes: shoesItem),
          );
        },
      ),
    );
    notifierBottomBarVisible.value = true;
  }
}

class ShoesItem extends StatelessWidget {
  final Shoes shoesItem;
  final VoidCallback onTap;

  const ShoesItem({Key key, this.shoesItem, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const itemHeight = 290.0;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: SizedBox(
          height: itemHeight,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Positioned.fill(
                child: Hero(
                  tag: 'background_${shoesItem.model}',
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Color(shoesItem.color),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Hero(
                  tag: 'number_${shoesItem.model}',
                  child: SizedBox(
                    height: itemHeight * 0.6,
                    child: Material(
                      color: Colors.transparent,
                      child: FittedBox(
                        child: Text(
                          shoesItem.modelNumber.toString(),
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
              Positioned(
                top: 20,
                left: 100,
                height: itemHeight * 0.65,
                child: Hero(
                  tag: 'image_${shoesItem.model}',
                  child: Image.asset(
                    shoesItem.images.first,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.grey,
                ),
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.grey,
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      shoesItem.model,
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '\$${shoesItem.oldPrice.toInt().toString()}',
                      style: TextStyle(
                        color: Colors.red,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '\$${shoesItem.currentPrice.toInt().toString()}',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
