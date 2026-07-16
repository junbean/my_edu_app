import 'package:flutter/material.dart';

class RefreshIndicatorPage extends StatefulWidget {
  const RefreshIndicatorPage({super.key});

  @override
  State<RefreshIndicatorPage> createState() => _RefreshIndicatorPageState();
}

class _RefreshIndicatorPageState extends State<RefreshIndicatorPage> {
  List<String> _items = List.generate(15, (i) => '항목 $i');

  Future<void> _refresh() async {
    // 서버에서 최신 데이터를 다시 받아온다고 가정
    await Future.delayed(const Duration(seconds: 1, milliseconds: 500));

    setState(() {
      _items = List.generate(15, (i) => '갱신된 항목 $i (${DateTime.now().second}초)');
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.builder(
        // 리스트가 짧아도 항상 스크롤이 가능하게 해야
        // 당겨서 새로고침 제스처가 항상 인식됩니다.
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: _items.length,
        itemBuilder: (context, index) => ListTile(
          leading: const Icon(Icons.article),
          title: Text(_items[index]),
        ),
      ),
    );
  }
}