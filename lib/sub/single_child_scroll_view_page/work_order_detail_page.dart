import 'package:flutter/material.dart';

class WorkOrderDetailPage extends StatefulWidget {
  const WorkOrderDetailPage({super.key});

  @override
  State<WorkOrderDetailPage> createState() => _WorkOrderDetailPageState();
}

class _WorkOrderDetailPageState extends State<WorkOrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('작업지시서 상세')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상단 요약 정보 (고정 폼 형태)
            _buildSummarySection(),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 8),
            Text(
              '공정 이력',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),

            // DataTable은 자체 스크롤이 없으므로
            // 가로 폭이 화면보다 좁을 때는 그냥 배치해도 되지만
            // 열이 많아지면 아래 2번 예제처럼 가로 스크롤 처리가 필요함
            _buildHistoryTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildSummarySection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _InfoRow(label: '작업지시번호', value: 'WO-2026-0719-001'),
            _InfoRow(label: '품목명', value: '샤프트 어셈블리 A'),
            _InfoRow(label: '공정', value: '가공 → 조립 → 검사'),
            _InfoRow(label: '지시수량', value: '1,200 EA'),
            _InfoRow(label: '상태', value: '진행중'),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryTable() {
    final rows = List.generate(15, (i) => i);
    return DataTable(
      columns: const [
        DataColumn(label: Text('회차')),
        DataColumn(label: Text('공정')),
        DataColumn(label: Text('작업자')),
        DataColumn(label: Text('수량')),
        DataColumn(label: Text('시간')),
      ],
      rows: rows.map((i) {
        return DataRow(cells: [
          DataCell(Text('${i + 1}')),
          DataCell(Text(['가공', '조립', '검사'][i % 3])),
          DataCell(Text('작업자${i % 5}')),
          DataCell(Text('${80 + i}')),
          DataCell(Text('09:${10 + i}')),
        ]);
      }).toList(),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 100, child: Text(label, style: const TextStyle(color: Colors.grey))),
          Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }
}