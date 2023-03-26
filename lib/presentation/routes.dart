import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'pages/home_page.dart';

final routes = [
  GoRoute(
    path: '/',
    pageBuilder: (context, state) {
      return const MaterialPage(child: HomePage());
    },
  ),
];
