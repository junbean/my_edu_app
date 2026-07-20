import 'dart:ui';

import 'package:flutter/material.dart';

class RefreshIndicatorPage extends StatefulWidget {
  const RefreshIndicatorPage({super.key});

  @override
  State<RefreshIndicatorPage> createState() => _RefreshIndicatorPageState();
}

class _RefreshIndicatorPageState extends State<RefreshIndicatorPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  List<String> _items = List.generate(30, (i) => '항목 $i');

  Future<void> _refresh() async {
    // 서버에서 최신 데이터를 다시 받아온다고 가정
    await Future.delayed(const Duration(seconds: 1, milliseconds: 500));

    setState(() {
      _items = List.generate(30, (i) => '갱신된 항목 $i (${DateTime.now().second}초)');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('RefreshIndicator 연습'),
        centerTitle: true,
        // AppBar 오른쪽 상단에 새로고침 버튼 추가
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // 3. 버튼 클릭 시 수동으로 show() 메서드 호출 -> 인디케이터가 뜨며 _refresh 실행
              _refreshIndicatorKey.currentState?.show();
            },
          ),
        ],
        
      ),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        /// RefreshIndicator는 사용자가 리스트나 화면을 아래로 당겼다 놓을 때(Pull-to-Refresh 제스처), 최신 데이터를 다시 불러오는 동작을 구현할 때 사용하는 대표적인 Material Design 위젯
        /// RefreshIndicator는 내부적으로 화면의 스크롤 동작(ScrollNotification)을 감지
        /// 속성들
        ///   onRefresh: _handleRefresh, // 1. 필수: 새로고침 시 실행할 비동기 함수(반드시 async/Future 완료를 보장해야함)
        ///   color: Colors.blue,        // 선택: 인디케이터 로딩 선 색상(돌아가는 화살표 색상)
        ///   backgroundColor: Colors.white   선택: 인디케이터 동그라미 배경색
        ///   displacement: 40.0,        // 선택: 당겼을 때 인디케이터가 내려오는 위치, edge로부터 얼마나 내려와 멈출지 결정(기본값 40)
        ///   edgeOffset: 30.0   인디케이터가 나타나기 시작하는 시작점의 오프셋
        ///   triggerMode: onEdge    새로고침이 트리거되는 방식(onEdge: 최상단 경계에 도달한 후 더 당길 때만 작동(기본값),  anywhere: 스크롤 도중 상단 경계로 돌아오는 와중에도 트리거 가능)
        ///     onEdge: 스크롤 위치가 이미 최상단(Edge, 오프셋 0)에 닿아 있는 상태에서만 아래로 끌어당기는 제스처가 시작되어야 새로고침 동작이 트리거됨
        ///     anywhere: 스크롤 위치가 어디에 있었든 상관없이, 사용자가 위로 스크롤하여 최상단에 도달한 뒤 손가락을 떼지 않고 연속해서 아래로 계속 끌어당기면 즉시 새로고침이 트리거됨
        
        /// 주의) RefreshIndicator는 자식 위젯의 스크롤 제스처를 감지하여 구동됨
        ///   ListView 내부의 아이템이 1~2개뿐이라서 스크롤바 자체가 생기지 않는 상태가 되면 아래로 당겨도 RefreshIndicator가 동작하지 않음
        ///   ListView에 반드시 physics: const AlwaysScrollableScrollPhysics()를 설정해야 아이템 개수와 상관없이 항상 당겨서 새로고침이 작동함
        
        /// 주의) ListView 대신 SingleChildScrollView 내부에서 RefreshIndicator를 사용할 때도 마찬가지
        ///   SingleChildScrollView에 physics: const AlwaysScrollableScrollPhysics()를 걸어두어야 안전하게 동작함
        
        /// 주의) 수동으로 새로고침 트리거하기 (GlobalKey)
        ///   사용자가 직접 화면을 끌어내리지 않고, 상단 '새로고침 버튼' 등을 눌러서 프로그램적으로 RefreshIndicator 애니메이션을 띄우며 새로고침을 실행하고 싶을 때
        ///   GlobalKey<RefreshIndicatorState>를 사용함
        ///   key: _refreshIndicatorKey, // GlobalKey 연결
        onRefresh: _refresh,
        color: Colors.blue,
        backgroundColor: Colors.amberAccent,
        displacement: 20.0,
        edgeOffset: 30.0,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        key: _refreshIndicatorKey,
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          // 리스트가 짧아도 항상 스크롤이 가능하게 해야
          // 당겨서 새로고침 제스처가 항상 인식됩니다.
          itemCount: _items.length,
          itemBuilder: (context, index) => ListTile(
            leading: const Icon(Icons.article),
            title: Text(_items[index]),
          ),
        ),
      )
    );
  }
}
