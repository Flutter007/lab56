import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab56/widgets/single_post_info_card.dart';
import 'package:provider/provider.dart';
import '../provider/post_provider.dart';

final dateTime = DateFormat('dd.MM.yyyy, HH:mm');

class SinglePostInfoScreen extends StatefulWidget {
  const SinglePostInfoScreen({super.key});

  @override
  State<SinglePostInfoScreen> createState() => _SinglePostInfoScreenState();
}

class _SinglePostInfoScreenState extends State<SinglePostInfoScreen> {
  late String id;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      id = ModalRoute.of(context)!.settings.arguments as String;
      getPost(id);
    });
  }

  void getPost(String id) async {
    try {
      await context.read<PostProvider>().getPost(id);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Something went wrong!')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = context.watch<PostProvider>();
    final post = postProvider.post;
    return (postProvider.isFetching || post == null)
        ? Scaffold(
          appBar: AppBar(title: Text('Loading...')),
          body: Center(child: CircularProgressIndicator()),
        )
        : Scaffold(
          appBar: AppBar(title: Text(post.header)),
          body: SinglePostInfoCard(
            body: post.body,
            data: dateTime.format(post.createdAt),
          ),
        );
  }
}
