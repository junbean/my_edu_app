import 'package:flutter/material.dart';

class PaginationPage extends StatefulWidget {
  const PaginationPage({super.key});

  @override
  State<PaginationPage> createState() => _PaginationPageState();
}

class _PaginationPageState extends State<PaginationPage> {
  final ScrollController _scrollController = ScrollController();
  final List<int> _items = List.generate(20, (i) => i);
  bool _isLoading = false;
  bool _hasMore = true;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // maxScrollExtent - 200: 끝에서 200px 남았을 때 미리 로드 시작
    final triggerPoint = _scrollController.position.maxScrollExtent - 200;
    if (_scrollController.position.pixels >= triggerPoint && !_isLoading && _hasMore) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    setState(() => _isLoading = true);

    // 실제 API 호출을 흉내낸 지연
    await Future.delayed(const Duration(seconds: 1));

    // 5페이지(총 120개) 이후 데이터 없음으로 가정
    if (_page >= 5) {
      setState(() {
        _hasMore = false;
        _isLoading = false;
      });
      return;
    }

    final nextBatch = List.generate(20, (i) => _items.length + i);

    setState(() {
      _items.addAll(nextBatch);
      _page++;
      _isLoading = false;
    });
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
        title: Text('페이지 네이션 연습'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _items.length + 1, // 마지막 인덱스는 로딩/끝 표시용
        itemBuilder: (context, index) {
          if (index < _items.length) {
            return ListTile(title: Text('아이템 ${_items[index]}'));
          }
          // 마지막 인덱스 처리
          if (_hasMore) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: Text('더 이상 데이터가 없습니다')),
          );
        },
      )
    );
  }
}