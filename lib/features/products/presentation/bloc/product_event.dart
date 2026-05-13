import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadProductsEvent extends ProductEvent {}

class AddProductEvent extends ProductEvent {
  final String title;
  final String description;
  final double price;
  final String image;

  const AddProductEvent({
    required this.title,
    required this.description,
    required this.price,
    required this.image,
  });

  @override
  List<Object> get props => [title, description, price, image];
}

class UpdateProductEvent extends ProductEvent {
  final int id;

  final String title;

  final String description;

  final double price;

  final String image;

  const UpdateProductEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
  });

  @override
  List<Object> get props => [id, title, description, price, image];
}

class DeleteProductEvent extends ProductEvent {
  final int id;

  const DeleteProductEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class SearchProductEvent extends ProductEvent {
  final String query;

  const SearchProductEvent(this.query);

  @override
  List<Object> get props => [query];
}
