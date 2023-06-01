import 'package:dio/dio.dart';
import 'package:exam/data/models/products_model.dart';
import 'package:exam/data/network/controller.dart';
import 'package:exam/view/cart_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  final Dio _dio = Dio();
  String url = 'https://api.escuelajs.co/api/v1/products';

  List<String> images = [];

  HomeController homeController = HomeController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.getData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Products>>(
                future: homeController.getData(),
                builder: (context, snapshot){
                  return snapshot.hasData
                      ? getProduct()
                      : snapshot.hasError
                      ? errorWidget()
                      : loadingWidget();
                }),
          )
        ],
      ),
    );
  }

  Widget getProduct() => GridView.builder(
    scrollDirection: Axis.vertical,
    itemCount: homeController.products.length,
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 350,
        childAspectRatio: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10
    ),
    itemBuilder: (context, index) => Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0)),
      child: Stack(
        children: [
          // Image.network(
          //   products[index].images ?? [],
          //   height: 400,
          //   width: double.infinity,
          // ),
          Positioned(
            right: 16,
            left: 16,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  homeController.products[index].title ?? '',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  homeController.products[index].description ?? '',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(

                      )));
                    },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber
                        ),
                        child: Text('Add to cart')),
                    Text(
                      '${homeController.products[index].price}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red
                      ),
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
