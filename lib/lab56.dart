import 'package:flutter/material.dart';
import 'package:lab56/app_routes.dart';
import 'package:lab56/provider/post_provider.dart';
import 'package:lab56/screens/edit_screen.dart';
import 'package:lab56/screens/home_blog.dart';
import 'package:lab56/screens/post_form_screen.dart';
import 'package:lab56/screens/single_post_info_screen.dart';
import 'package:provider/provider.dart';

class Lab56 extends StatelessWidget {
  const Lab56({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (ctx) => PostProvider())],
      child: MaterialApp(
        initialRoute: AppRoutes.home,
        routes: {
          AppRoutes.home: (ctx) => HomeBlog(),
          AppRoutes.create: (ctx) => PostFormScreen(),
          AppRoutes.singlePost: (ctx) => SinglePostInfoScreen(),
          AppRoutes.edit: (ctx) => EditScreen(),
        },
      ),
    );
  }
}
