import 'package:flutter/material.dart';

class ContainerPage extends StatefulWidget {
  const ContainerPage({super.key});

  @override
  State<ContainerPage> createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("컨테이너 위젯 학습"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. 뱃지/칩 만들기
            Container(
              padding: EdgeInsets.all(16),
              alignment: .center,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.lightGreen,
                      border: BoxBorder.all(color: Colors.green, width: 2.0),
                    ),
                    child: Text(
                      "Chip 만들기",
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    ),
                  ),
                  SizedBox(height: 8),
                  Stack(
                    clipBehavior: Clip.none, // 모서리 밖으로 삐져나와도 안 잘리게
                    children: [
                      const Icon(Icons.notifications, size: 40),
                      Positioned(
                        right: -4,
                        top: -4,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          constraints: const BoxConstraints(
                            minWidth: 18, // 한 자리 숫자일 때 원형 유지
                            minHeight: 18,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            '3',
                            style: TextStyle(color: Colors.white, fontSize: 11),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),

            // 2. 원형 아바타 ~ing (ClipOval, CircleAvatar도 같음)
            Container(
              width: 50,
              height: 50,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black,
                //     spreadRadius: 5,
                //     // blurRadius: 7,
                //   )
                // ],
                shape: BoxShape.circle,
                border: Border.all(width: 2, color: Colors.black),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("resources/test.jpg"),
                ),
              ),
            ),
            Divider(),

            // 3. 그라데이션 배치
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.deepPurple, Colors.lightGreen],
                        stops: [0.0, 1.0],
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        center: Alignment.center,
                        radius: 0.5,
                        colors: [Colors.yellow, Colors.black],
                        stops: [0.0, 1.0],
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: SweepGradient(
                        center: Alignment.center,
                        startAngle: 0.0,
                        endAngle: 3.14 * 2, // 360도
                        colors: [Colors.deepOrangeAccent, Colors.indigo],
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent, // 위는 투명하게
                          Colors.black.withOpacity(0.7), // 아래는 반투명 검정
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),

            // 4. 그라데이션 버튼
            Container(
              padding: EdgeInsets.all(16),
              child: InkWell(
                onTap: () => print("클릭!"),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.cyan],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "그라데이션 버튼",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),

            // padding과 container 위젯의 비교
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.amber),
                    child: Text("Container 위젯"),
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.blueAccent),
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(8),
                      child: Text("Padding 위젯"),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),

            //
          ],
        ),
      ),
    );
  }
}
