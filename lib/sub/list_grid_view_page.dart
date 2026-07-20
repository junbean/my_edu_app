import 'package:flutter/material.dart';

class ListGridViewPage extends StatefulWidget {
  const ListGridViewPage({super.key});

  @override
  State<ListGridViewPage> createState() => _ListGridViewPageState();
}

class _ListGridViewPageState extends State<ListGridViewPage> {
  final List<String> names = ['김철수', '이영희', '박민수', /* ...수백 개 */];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('리스트뷰 연습'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 기본 ListView
            // itemBuilder ((context, index) → Widget) — .builder/.separated 전용. 
            //    각 항목을 index로 지연 생성하는 함수. 
            // itemCount (int?) — .builder/.separated에서 항목 총 개수. 
            //    생략하면 무한 리스트로 간주됩니다.
            // separatorBuilder ((context, index) → Widget) — .separated 전용. 
            //    항목 사이 구분자를 만드는 함수.
            // scrollDirection (Axis) — 스크롤 방향. 
            //    기본값 Axis.vertical(세로). 
            //    Axis.horizontal이면 가로 스크롤 리스트(캐러셀)가 됨

            // reverse (bool) — 기본 false. 
            //    true면 항목 순서가 뒤집혀 끝에서부터 표시되고 스크롤도 반대가 됩니다
            //    채팅 화면(최신 메시지가 아래)에서 자주 씀
            // controller (ScrollController?) — 스크롤 위치를 프로그래밍으로 제어·감지. 
            //    특정 위치로 이동, 스크롤 끝 감지(무한 스크롤), 
            //    현재 오프셋 읽기 등에 사용.
            // primary (bool?) — 이 리스트가 화면의 주 스크롤 뷰인지 여부. 
            //    true면 기기의 기본 ScrollController에 연결됩니다(예: 상단 탭바를 눌러 맨 위로 가는 동작). 
            //    보통 자동 처리되어 직접 건드릴 일은 적습니다.

            // physics (ScrollPhysics?) — 스크롤의 물리적 느낌을 정합니다.
            //    NeverScrollableScrollPhysics — 스크롤 비활성화(부모가 스크롤할 때 사용).
            //    BouncingScrollPhysics — iOS식 튕김.
            //    ClampingScrollPhysics — Android식 끝에서 멈춤.
            //    AlwaysScrollableScrollPhysics — 항목이 적어도 항상 스크롤 가능(RefreshIndicator와 함께 씀).
            // scrollBehavior (ScrollBehavior?) — 스크롤바 표시, 
            //    오버스크롤 효과 등 스크롤 관련 동작을 통째로 커스터마이징

            // shrinkWrap (bool) — 기본 false. 
            //    기본값에선 ListView가 스크롤 방향으로 가능한 최대 공간을 차지합니다. 
            //    true면 내용 높이만큼만 차지합니다. 
            //    Column 안에 ListView를 넣을 때(앞서 다룬 unbounded 에러 해결책 중 하나) 쓰지만, 모든 항목 크기를 미리 계산하므로 항목이 많으면 성능이 나빠집니다.
            // padding (EdgeInsetsGeometry?) — 리스트 내용 주변의 여백. 
            //    리스트 전체 가장자리 안쪽 여백(아이템 각각의 여백이 아님)
            // itemExtent (double?) — 모든 항목의 스크롤 방향 크기(세로 리스트면 높이)를 고정. 
            //    모든 항목 높이가 같다고 알려주면 Flutter가 스크롤 위치 계산을 최적화해 성능이 향상됩니다. 
            //    높이가 일정한 리스트에 유용
            // prototypeItem (Widget?) — itemExtent 대신, 샘플 위젯 하나를 주면 그 크기를 재서 모든 항목에 적용. 
            //    높이는 같지만 숫자로 특정하기 어려울 때 사용. 
            //    itemExtent와 동시 사용 불가

            // cacheExtent (double?) — 화면 밖으로 얼마나 더(픽셀 단위) 미리 항목을 생성해 둘지. 
            //    값을 키우면 스크롤이 더 부드럽지만 메모리를 더 쓴다
            // addAutomaticKeepAlives (bool) — 기본 true. 
            //    화면 밖으로 나간 항목의 상태를 유지할지. 
            //    보통 기본값을 둡
            // addRepaintBoundaries (bool) — 기본 true. 
            //    각 항목을 별도 repaint 경계로 감싸 다시 그리는 비용을 줄입니다. 
            //    보통 기본값 유지
            // addSemanticIndexes (bool) — 기본 true. 
            //    접근성(스크린 리더)을 위한 인덱스 정보 자동 추가
            // semanticChildCount (int?) — 
            //    접근성상 의미 있는 자식 수. 
            //    보통 자동 처리

            // keyboardDismissBehavior (ScrollViewKeyboardDismissBehavior) — 스크롤 시 키보드를 내릴지. 
            //    onDrag로 주면 리스트를 드래그할 때 열린 키보드가 자동으로 닫힙니다. 
            //    입력 필드가 있는 리스트에서 유용
            // dragStartBehavior (DragStartBehavior) — 드래그 제스처 시작 시점 계산 방식. 
            //    기본 start. 거의 건드리지 않습니다
            // clipBehavior (Clip) — 기본 Clip.hardEdge. 
            //    리스트 경계를 넘는 내용을 자를지 여부. (Stack의 clipBehavior와 같은 개념)
            // restorationId (String?) — 앱이 종료 후 복원될 때 스크롤 위치를 저장·복원하기 위한 식별자.
            // key (Key?) — 모든 위젯 공통. 위젯 식별용
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all()
              ),
              child: ListView(
                shrinkWrap: true,
                children: const [
                  ListTile(leading: Icon(Icons.home), title: Text('홈')),
                  ListTile(leading: Icon(Icons.person), title: Text('프로필')),
                  ListTile(leading: Icon(Icons.settings), title: Text('설정')),
                  Divider(),
                  ListTile(leading: Icon(Icons.logout), title: Text('로그아웃')),
                ],
              ), 
            ),
            Divider(),

            // ListView.builder
            // 항목을 미리 만들지 않고, 화면에 보이는 순간에만 그때그때 생성합니다
            // 핵심은 lazy loading(지연 생성): itemCount가 1000이어도 화면에 10개만 보이면 그 10개 부근만 생성
            // 스크롤하면 새로 보이는 항목이 생성되고, 화면 밖으로 나간 항목은 정리됩니다. 그래서 항목이 수천 개여도 메모리·성능이 안정적
            // itemCount: 전체 항목 수. 이걸 줘야 스크롤바 길이 등을 계산함
            // itemBuilder: (context, index): 각 항목을 만드는 함수. index(0부터 시작)로 데이터 리스트의 몇 번째인지 구분해 list[index]로 접근
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all()
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 20, // 항목 총 개수
                itemBuilder: (context, index) {
                  // index는 0 ~ 999. 각 항목이 보일 때마다 호출됨
                  return ListTile(
                    leading: CircleAvatar(child: Text('${index + 1}')),
                    title: Text('항목 ${index + 1}번'),
                  );
                },
              ),
            ),
            Divider(),


            // Listview.Builder - 실제 데이터와 연결
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all()
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: names.length, // 데이터 개수만큼
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(names[index]), // index로 데이터 접근
                  );
                },
              ),
            ),
            Divider(),



            // ListView.separated
            // (builder)와 거의 같은데, 항목 사이에 넣을 구분자(separator)를 만드는 빌더
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all()
              ),
              child: ListView.separated(
                itemCount: 20,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(title: Text('항목 $index'));
                },
                separatorBuilder: (context, index) {
                  // 항목과 항목 '사이'마다 호출됨
                  return const Divider(height: 1, color: Colors.grey);
                },
              ),
            ),


            Container(
              height: 50,
              color: Colors.grey,
            ),


            // GridView - 격자 배치
            // GridView.count - 열 개수 고정
            // children에 직접 나열 → 모든 항목 즉시 생성
            // 열 개수가 명확할 때(갤러리 3열 등) 가장 읽기 쉬운 생성자
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all()
              ),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,     // 3열
                crossAxisSpacing: 8,   // 열 사이 간격
                mainAxisSpacing: 8,    // 행 사이 간격
                padding: const EdgeInsets.all(8),
                children: List.generate(12, (index) {
                  return Container(
                    color: Colors.blue.shade200,
                    alignment: Alignment.center,
                    child: Text('$index'),
                  );
                }),
              ),
            ),
            Divider(),


            // GridView.extent — 항목 최대 폭 지정 (반응형)
            // .count가 "열 개수"를 정한다면, .extent는 "항목 하나의 최대 폭"을 정하고 열 수는 화면에 맞춰 자동 계산
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all()
              ),
              child: GridView.extent(
                shrinkWrap: true,
                maxCrossAxisExtent: 150, // 항목 최대 폭 150 → 열 수 자동
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                padding: const EdgeInsets.all(8),
                children: List.generate(12, (index) {
                  return Container(
                    color: Colors.orange.shade200,
                    alignment: Alignment.center,
                    child: Text('$index'),
                  );
                }),
              ),
            ),
            Divider(),



            // GridView.builder — 대량 격자의 표준
            // .builder로 보이는 항목만 lazy 생성하고, gridDelegate로 격자 규칙을 넘깁니다
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: GridView.builder(
                itemCount: 100,
                shrinkWrap: true,
                // gridDelegate - 격자를 어떻게 나눌지 정하는 규칙
                // gridDelegate에는 아래의 둘중 하나만 설정 가능함
                // SliverGridDelegateWithFixedCrossAxisCount - 열 개수를 직접 정함
                //    -crossAxisCount: 3이면 화면이 넓든 좁든 무조건 3열, 화면이 넓어지면 열 수는 그대로고 항목이 커짐
                // SliverGridDelegateWithMaxCrossAxisExtent - 항목 하나의 최대 폭을 정함
                //    -maxCrossAxisExtent: 150이면 열 수는 화면 폭에 맞춰 자동 계산됨. 화면이 넓어지면 열 수가 늘어나고 항목 크기는 비슷하게 유지
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75, // 가로/세로 비율(기본값은 1) - 세로로 긴 카드 (상품 카드용)
                ),
                padding: const EdgeInsets.all(12),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(color: Colors.grey),
                            // 실제로는 Image.network(..., fit: BoxFit.cover)
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8),
                          child: Text('상품 이름', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Divider(),


            // 메이슨리 레이아웃 -  각 항목이 자기 내용만큼의 높이를 갖고, 열마다 항목들이 벽돌 쌓듯이(masonry) 서로 다른 높이로 촘촘히 채워지는 형태
            // flutter의 gridView 위젯에서는 구현이 불가능 
            // 그래서 flutter_staggered_grid_view 외부 패키지를 사용함 - MasonryGridView위젯
            //




            // 이외에도 listview 배치 - (주로 listview가 높이를 알수 없을때 에러 발생)
            // scaffold -> container -> listview = 가능(scaffold의 body는 높이800px으로 지정함)
            // singlechildscrollview -> container -> listview = 불가
          ],
        ),
      ),
    );
  }
}