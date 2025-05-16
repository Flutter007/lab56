import 'package:flutter/material.dart';
import 'package:lab56/app_routes.dart';
import 'package:lab56/provider/post_provider.dart';
import 'package:lab56/screens/home_blog.dart';
import 'package:provider/provider.dart';

class Lab56 extends StatelessWidget {
  const Lab56({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (ctx) => PostProvider())],
      child: MaterialApp(
        initialRoute: AppRoutes.home,
        routes: {AppRoutes.home: (ctx) => HomeBlog()},
      ),
    );
  }
}
