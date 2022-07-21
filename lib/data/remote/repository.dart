import 'package:assessment_app/data/models/product_response_model.dart';
import 'package:assessment_app/data/remote/ApiProvider.dart';
import 'package:flutter/material.dart';

class Repo {
  final ApiProvider _apiprovider = ApiProvider();

  Future<ProductGetResponse> getProductList(BuildContext context,
      Map<String, String> map) async {
    final response = await _apiprovider.get(context, "", map);
    return ProductGetResponse.fromJson(response);
  }
}