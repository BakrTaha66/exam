import 'package:dio/dio.dart';
import 'package:exam/view/cart_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/model/cart.dart';
import '../models/model/products_model.dart';
import '../view_model/product_list_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Dio _dio = Dio();
  String url = 'https://api.escuelajs.co/api/v1/products';

  List<String> images = [];

  ProductListViewModel productListViewModel = ProductListViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productListViewModel.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Products',
            style:  TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black
            ),),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: FutureBuilder<List<Products>>(
                  future: productListViewModel.getData(),
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? getProduct()
                        : snapshot.hasError
                            ? errorWidget()
                            : loadingWidget();
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget getProduct() => GridView.builder(
        itemCount: productListViewModel.products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16.0)),
          child: Stack(
            children: [
              Image.network(
                productListViewModel.products[index].images![0],
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                height: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      tileMode: TileMode.clamp,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0),
                        Colors.black.withOpacity(0.5),
                        Colors.black.withOpacity(0.8),
                      ],
                    )
                ),
              ),
              Positioned(
                right: 16,
                left: 16,
                bottom: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productListViewModel.products[index].title ?? '',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      productListViewModel.products[index].description ?? '',
                      style: TextStyle(
                        fontSize: 12,
                          color: Colors.white
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          r'$''${productListViewModel.products[index].price}',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Consumer<ShoppingCartProvider>(
                            builder:
                            (BuildContext context, ShoppingCartProvider cart, Widget? child){
                              return  ElevatedButton(
                                  onPressed: () {
                                    cart.add(productListViewModel.products[index]);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                        builder: (context) => ShoppingCart(

                                        )));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.amber),
                                  child: Text('Add to cart'));
                            }

                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget errorWidget() => const Text('Sorry, Something went wrong');

  Widget loadingWidget() => const CupertinoActivityIndicator();
}
