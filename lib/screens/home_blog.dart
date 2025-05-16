import 'package:flutter/material.dart';

class HomeBlog extends StatefulWidget {
  const HomeBlog({super.key});

  @override
  State<HomeBlog> createState() => _HomeBlogState();
}

class _HomeBlogState extends State<HomeBlog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Feed'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
      body: Center(child: Column(children: [])),
    );
  }
}
