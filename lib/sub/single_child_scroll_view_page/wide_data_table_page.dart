import 'package:flutter/material.dart';

class WideDataTablePage extends StatefulWidget {
  const WideDataTablePage({super.key});

  @override
  State<WideDataTablePage> createState() => _WideDataTablePageState();
}

class _WideDataTablePageState extends State<WideDataTablePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('넓은 조회 결과 (양방향 스크롤)')),
      body: SingleChildScrollView(
        // 바깥쪽: 세로 스크롤
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '재고 이동 이력 (열 10개)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),

            // 안쪽: 가로 스크롤
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              
              child: _buildWideTable(),
            ),

            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 8),

            // 세로 스크롤 확인용 더미 콘텐츠
            Text('추가 정보 영역', style: Theme.of(context).textTheme.titleMedium),
            ...List.generate(
              10,
              (i) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text('부가 설명 텍스트 라인 ${i + 1}'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWideTable() {
    final columns = [
      '이동번호', '품목코드', '품목명', '위치(From)', '위치(To)',
      '수량', '단위', '처리자', '처리일시', '비고',
    ];
    final rows = List.generate(20, (i) => i);

    return DataTable(
      columns: columns.map((c) => DataColumn(label: Text(c))).toList(),
      rows: rows.map((i) {
        return DataRow(cells: [
          DataCell(Text('MV-${1000 + i}')),
          DataCell(Text('ITM-${100 + i}')),
          DataCell(Text('부품 ${i % 5}')),
          DataCell(Text('A-0${i % 9}')),
          DataCell(Text('B-0${(i + 1) % 9}')),
          DataCell(Text('${10 + i}')),
          DataCell(Text('EA')),
          DataCell(Text('사원${i % 4}')),
          DataCell(Text('07/${10 + i % 20} 09:${i % 60}')),
          DataCell(Text(i % 3 == 0 ? '정상' : '')),
        ]);
      }).toList(),
    );
  }
}