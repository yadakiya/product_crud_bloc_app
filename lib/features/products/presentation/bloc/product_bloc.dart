import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/product_remote_datasource.dart';

import '../../domain/entities/product_entity.dart';

import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRemoteDataSource dataSource;

  ProductBloc(this.dataSource) : super(ProductInitial()) {
    /// LOAD PRODUCTS
    on<LoadProductsEvent>((event, emit) async {
      emit(ProductLoading());

      try {
        final products = await dataSource.getProducts();

        emit(ProductLoaded(products: products, filteredProducts: products));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    /// SEARCH PRODUCTS
    on<SearchProductEvent>((event, emit) {
      final currentState = state;

      if (currentState is ProductLoaded) {
        final filteredProducts = currentState.products.where((product) {
          return product.title.toLowerCase().contains(
            event.query.toLowerCase(),
          );
        }).toList();

        emit(
          ProductLoaded(
            products: currentState.products,
            filteredProducts: filteredProducts,
          ),
        );
      }
    });

    /// ADD PRODUCT
    on<AddProductEvent>((event, emit) {
      final currentState = state;

      if (currentState is ProductLoaded) {
        final newProduct = ProductEntity(
          id: DateTime.now().millisecondsSinceEpoch,

          title: event.title,

          description: event.description,

          price: event.price,

          thumbnail: event.image,
        );

        final updatedProducts = [newProduct, ...currentState.products];

        emit(
          ProductLoaded(
            products: updatedProducts,
            filteredProducts: updatedProducts,
          ),
        );
      }
    });

    /// UPDATE PRODUCT
    on<UpdateProductEvent>((event, emit) {
      final currentState = state;

      if (currentState is ProductLoaded) {
        final updatedProducts = currentState.products.map((product) {
          if (product.id == event.id) {
            return product.copyWith(
              title: event.title,
              description: event.description,
              price: event.price,
              thumbnail: event.image,
            );
          }

          return product;
        }).toList();

        emit(
          ProductLoaded(
            products: updatedProducts,
            filteredProducts: updatedProducts,
          ),
        );
      }
    });

    /// DELETE PRODUCT
    on<DeleteProductEvent>((event, emit) {
      final currentState = state;

      if (currentState is ProductLoaded) {
        final updatedProducts = currentState.products
            .where((product) => product.id != event.id)
            .toList();

        emit(
          ProductLoaded(
            products: updatedProducts,
            filteredProducts: updatedProducts,
          ),
        );
      }
    });
  }
}
