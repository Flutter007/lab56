import 'package:flutter/material.dart';

class SinglePostInfoCard extends StatelessWidget {
  final String body;
  final String data;
  const SinglePostInfoCard({super.key, required this.body, required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        color: theme.colorScheme.primaryContainer,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  textAlign: TextAlign.left,
                  body,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(data, style: theme.textTheme.titleMedium),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
