import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/post.dart';

final dateTime = DateFormat('dd.MM.yyyy, HH:mm');

class PostCard extends StatelessWidget {
  final Post post;
  final void Function() onTap;
  final void Function() onLongPress;
  final void Function() deletePost;
  const PostCard({
    super.key,
    required this.post,
    required this.onTap,
    required this.onLongPress,
    required this.deletePost,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 20,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        onLongPress: onLongPress,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Ink(
                child: ListTile(
                  title: Text(post.header, style: theme.textTheme.titleLarge),
                  trailing: IconButton(
                    onPressed: deletePost,
                    icon: Icon(Icons.delete),
                    color: theme.colorScheme.error,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(dateTime.format(post.createdAt)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
