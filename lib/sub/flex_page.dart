import 'package:flutter/material.dart';

class FlexPage extends StatefulWidget {
  const FlexPage({super.key});

  @override
  State<FlexPage> createState() => _FlexPageState();
}

class _FlexPageState extends State<FlexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('영역 배치'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: .center,
                      decoration: BoxDecoration(color: Colors.deepPurpleAccent),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: .center,
                            decoration: BoxDecoration(color: Colors.lightGreen),
                          ),
                        ),
                        Expanded(flex: 1,
                          child: Container(
                            alignment: .center,
                            decoration: BoxDecoration(color: Colors.pink),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.blueAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
