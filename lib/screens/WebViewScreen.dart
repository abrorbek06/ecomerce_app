import 'package:flutter/material.dart';

import '../resours/assets.dart';
class Webviewscreen extends StatefulWidget {
  final String title;
  final String image;
  final String description;
  final String author;
  final String name;
  const Webviewscreen({super.key, required this.title, required this.image, required this.description, required this.author, required this.name});

  @override
  State<Webviewscreen> createState() => _WebviewscreenState();
}

class _WebviewscreenState extends State<Webviewscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 183,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(
                  image: widget.image != null
                      ? NetworkImage(
                      widget.image)
                      : AssetImage(Assets.logoSVG),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(widget.title),
            Text(widget.description),
            Text(widget.author),
            Text(widget.name),
          ],
        ),
      ),
    );
  }
}
