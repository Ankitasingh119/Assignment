import 'package:flutter/material.dart';
import 'package:flutter_assignment/blocs/product_list/product_list_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'repositories/product_repository.dart';
import 'blocs/product_list/product_list_bloc.dart';
import 'blocs/favorites/favorites_bloc.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final productRepository = ProductRepository(httpClient: http.Client());

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) =>
                  ProductListBloc(repository: productRepository)
                    ..add(FetchProducts()),
        ),
        BlocProvider(create: (_) => FavoritesBloc()),
      ],
      child: MaterialApp(
        title: 'Product App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
