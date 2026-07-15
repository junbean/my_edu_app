import 'package:flutter/material.dart';

class WrapPage extends StatefulWidget {
  const WrapPage({super.key});

  @override
  State<WrapPage> createState() => _WrapPageState();
}

class _WrapPageState extends State<WrapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Wrap Page"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // row와 wrap의 비교
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(width: 300, height: 50, color: Colors.red),
                      Container(width: 300, height: 50, color: Colors.green),
                      Container(width: 300, height: 50, color: Colors.blue),
                    ],
                  ),
                  SizedBox(height: 20),
                  Wrap(
                    children: [
                      Container(width: 300, height: 50, color: Colors.red),
                      Container(width: 300, height: 50, color: Colors.green),
                      Container(width: 300, height: 50, color: Colors.blue),
                    ],
                  )
                ]
              ),
            ),
            Divider(),


            // wrap의 spacing, runSpacing
            Container(
              padding: EdgeInsets.all(16),
              child: Wrap(
                spacing: 10,     // 같은 줄 안, 항목과 항목 사이 (가로 간격)
                runSpacing: 30,  // 줄과 줄 사이 (세로 간격)
                children: [
                  Container(width: 150, height: 50, color: Colors.red),
                  Container(width: 150, height: 50, color: Colors.green),
                  Container(width: 150, height: 50, color: Colors.blue),
                  Container(width: 150, height: 50, color: Colors.orange),
                ],
              )
            ),
            Divider(),


            // 

          ],
        )
      )
    );
  }
}