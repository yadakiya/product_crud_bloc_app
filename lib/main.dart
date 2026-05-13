import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/theme/app_theme.dart';

import 'features/products/data/datasources/product_remote_datasource.dart';

import 'features/products/presentation/bloc/product_bloc.dart';
import 'features/products/presentation/bloc/product_event.dart';

import 'features/products/presentation/pages/home_page.dart';

void main() {
  runApp(const ShopSphereApp());
}

class ShopSphereApp extends StatelessWidget {
  const ShopSphereApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),

      builder: (context, child) {
        return BlocProvider(
          create: (_) =>
              ProductBloc(ProductRemoteDataSource())..add(LoadProductsEvent()),

          child: MaterialApp(
            debugShowCheckedModeBanner: false,

            title: 'ShopSphere',

            theme: AppTheme.lightTheme,

            home: const HomePage(),
          ),
        );
      },
    );
  }
}
