import 'package:flutter/material.dart';

class FloatingScrollPage extends StatefulWidget {
  const FloatingScrollPage({super.key});

  @override
  State<FloatingScrollPage> createState() => _FloatingScrollPageState();
}

class _FloatingScrollPageState extends State<FloatingScrollPage> {
  final ScrollController _scrollController = ScrollController();
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

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
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: ListView.builder(
        controller: _scrollController,
        itemCount: 100,
        itemBuilder: (context, index) => ListTile(
          leading: CircleAvatar(child: Text('$index')),
          title: Text('아이템 $index'),
        ),
      ),
      floatingActionButton: AnimatedOpacity(
        opacity: _showButton ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 250),
        child: IgnorePointer(
          // opacity가 0일 때 버튼이 안 보여도 터치 영역은 남아있으므로
          // IgnorePointer로 탭 자체를 막아야 함
          ignoring: !_showButton,
          child: FloatingActionButton(
            onPressed: _scrollToTop,
            child: const Icon(Icons.arrow_upward),
          ),
        ),
      ),
    );
  }
}