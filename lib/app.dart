import 'package:flutter/material.dart';
import 'package:flutter_assignment/blocs/product_list/product_list_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'repositories/product_repository.dart';
import 'blocs/product_list/product_list_bloc.dart';
import 'blocs/favorites/favorites_bloc.dart';
import 'screens/splash_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = ProductRepository(httpClient: http.Client());
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) => ProductListBloc(repository: repo)..add(FetchProducts()),
        ),
        BlocProvider(create: (_) => FavoritesBloc()),
      ],
      child: MaterialApp(
        title: 'ProductApp',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: SplashScreen(),
      ),
    );
  }
}
