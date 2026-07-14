import 'package:flutter/material.dart';
import 'package:my_edu_app/sub/button_page.dart';
import 'package:my_edu_app/sub/container_page.dart';
import 'package:my_edu_app/sub/flex_page.dart';
import 'package:my_edu_app/sub/text_field_page.dart';

void main() {
  // usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/flex_page': (context) => FlexPage(),
        '/button_page': (context) => ButtonPage(),
        '/text_field_page': (context) => TextFieldPage(),
        '/container_page': (context) => ContainerPage(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/memo':
            if (settings.arguments != null) {}
        }
      },
      //home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("플러터 학습 HOME"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            /// 초기에는 버튼의 child에 Container > Text로 구성함
            /// <- 이렇게 구성하면 버튼은 내부의 child의 최대 너비만큼 제공함, 그리고 Container는 자신이 가지느 최대만큼의 너비를 가지려고 함


            /// 첫번째 페이지
            PageButton(buttonText: 'flex 연습 페이지', url: '/flex_page'),

            /// 두번째 페이지
            PageButton(buttonText: '버튼 연습 페이지', url: '/button_page'),

            /// 세번째 페이지
            PageButton(buttonText: '텍스트 필드 연습 페이지', url: '/text_field_page'),

            /// 네번째 페이지
            PageButton(buttonText: '컨테이너 연습 페이지', url: '/container_page'),
          ],
        ),
      ),
    );
  }
}

class PageButton extends StatefulWidget {
  final String? buttonText;
  final String? url;

  const PageButton({super.key, this.buttonText, this.url});

  @override
  State<PageButton> createState() => _PageButtonState();
}

class _PageButtonState extends State<PageButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, widget.url!),
      style: TextButton.styleFrom(
        shape: const ContinuousRectangleBorder(),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      child: Text(
        widget.buttonText ?? '',
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}
