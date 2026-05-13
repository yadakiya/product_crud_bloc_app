import 'package:equatable/equatable.dart';
import '../../domain/entities/product_entity.dart';

/// BASE STATE
abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

/// INITIAL
class ProductInitial extends ProductState {}

/// LOADING
class ProductLoading extends ProductState {}

/// LOADED (includes search support)
class ProductLoaded extends ProductState {
  final List<ProductEntity> products;
  final List<ProductEntity> filteredProducts;

  const ProductLoaded({required this.products, required this.filteredProducts});

  @override
  List<Object> get props => [products, filteredProducts];
}

/// ERROR
class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object> get props => [message];
}
