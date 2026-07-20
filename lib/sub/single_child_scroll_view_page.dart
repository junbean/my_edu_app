import 'package:flutter/material.dart';
import 'package:my_edu_app/main.dart';

class SingleChildScrollViewPage extends StatefulWidget {
  const SingleChildScrollViewPage({super.key});

  @override
  State<SingleChildScrollViewPage> createState() => _SingleChildScrollViewPageState();
}

class _SingleChildScrollViewPageState extends State<SingleChildScrollViewPage> {
  
  final ScrollController _scrollController = ScrollController();
  //bool _isScrolled = false; <- 앱바 스크롤 색상변경
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  // 스크롤 시 앱바의 색상 변경
  // void _onScroll() {
  //   final scrolled = _scrollController.offset > 10;
  //   // 상태가 실제로 바뀔 때만 setState 호출 (불필요한 리빌드 방지)
  //   if (scrolled != _isScrolled) {
  //     setState(() => _isScrolled = scrolled);
  //   }
  // }

  // 스크롤 임계값을 넘기면 
  void _onScroll() {
    final show = _scrollController.offset > 300;
    if (show != _showButton) {
      setState(() => _showButton = show);
    }
  }

  Future<void> _scrollToTop() {
    return _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('SingleChildScrollView 연습'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 기존의 Column은 세로 방향으로 자식을 배치할 때 부모가 제공하는 높이 제약을 넘어서는 안 됨
            //    Scaffold의 body는 기본적으로 화면 전체 높이를 Column에 전달하는데, 
            //    자식들의 합산 높이가 이보다 크면 RenderFlex overflowed by X pixels 에러가 발생
            //    화면이 완전히 깨지지는 않지만 노란/검정 줄무늬 경고 배너가 표시
            PageButton(buttonText: '오버플로우 발생', url: '/single_child_scroll_view_page/0'),
        
            // 기본적인 SingleChildScrollView 위젯 사용
            PageButton(buttonText: '기본적인 스크롤 위젯', url: '/single_child_scroll_view_page/1'),
            
            // 가로 스크롤 이미지 스트립
            PageButton(buttonText: '기본적인 스크롤 위젯', url: '/single_child_scroll_view_page/2'),
        
            /// 스크롤 시 AppBar 색상/그림자 변화
            ///   ScrollController.addListener로 매 프레임 스크롤 위치(offset)를 감지하고, 특정 임계값을 넘었는지 여부를 bool 상태로 관리
            ///   이 상태가 바뀔 때만 setState를 호출하여, 스크롤할 때마다 매번 리빌드가 발생하지 않도록 제어하는 것
            PageButton(buttonText: '스크롤시 앱바 색상 변경', url: '/single_child_scroll_view_page/3'),
        
            /// 스크롤 시 플로팅 버튼 생성
            PageButton(buttonText: '스크롤 플로팅 버튼 생성', url: '/single_child_scroll_view_page/4'),

            // 상세 정보 화면
            PageButton(buttonText: '상세 정보 화면', url: '/single_child_scroll_view_page/5'),

            // 가로+세로 동시 스크롤
            PageButton(buttonText: '가로+세로 동시 스크롤', url: '/single_child_scroll_view_page/6'),
          ],
        ),
      ),
    );
  }
}