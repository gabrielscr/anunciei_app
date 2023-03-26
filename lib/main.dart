import 'package:anunciei_app/presentation/routes.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/dependency_injection.dart';
import 'data/models/item_model.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ItemModelAdapter());
  setupDependencyInjection();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final goRouter = GoRouter(
    routes: routes,
    errorPageBuilder: (context, state) {
      final routeName = state.name;

      return MaterialPage(
        child: Scaffold(
          appBar: AppBar(title: const Text('Error')),
          body: Center(
            child: Text('Could not find route $routeName'),
          ),
        ),
      );
    },
  );

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Clean Architecture Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: goRouter.routerDelegate,
      routeInformationParser: goRouter.routeInformationParser,
    );
  }
}
