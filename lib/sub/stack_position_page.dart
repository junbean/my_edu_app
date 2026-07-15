import 'package:flutter/material.dart';

class StackPositionPage extends StatefulWidget {
  const StackPositionPage({super.key});

  @override
  State<StackPositionPage> createState() => _StackPositionPageState();
}

class _StackPositionPageState extends State<StackPositionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("스택 위치 연습 페이지"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Stack의 쌓음
            Container(
              padding: EdgeInsets.all(16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 300,
                    height: 300,
                    color: Colors.red,
                  ),
                  Container(
                    width: 200,
                    height: 200,
                    color: Colors.green,
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            Divider(),
          
            // positioned를 이용한 위치 지정
            // Positioned는 자식을 Stack의 네 모서리 기준 픽셀 좌표로 배치
            Container(
              padding: EdgeInsets.all(16),
              child: Stack(
                children: [
                  Container(
                    width: 300,
                    height: 300,
                    color: Colors.red,
                  ),
                  Positioned(
                    left: 50,
                    top: 50,
                    child: Container(
                      width: 200,
                      height: 200,
                      color: Colors.green,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),

            // Positioned 없는 자식
            // Stack 안에서 Positioned로 감싸지 않은 자식은 Stack의 alignment 속성을 따라 배치됨
            Container(
              padding: EdgeInsets.all(16),
              child: Stack(
                alignment: Alignment.center, // ← 이 값이 Positioned 없는 자식들의 기준
                children: [
                  Container(width: 200, height: 200, color: Colors.grey.shade300),
                  Container(width: 100, height: 100, color: Colors.blue), // Positioned 없음
                ],
              )
            ),
            Divider(),




            /// position의 고유 속성
            Container(
              padding: EdgeInsets.all(16),
              child: Stack(
                children: [
                  // 배경 (Stack 크기를 결정하는 자식)
                  Container(width: 300, height: 200, color: Colors.blue),

                  // 그 위에 반투명 검정 오버레이를 꽉 채움
                  // Positioned(top: 0, right: 0, bottom: 0, left: 0)의 축약형
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.4),
                    ),
                  ),

                  // 오버레이 위 텍스트
                  const Positioned(
                    bottom: 16,
                    left: 16,
                    child: Text('제목', style: TextStyle(color: Colors.white)),
                  ),
                ],
              )
            ),
            Divider(),


            // postioned top+bottom 동시 → 세로로 늘어남
            // 마주 보는 두 방향을 동시에 주면 자식이 그 사이로 늘어납니다(stretch).
            Container(
              padding: EdgeInsets.all(16),
              child: Stack(
                children: [
                  Container(width: 300, height: 200, color: Colors.grey.shade300),
              
                  // 왼쪽에 세로로 꽉 찬 얇은 바
                  Positioned(
                    top: 0,
                    bottom: 0,   // top+bottom 동시 → 세로로 늘어남
                    left: 0,
                    width: 25,    // 가로는 25로 고정
                    child: Container(color: Colors.red),
                  ),
                ],
              ),
            ),
            Divider(),


            // clipBehavior: 자식이 Stack 경계 밖으로 삐져나갈 때, 그 부분을 잘라낼지 말지를 정함
            // Stack은 기본적으로 자식이 Stack 영역을 벗어나도 잘려서 보이지 않음
            // Clip.none: 삐져나간 부분을 자르지 않고 그대로 보여줍니다. 빨간 박스의 위쪽 20px이 회색 영역 밖으로 나와도 다 보입니다.
            // Clip.hardEdge: Stack 경계를 넘어간 부분을 잘라냅니다. 빨간 박스의 위쪽 20px이 잘려 안 보입니다.
            Container(
              padding: EdgeInsets.all(16),
              child: Stack(
                clipBehavior: Clip.none, // ← Clip.hardEdge와 바꿔가며 비교
                children: [
                  Container(width: 200, height: 200, color: Colors.grey.shade300),

                  // Stack 위쪽 경계 밖으로 나가는 박스
                  Positioned(
                    top: -20,   // 음수 → Stack 위로 삐져나감
                    left: 20,
                    child: Container(width: 60, height: 60, color: Colors.red),
                  ),
                ],
              )
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Stack(
                clipBehavior: Clip.hardEdge, // ← Clip.hardEdge와 바꿔가며 비교
                children: [
                  Container(width: 200, height: 200, color: Colors.grey.shade300),

                  // Stack 위쪽 경계 밖으로 나가는 박스
                  Positioned(
                    top: -20,   // 음수 → Stack 위로 삐져나감
                    left: 20,
                    child: Container(width: 60, height: 60, color: Colors.green),
                  ),
                ],
              )
            ),
            Divider(),
  

            // 이미지 그라데이션 + 텍스트
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  // 1) 이미지 (여기선 색으로 대체)
                  Container(
                    width: 300,
                    height: 200,
                    color: Colors.blueGrey,
                    // 실제로는: Image.network('...', width: 300, height: 200, fit: BoxFit.cover)
                  ),

                  // 2) 그라데이션 오버레이 (Stack 전체를 덮음)
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,               // 위: 투명
                            Colors.black.withValues(alpha: 0.7), // 아래: 어두움
                          ],
                        ),
                      ),
                    ),
                  ),

                  // 3) 하단 좌측 텍스트
                  const Positioned(
                    left: 16,
                    bottom: 16,
                    child: Text(
                      '영화 제목',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),

            // 플로팅 버튼 겹치기
            Stack(
              clipBehavior: Clip.none, // ← 없으면 삐져나온 버튼이 잘림 (필수)
              children: [
                // 카드 본체
                Container(
                  width: 300,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 8),
                    ],
                  ),
                ),

                // 우측 하단 모서리에 걸치는 원형 버튼
                Positioned(
                  bottom: -20, // 카드 아래로 20px 삐져나감
                  right: 20,
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 6),
                      ],
                    ),
                    child: const Icon(Icons.edit, color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40), 
            Divider(),


            // 프로필 헤더 오버랩
            Stack(
              clipBehavior: Clip.none,
              children: [
                // 배너 (배경 이미지 자리)
                Container(
                  width: double.infinity,
                  height: 150,
                  color: Colors.indigo,
                  // 실제로는: Image.network('...', fit: BoxFit.cover)
                ),

                // 배너 경계에 절반 걸친 원형 아바타
                Positioned(
                  top: 150 - 50, // 배너 높이(150) - 아바타 반지름(50) = 100
                  left: 20,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade300,
                      border: Border.all(color: Colors.white, width: 4), // 흰 테두리로 분리감
                    ),
                    child: const Icon(Icons.person, size: 50, color: Colors.grey),
                  ),
                ),
              ],
            ),
            SizedBox(height: 80), 
            Divider(),


            /// 뱃지 위치 세밀 조정
            Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.notifications, size: 40),

                Positioned(
                  top: -6,    // 위로 6px
                  right: -6,  // 오른쪽으로 6px (음수 = 아이콘 밖)
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      '9',
                      style: TextStyle(color: Colors.white, fontSize: 11, height: 1),
                    ),
                  ),
                ),
              ],
            ),
            Divider(),


            // 커스텀 진행 표시 (LinearProgressIndicator 직접 구현)
            // progress: 0.0 ~ 1.0 사이 값 (예: 0.6 = 60%)
            Container(
              padding: EdgeInsets.all(16),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final double progress = 0.6;
                  final double fullWidth = constraints.maxWidth; // 사용 가능한 전체 폭
              
                  return Stack(
                    children: [
                      // 배경 바 (회색, 전체 폭)
                      Container(
                        width: fullWidth,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
              
                      // 진행 바 (파랑, 진행률만큼의 폭)
                      Container(
                        width: fullWidth * progress, // ← 핵심: 전체 폭 × 진행률
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Divider(),

            // 드래그로 움직이는 박스 (심화 · StatefulWidget)


          ]
        )
      )
    );
  }
}