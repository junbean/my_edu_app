import 'package:flutter/material.dart';

class OverFlowPage extends StatefulWidget {
  const OverFlowPage({super.key});

  @override
  State<OverFlowPage> createState() => _OverFlowPageState();
}

class _OverFlowPageState extends State<OverFlowPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Column(
        children: List.generate(
          30,
          (index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${index + 1}번째 문단: 이 텍스트는 화면 높이를 초과시키기 위한 더미 텍스트입니다.',
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      )
    );
  }
}