import 'package:flutter/material.dart';

class WrapPage extends StatefulWidget {
  const WrapPage({super.key});

  @override
  State<WrapPage> createState() => _WrapPageState();
}

class _WrapPageState extends State<WrapPage> {
  final List<String> _all = [
    '전체',
    'Flutter',
    'Dart',
    'SQL',
    'C#',
    'Java',
    'Python',
    '개발',
    '레이아웃',
    '위젯',
    '프로그래밍',
    '앱개발',
  ];
  final Set<String> _selected = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Wrap Page"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // row와 wrap의 비교
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(width: 300, height: 50, color: Colors.red),
                      Container(width: 300, height: 50, color: Colors.green),
                      Container(width: 300, height: 50, color: Colors.blue),
                    ],
                  ),
                  SizedBox(height: 20),
                  Wrap(
                    children: [
                      Container(width: 300, height: 50, color: Colors.red),
                      Container(width: 300, height: 50, color: Colors.green),
                      Container(width: 300, height: 50, color: Colors.blue),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),

            // wrap의 spacing, runSpacing
            Container(
              padding: EdgeInsets.all(16),
              child: Wrap(
                spacing: 10, // 같은 줄 안, 항목과 항목 사이 (가로 간격)
                runSpacing: 30, // 줄과 줄 사이 (세로 간격)
                children: [
                  Container(width: 150, height: 50, color: Colors.red),
                  Container(width: 150, height: 50, color: Colors.green),
                  Container(width: 150, height: 50, color: Colors.blue),
                  Container(width: 150, height: 50, color: Colors.orange),
                ],
              ),
            ),
            Divider(),

            // wrap의 alignment
            // alignment는 한 줄(run) 안에서 항목들을 주축(가로) 방향으로 어떻게 분포할지 정한다
            Container(
              padding: EdgeInsets.all(16),
              child: Wrap(
                alignment: WrapAlignment.end, // 정렬
                spacing: 10, // 같은 줄 안, 항목과 항목 사이 (가로 간격)
                runSpacing: 30, // 줄과 줄 사이 (세로 간격)
                children: [
                  Container(width: 150, height: 50, color: Colors.red),
                  Container(width: 150, height: 50, color: Colors.green),
                  Container(width: 150, height: 50, color: Colors.blue),
                  Container(width: 150, height: 50, color: Colors.orange),
                ],
              ),
            ),
            Divider(),

            // wrap의 runAlignment
            // runAlignment는 여러 줄(run)이 생겼을 때, 줄 묶음 전체를 교차축(세로) 방향으로 어떻게 정렬할지 정
            Container(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                height: 300, // ← 세로 여백이 있어야 runAlignment 효과가 보임
                child: Wrap(
                  runAlignment: WrapAlignment.end, // ← 줄 묶음을 세로 시작 위치로
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(8, (i) {
                    return Container(
                      width: 100,
                      height: 40,
                      color: Colors.blue,
                    );
                  }),
                ),
              ),
            ),
            Divider(),

            // wrap의 direction
            // direction은 항목들을 배치할 방향을 정한다
            Container(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                height: 250, // 세로 배치는 세로 공간이 있어야 넘침이 발생
                child: Wrap(
                  direction: Axis.vertical, // ← 세로로 쌓다가 넘치면 옆 칸으로
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(16, (i) {
                    return Container(
                      width: 80,
                      height: 40,
                      color: Colors.green,
                    );
                  }),
                ),
              ),
            ),
            Divider(),

            // wrap으로 칩 구성
            Container(
              padding: EdgeInsets.all(16),
              child: Wrap(
                spacing: 8, // 칩 사이 가로 간격
                runSpacing: 8, // 줄 사이 세로 간격
                children:
                    [
                      '#Flutter',
                      '#Dart',
                      '#개발',
                      '#레이아웃',
                      '#위젯',
                      '#프로그래밍',
                      '#앱개발',
                    ].map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.blue.shade200),
                        ),
                        child: Text(
                          tag,
                          style: TextStyle(
                            color: Colors.blue.shade700,
                            fontSize: 13,
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
            Divider(),

            // 선택 칩 wrap 구성
            Container(
              padding: EdgeInsets.all(16),
              child: Wrap(
                spacing: 8, // 칩 사이 가로 간격
                runSpacing: 8, // 줄 사이 세로 간격
                children: _all.map((label) {
                  final bool isSelected = _selected.contains(label);
                  return FilterChip(
                    label: Text(label),
                    selected: isSelected,
                    onSelected: (bool value) {
                      setState(() {
                        // 선택돼 있으면 해제, 아니면 추가 (토글)
                        if (isSelected) {
                          _selected.remove(label);
                        } else {
                          _selected.add(label);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            Divider(),

            // 키워드 wrap이 있는 textfield
            Container(padding: EdgeInsets.all(16), child: KeywordInput()),
            Divider(),

            // 버튼 그룹 wrap
            Container(
              padding: EdgeInsets.all(16),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ['저장', '취소', '삭제', '공유', '내보내기', '나가기', '만들기', '선택하기']
                    .map((label) {
                      return ElevatedButton(
                        onPressed: () {},
                        child: Text(label),
                      );
                    })
                    .toList(),
              ),
            ),
            Divider(),

            // wrap의 crossAxisAlignment
            // crossAxisAlignment (줄 안에서 높이가 다른 항목의 세로 정렬)
            Container(
              padding: EdgeInsets.all(16),
              child: Wrap(
                spacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center, // ← 값을 바꿔가며 실험
                children: [
                  Container(width: 60, height: 30, color: Colors.red),
                  Container(width: 60, height: 60, color: Colors.green), // 더 높음
                  Container(width: 60, height: 45, color: Colors.blue),
                ],
              ),
            ),
            Divider(),

            // Wrap은 Expanded/Flexible을 자식으로 못 받습니다.
            // 비율 배분이 필요하면 Row를, 줄바꿈이 필요하면 Wrap을 쓰는 식으로 목적이 갈

            // 개수가 고정이고 한 줄에 확실히 들어가면 → Row (더 가볍고 Expanded 등 flex 위젯 사용 가능)
            // 개수가 가변이거나 항목 폭 합이 화면을 넘을 수 있으면 → Wrap (자동 줄바꿈).
            Container(
              padding: EdgeInsets.all(16),
              child: Container(
                width: 300,
                decoration: BoxDecoration(color: Colors.grey),
                child: Wrap(
                  textDirection: TextDirection.rtl, // 오른쪽에서 왼쪽으로 순서대로 배치
                  children: const [
                    Chip(label: Text('첫 번째 (우측)')),
                    Chip(label: Text('두 번째')),
                    Chip(label: Text('세 번째 (좌측)')),
                  ],
                ),
              ),
            ),
            Divider(),

            ///
            Wrap(
              verticalDirection: VerticalDirection.up, // 줄이 아래에서 위로 생성됨
              children: List.generate(
                8,
                (index) => Chip(
                  label: Text('항목 $index', style: TextStyle(fontSize: 24)),
                ),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}

class KeywordInput extends StatefulWidget {
  const KeywordInput({super.key});
  @override
  State<KeywordInput> createState() => _KeywordInputState();
}

class _KeywordInputState extends State<KeywordInput> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _keywords = [];

  void _addKeyword(String value) {
    final text = value.trim();
    if (text.isEmpty) return; // 빈 입력 무시
    if (_keywords.contains(text)) return; // 중복 무시
    setState(() {
      _keywords.add(text);
      _controller.clear(); // 입력창 비우기
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // 컨트롤러 정리 (메모리 누수 방지)
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: '키워드 입력 후 엔터',
            border: OutlineInputBorder(),
          ),
          onSubmitted: _addKeyword, // 엔터 시 추가
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _keywords.map((word) {
            return Container(
              padding: const EdgeInsets.only(
                left: 12,
                right: 6,
                top: 4,
                bottom: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min, // ← 칩이 내용만큼만 (중요)
                children: [
                  Text(word),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      setState(() => _keywords.remove(word));
                    },
                    child: const Icon(Icons.close, size: 16),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
