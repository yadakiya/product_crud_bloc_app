import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'add_product_page.dart';
import 'edit_product_page.dart';
import 'product_details_page.dart';
import '../widgets/product_shimmer.dart';

import '../../../../core/constants/app_colors.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_state.dart';
import '../bloc/product_event.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: Text(
          "ShopSphere",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.dark,
          ),
        ),
      ),

      // ADD PRODUCT BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddProductPage()),
          );
        },
        child: const Icon(Icons.add),
      ),

      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            /// SEARCH BOX
            TextField(
              onChanged: (value) {
                context.read<ProductBloc>().add(SearchProductEvent(value));
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Search products...",
                icon: Icon(Icons.search),
              ),
            ),

            SizedBox(height: 20.h),

            /// PRODUCTS LIST
            Expanded(
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  /// LOADING STATE
                  if (state is ProductLoading) {
                    return const ProductShimmer();
                  }

                  /// ERROR STATE
                  if (state is ProductError) {
                    return Center(child: Text(state.message));
                  }

                  /// SUCCESS STATE
                  if (state is ProductLoaded) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<ProductBloc>().add(LoadProductsEvent());
                      },
                      child: GridView.builder(
                        itemCount: state.filteredProducts.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 14.w,
                          mainAxisSpacing: 14.h,
                          childAspectRatio: 0.63,
                        ),
                        itemBuilder: (context, index) {
                          final product = state.filteredProducts[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ProductDetailsPage(product: product),
                                ),
                              );
                            },

                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// IMAGE
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(24.r),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: product.thumbnail,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        placeholder: (context, url) =>
                                            const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.all(12.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        /// TITLE
                                        Text(
                                          product.title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.sp,
                                          ),
                                        ),

                                        SizedBox(height: 8.h),

                                        /// PRICE
                                        Text(
                                          "\$${product.price}",
                                          style: TextStyle(
                                            color: AppColors.primary,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        SizedBox(height: 8.h),

                                        /// ACTION BUTTONS
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            /// EDIT
                                            IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        EditProductPage(
                                                          product: product,
                                                        ),
                                                  ),
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.edit,
                                                color: Colors.blue,
                                              ),
                                            ),

                                            /// DELETE
                                            IconButton(
                                              onPressed: () {
                                                context.read<ProductBloc>().add(
                                                  DeleteProductEvent(
                                                    id: product.id,
                                                  ),
                                                );

                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      "Product Deleted",
                                                    ),
                                                  ),
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
