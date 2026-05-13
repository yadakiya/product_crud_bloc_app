import 'package:dio/dio.dart';

import '../../../../core/network/dio_client.dart';
import '../models/product_model.dart';

class ProductRemoteDataSource {
  final Dio dio = DioClient.dio;
  Future<void> addProduct({
    required String title,
    required String description,
    required double price,
    required String image,
  }) async {
    try {
      await dio.post(
        'products/add',

        data: {
          "title": title,
          "description": description,
          "price": price,
          "thumbnail": image,
        },
      );
    } catch (e) {
      throw Exception('Failed to add product');
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      await dio.delete('products/$id');
    } catch (e) {
      throw Exception('Failed to delete product');
    }
  }

  Future<void> updateProduct({
    required int id,
    required String title,
    required String description,
    required double price,
    required String image,
  }) async {
    try {
      await dio.put(
        'products/$id',

        data: {
          "title": title,
          "description": description,
          "price": price,
          "thumbnail": image,
        },
      );
    } catch (e) {
      throw Exception('Failed to update product');
    }
  }

  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await dio.get('products');

      final List products = response.data['products'];

      return products.map((json) => ProductModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load products');
    }
  }
}
