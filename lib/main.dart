import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:my_edu_app/sub/button_page.dart';
import 'package:my_edu_app/sub/checkbox_page.dart';
import 'package:my_edu_app/sub/container_page.dart';
import 'package:my_edu_app/sub/drop_down_page.dart';
import 'package:my_edu_app/sub/flex_page.dart';
import 'package:my_edu_app/sub/list_grid_view_page.dart';
import 'package:my_edu_app/sub/pagination_page.dart';
import 'package:my_edu_app/sub/radio_page.dart';
import 'package:my_edu_app/sub/refresh_indicator_page.dart';
import 'package:my_edu_app/sub/row_column_page.dart';
import 'package:my_edu_app/sub/show_date_picker_page.dart';
import 'package:my_edu_app/sub/single_child_scroll_view_page.dart';
import 'package:my_edu_app/sub/single_child_scroll_view_page/floating_scroll_page.dart';
import 'package:my_edu_app/sub/single_child_scroll_view_page/normal_scroll_view_page.dart';
import 'package:my_edu_app/sub/single_child_scroll_view_page/over_flow_page.dart';
import 'package:my_edu_app/sub/single_child_scroll_view_page/row_scroll_page.dart';
import 'package:my_edu_app/sub/single_child_scroll_view_page/scroll_app_change_page.dart';
import 'package:my_edu_app/sub/single_child_scroll_view_page/wide_data_table_page.dart';
import 'package:my_edu_app/sub/single_child_scroll_view_page/work_order_detail_page.dart';
import 'package:my_edu_app/sub/slider_page.dart';
import 'package:my_edu_app/sub/stack_position_page.dart';
import 'package:my_edu_app/sub/switch_page.dart';
import 'package:my_edu_app/sub/text_field_page.dart';
import 'package:my_edu_app/sub/wrap_page.dart';

void main() async {
  // usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('ko_KR', null);    // 로케일 한글 표시하기 위함(DateFormatter에서 한글 요일 표시에 사용)

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      scrollBehavior: AppScrollBehavior(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'NotoSansKR',
        colorScheme: .fromSeed(seedColor: Colors.deepPurple)
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/flex_page': (context) => FlexPage(),
        '/button_page': (context) => ButtonPage(),
        '/text_field_page': (context) => TextFieldPage(),
        '/container_page': (context) => ContainerPage(),
        '/row_column_page': (context) => RowColumnPage(),
        '/stack_position_page': (context) => StackPositionPage(),
        '/wrap_page': (context) => WrapPage(),
        '/list_grid_view_page': (context) => ListGridViewPage(),
        '/pagination_page': (context) => PaginationPage(),
        '/refresh_indicator_page': (context) => RefreshIndicatorPage(),
        '/single_child_scroll_view_page': (context) => SingleChildScrollViewPage(),
        '/checkbox_page': (context) => CheckboxPage(),
        '/switch_page': (context) => SwitchPage(),
        '/radio_page': (context) => RadioPage(),
        '/slider_page': (context) => SliderPage(),
        '/drop_donw_page': (context) => DropDownPage(),
        '/show_date_picker_page': (context) => ShowDatePickerPage(),



        // SingleChildScrollView 하위
        '/single_child_scroll_view_page/0': (context) => OverFlowPage(),
        '/single_child_scroll_view_page/1': (context) => NormalScrollViewPage(),
        '/single_child_scroll_view_page/2': (context) => RowScrollPage(),
        '/single_child_scroll_view_page/3': (context) => ScrollAppChangePage(),
        '/single_child_scroll_view_page/4': (context) => FloatingScrollPage(),
        '/single_child_scroll_view_page/5': (context) => WorkOrderDetailPage(),
        '/single_child_scroll_view_page/6': (context) => WideDataTablePage(),
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
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              SizedBox(height: 16,),
                
              /// 초기에는 버튼의 child에 Container > Text로 구성함
              /// <- 이렇게 구성하면 버튼은 내부의 child의 최대 너비만큼 제공함, 그리고 Container는 자신이 가지느 최대만큼의 너비를 가지려고 함
              /// 첫번째 페이지
              PageButton(buttonText: 'flex 연습 페이지', url: '/flex_page'),
              SizedBox(height: 16,),
                
              /// 두번째 페이지
              PageButton(buttonText: '버튼 연습 페이지', url: '/button_page'),
              SizedBox(height: 16,),
                
              /// 세번째 페이지
              PageButton(buttonText: '텍스트 필드 연습 페이지', url: '/text_field_page'),
              SizedBox(height: 16,),
                
              /// 네번째 페이지
              PageButton(buttonText: '컨테이너 연습 페이지', url: '/container_page'),
              SizedBox(height: 16,),
                
              // 다섯번째 페이지
              PageButton(buttonText: '로우/컬럼 연습 페이지', url: '/row_column_page'),
              SizedBox(height: 16,),
                
              // 여섯번째 페이지
              PageButton(buttonText: '스택 위치 연습 페이지', url: '/stack_position_page'),
              SizedBox(height: 16,),
              
              // 일곱번째 페이지
              PageButton(buttonText: 'WRAP 연습 페이지', url: '/wrap_page'),
              SizedBox(height: 16,),
              
              // 8번째 페이지
              PageButton(buttonText: '리스트/그리드뷰 연습 페이지', url: '/list_grid_view_page'),
              SizedBox(height: 16,),
              
              // 9번째 페이지
              PageButton(buttonText: '페이지네이션 연습 페이지', url: '/pagination_page'),
              SizedBox(height: 16,),
              
              // 10번째 페이지
              PageButton(buttonText: 'pull-refresh 연습 페이지', url: '/refresh_indicator_page'),
              SizedBox(height: 16,),
              
              // 11번째 페이지
              PageButton(buttonText: 'SingleChildScrollView 연습 페이지', url: '/single_child_scroll_view_page'),
              SizedBox(height: 16,),
                
              // 12번째 페이지
              PageButton(buttonText: '체크박스 연습 페이지', url: '/checkbox_page'),
              SizedBox(height: 16,),
                
              // 13번째 페이지
              PageButton(buttonText: '스위치 연습 페이지', url: '/switch_page'),
              SizedBox(height: 16,),
                
              // 13번째 페이지
              PageButton(buttonText: '라디오 연습 페이지', url: '/radio_page'),
              SizedBox(height: 16,),

              // 14번째 페이지 - Slider/RangeSlider
              PageButton(buttonText: '슬라이더 연습 페이지', url: '/slider_page'),
              SizedBox(height: 16,),
              
              // 15번째 페이지 - dropdownMenu 추가 필요
              PageButton(buttonText: '드롭다운 연습 페이지', url: '/drop_donw_page'),
              SizedBox(height: 16,),

              PageButton(buttonText: '날짜 선택 연습 페이지', url: '/show_date_picker_page'),
              SizedBox(height: 16,),

              SizedBox(height: 16,),
            ],
          ),
        ),
      ),
    );
  }
}

class PageButton extends StatefulWidget {
  final String buttonText;
  final String url;

  const PageButton({super.key, required this.buttonText, required this.url});

  @override
  State<PageButton> createState() => _PageButtonState();
}

class _PageButtonState extends State<PageButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, widget.url),
      style: TextButton.styleFrom(
        shape: const ContinuousRectangleBorder(),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      child: Text(
        widget.buttonText,
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse, // ← 마우스 드래그 스크롤 허용!
    PointerDeviceKind.stylus,
  };
}