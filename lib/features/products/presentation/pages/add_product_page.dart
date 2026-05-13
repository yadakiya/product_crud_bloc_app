import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';

import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final titleController = TextEditingController();

  final descriptionController = TextEditingController();

  final priceController = TextEditingController();

  final imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(title: const Text("Add Product")),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),

        child: Column(
          children: [
            SizedBox(height: 20.h),

            buildTextField(controller: titleController, hint: "Product Title"),

            SizedBox(height: 20.h),

            buildTextField(
              controller: descriptionController,

              hint: "Description",
            ),

            SizedBox(height: 20.h),

            buildTextField(controller: priceController, hint: "Price"),

            SizedBox(height: 20.h),

            buildTextField(controller: imageController, hint: "Image URL"),

            SizedBox(height: 40.h),

            SizedBox(
              width: double.infinity,

              height: 55.h,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),

                onPressed: () {
                  context.read<ProductBloc>().add(
                    AddProductEvent(
                      title: titleController.text,

                      description: descriptionController.text,

                      price: double.parse(priceController.text),

                      image: imageController.text,
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Product Added")),
                  );

                  Navigator.pop(context);
                },

                child: Text(
                  "Add Product",

                  style: TextStyle(fontSize: 18.sp, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,

    required String hint,
  }) {
    return TextField(
      controller: controller,

      decoration: InputDecoration(
        hintText: hint,

        filled: true,

        fillColor: Colors.white,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),

          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
