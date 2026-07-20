import 'package:flutter/material.dart';

class ScrollAppChangePage extends StatefulWidget {
  const ScrollAppChangePage({super.key});

  @override
  State<ScrollAppChangePage> createState() => _ScrollAppChangePageState();
}

class _ScrollAppChangePageState extends State<ScrollAppChangePage> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;   

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  // 스크롤 시 앱바의 색상 변경
  void _onScroll() {
    final scrolled = _scrollController.offset > 10;
    // 상태가 실제로 바뀔 때만 setState 호출 (불필요한 리빌드 방지)
    if (scrolled != _isScrolled) {
      setState(() => _isScrolled = scrolled);
    }
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
      appBar: AppBar(),
      backgroundColor: Colors.white,
      // SingleChildScrollView(scrollDirection: Axis.horizontal) + Row
      body: ListView.builder(
        controller: _scrollController,
        itemCount: 50,
        itemBuilder: (context, index) => ListTile(
          title: Text('아이템 $index'),
        ),
      ),
    );
  }
}