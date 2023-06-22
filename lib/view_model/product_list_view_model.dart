import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../models/model/products_model.dart';

class ProductListViewModel extends ChangeNotifier{

  final Dio _dio = Dio();
  String url = 'https://api.escuelajs.co/api/v1/products';

  List<Products> products = [];

  Future<List<Products>> getData() async {

    Response response = await _dio.get(url);
    response.data.forEach((e)
    => products.add(Products.fromJson(e)));

    return products;
  }


}