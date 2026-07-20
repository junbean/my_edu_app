import 'package:flutter/material.dart';

class RowColumnPage extends StatefulWidget {
  const RowColumnPage({super.key});

  @override
  State<RowColumnPage> createState() => _RowColumnPageState();
}

class _RowColumnPageState extends State<RowColumnPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("로우/컬럼 연습 페이지"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            // 주축 정리 
            // spaceBetween: 자식들 사이에만 균등하게 빈 공간 분배 (첫/마지막 자식 주변엔 공간 없음)
            // spaceAround: 자식들 사이, 그리고 첫/마지막 자식 주변에 균등하게 빈 공간 분배
            // spaceEvenly: spaceAround와 유사하지만, 모든 간격(시작~첫번째, 자식들 사이, 마지막~끝)이 정확히 동일

            // 교차축 정리
            // start: 교차축 시작점에 정렬
            // end: 교차축 끝점에 정렬
            // center: 교차축 중앙에 정렬
            // stretch: 교차축 전체를 채우도록 정렬(높이/너비가 null인 경우에만 적용됨)
            Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.center,
              child: Column(
                children: [
                  // 컬럼
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          color: Colors.red,
                          width: 50,
                          height: 50,
                        ),
                        Container(
                          color: Colors.green,
                          width: 50,
                          height: 50,
                        ),
                        Container(
                          color: Colors.blue,
                          width: 50,
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                  Divider(),

                  // 로우
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          color: Colors.red,
                          width: 50,
                          height: 50,
                        ),
                        Container(
                          color: Colors.green,
                          width: 50,
                          height: 50,
                        ),
                        Container(
                          color: Colors.blue,
                          width: 50,
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                ]
              ),
            ),
            
            // 공간 배분 - Expanded
            Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.center,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(height: 100, color: Colors.red),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(height: 100, color: Colors.green),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(height: 100, color: Colors.blue),
                  ),
                ],
              )
            ),
            Divider(),

            // 공간 배분 - spacer
            // spaceBetween와 비슷
            Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.center,
              child: Row(
                children: [
                  Container(height: 100, width: 50, color: Colors.red),
                  Spacer(),
                  Container(height: 100, width: 50, color: Colors.green),
                  Spacer(flex: 1),
                  Container(height: 100, width: 50, color: Colors.blue),
                  Spacer(flex: 2),
                  Container(height: 100, width: 50, color: Colors.orange),
                ],
              )
            ),
            Divider(),

            // 공간 배분 - Flexible
            // Expanded = fit: FlexFit.tight(기본값) → "할당된 공간을 꽉 채워라" (자식이 작아도 강제로 늘림)
            // Flexible = fit: FlexFit.loose(기본값) → "최대 이만큼까지만 쓸 수 있고, 자식이 작으면 작은 대로 둬라"
            Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.center,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(width: 50, height: 80, color: Colors.red),
                  ),
                  // Flexible: 자식 width 50을 존중해서 딱 50만 차지 - FlexFit.tight로 수정해서 Expanded처럼 꽉 채우도록 수정이 가능
                  Flexible(
                    flex: 1,
                    child: Container(width: 50, height: 80, color: Colors.blue),
                  ),
                ],
              )
            ),
            Divider(),

            // 리스트 아이템 
            Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.center,
              child: Row(
                children: [
                  Icon(Icons.folder, size: 50, color: Colors.orange),
                  SizedBox(width: 10),

                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Text("제목", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text("설명글이 들어가는 부분입니다."),
                      ],
                    )
                  ),

                  Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
                ]
              ) 
            ),
            Divider(),

            // 카드 형식
            Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // ← 세로로 딱 내용만큼만 (중요)
                  children: [
                    // 원형 아바타 (이전 Container 장식 연습 결합)
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade300,
                        border: Border.all(color: Colors.blue, width: 2),
                      ),
                      child: const Icon(Icons.person, size: 40, color: Colors.grey),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      '홍길동',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 12),

                    // 팔로워/팔로잉을 가로로 배치
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Column(
                          children: [
                            Text('1.2k', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('팔로워', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                        SizedBox(width: 32),
                        Column(
                          children: [
                            Text('340', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('팔로잉', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )  
            ),
            Divider(),

            // 텍스트 짤림
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  // 상품명: 남는 공간 차지 + 길면 ...으로 자름
                  Expanded(
                    child: Text(
                      '아주 긴 상품명이 들어가면 이 텍스트는 한 줄을 넘어가게 됩니다',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis, // 넘치면 ...으로 표시
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // 가격: 고정 크기, 항상 오른쪽에 온전히 표시
                  const Text(
                    '29,000원',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Divider(),


            // Row/Column 에러 

            // 가로 너비를 넘어가서 overflow 에러 발생 -> 노란/검은 줄 표시
            // overflow: 부모가 준 공간보다 자식이 더 크다 (넘침)
            Container(
              padding: EdgeInsets.all(16),  
              child: Row(
                children: [
                  Container(width: 200, height: 80, color: Colors.red),
                  Container(width: 200, height: 80, color: Colors.green),
                  Container(width: 200, height: 80, color: Colors.blue),
                ]
              ),
            ),
            Divider(),

            // 해결방법 - Row를 SingleChildScrollView로 감싸서 스크롤 가능하게 만들기
            // 또는 자식들에게 Expanded/Flexible를 적용해서 부모가 준 공간 안에서만 차지하도록 만들기
            // 텍스트라면 expanded, TextOverflow.ellipsis를 사용
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(width: 200, height: 80, color: Colors.red),
                  Container(width: 200, height: 80, color: Colors.green),
                  Container(width: 200, height: 80, color: Colors.blue),
                ]
              ),
            ),
            Divider(),


            // unbounded: 부모가 자식에게 줄 크기 제약이 아예 없다 (무한대)
            // 대표적인 재현은 Column 안에 ListView를 조건 없이 넣는 경우
            // Column은 세로 방향으로 자식에게 높이는 너가 원하는 만큼 가지게 줌
            // 그런데 ListView는 스크롤 위젯이라, 자기 높이를 정하려면 부모가 높이를 정해줘야 한다
            //    -부모가 높이를 정해주지 않으면 얼마나 커야하는지 알수 없음
            /* 에러발생
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  ListView(   // ← 에러 발생
                    children: [
                      Text('항목1'),
                      Text('항목2'),
                    ],
                  ),
                ],
              ),
            ),
            */

            // 해결방법 - ListView를 Column 안에 넣고 싶으면, ListView를 Expanded/Flexible로 감싸서 부모가 준 공간 안에서만 차지하도록 만들기
                // -근데 이 방법은 Column의 최상위 부모가 SingleChildScrollView이면 안됨 (스크롤이 중첩되므로)
                // -해당 위젯은 내부 자식들이 스크롤될 수 있도록 세로 제약 조건을 무한대로 열어준다
                // -Column 안에서 Expanded를 쓰면, "무한대의 공간 중 남은 공간을 다 차지해라"라는 명령이 된다
                // -주의) 예를 들어 container(height:300) -> column -> listview 이렇게 구성하더라도 에러가 발생함(column안에서 쓸려면 listview를 expanded 또는 sizedbox, shrinkWrap을 true로 설정 필요)
            // 또는 SizedBox/Container로 높이를 지정해서 부모가 준 공간 안에서만 차지하도록 만들기
            // 또는 shrinkWrap: true를 지정해서 ListView가 자식들의 높이만큼만 차지하도록 만들기(단, 항목이 많으면 성능상 좋지 않음)
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    child: ListView(
                      children: [
                        Text('항목1', style: TextStyle(fontSize: 20, backgroundColor: Colors.yellow)),
                        Text('항목2', style: TextStyle(fontSize: 20, backgroundColor: Colors.green)),
                        Text('항목3', style: TextStyle(fontSize: 20, backgroundColor: Colors.deepOrangeAccent)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(),

            // shrinkWrap 사용
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  ListView(
                    shrinkWrap: true,
                    children: [
                      Text('항목1', style: TextStyle(fontSize: 20, backgroundColor: Colors.yellow)),
                      Text('항목2', style: TextStyle(fontSize: 20, backgroundColor: Colors.green)),
                      Text('항목3', style: TextStyle(fontSize: 20, backgroundColor: Colors.deepOrangeAccent)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}