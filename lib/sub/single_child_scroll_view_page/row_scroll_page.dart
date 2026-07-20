import 'package:flutter/material.dart';

class RowScrollPage extends StatefulWidget {
  const RowScrollPage({super.key});

  @override
  State<RowScrollPage> createState() => _RowScrollPageState();
}

class _RowScrollPageState extends State<RowScrollPage> {
  final colors = [
    Colors.red, Colors.orange, Colors.yellow, Colors.green,
    Colors.blue, Colors.indigo, Colors.purple, Colors.pink,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      // SingleChildScrollView(scrollDirection: Axis.horizontal) + Row
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: colors.map((color) {
            return Container(
              width: 150,
              height: 150,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  // 실제 프로젝트에서는 NetworkImage나 AssetImage로 교체
                  image: NetworkImage('https://picsum.photos/150'),
                  fit: BoxFit.cover,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}