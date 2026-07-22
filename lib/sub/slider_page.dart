import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  const SliderPage({super.key});

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double _sliderValue = 2.0;
  
  double _sliderEventValue = 5.0;
  String _whatEventDoing = "";

  double _sliderDivisionValue = 3.0;

  double _sliderStyleValue = 1.0;

  double _sliderIneractionValue = 6.0;

  double _sliderThemeValue = 9.0;

  double _sliderThemeNumValue = 1.0;
  double _sliderThemeIconValue = 1.0;

  double _sliderVerticalValue = 1.0;

  RangeValues _currentRangeValues = const RangeValues(20, 80);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('slider 연습 패이지'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          alignment: .topCenter,
          child: Column(
            children: [
              /// 기본적인 Slider사용 
              ///   value: 현재 슬라이더가 가리키고 있는 수치(double 자료형), min과 max 사이의 값
              ///   onChanged: 사용자가 슬라이더를 드래그하거나 클릭하여 값이 변경될 때 호출되는 콜백 함수 
              ///       -null로 지정하면 슬라이더가 비활성화(Disabled) 상태가 된다
              ///   onChangeStart: 사용자가 슬라이더 터치를 시작할 때 1회 호출된다
              ///   onChangeEnd: 사용자가 드래그를 마치고 손을 뗐을 때 1회 호출된다
              ///   min: 슬라이더가 가질 수 있는 최소값(기본값: 0.0), 자료형은 double
              ///   max: 슬라이더가 가질 수 있는 최대값(기본값: 1.0), 자료형은 double
              ///   division: 슬라이더 전체 범위를 나누는 구간(눈금)의 개수, 자료형은 int?
              ///       -지정하면 연속적인 값이 아닌 디스크리트(Discrete, 불연속적)한 단위로 이동한다
              ///   label: 드래그하는 동안 노브 위에 뜨는 툴팁 형태의 말풍선 텍스트
              ///       -divisions 속성이 설정되어 있을 때만 표시됨
              ///   activeColor / inactiveColor: 트랙 색상 및 노브 색상
              ///       -각각 선택, 선택되지 않은 범위의 색상
              ///   thumbColor: 슬라이더의 동그란 부분 색상 지정
              ///   secondaryTrackValue: 메인 value와 별개로 트랙 상에 진행률을 하나 더 표시할 때 사용
              ///       -이것도 min과 max의 사이값이여야 함
              ///       -약간 비디오 버퍼링바라고 생각하면 된다
              ///       -자료형은 double?
              ///   secondaryActiveColor: 보조 트랙 구간의 색상, 자료형은 double?
              ///   overlayColor: 슬라이더 노브를 클릭/드래그 할 때 퍼지는 원형 이펙트(ripple)의 색상을 상태별로 제어
              ///   autofocus: 화면이 열릴 때 슬라이더에 포커스를 자동으로 맞출지 여부
              ///   focusNode: 키보드 탐색이나 포커스 제어를 위해 별도의 FocusNode를 연결
              ///   semanticFormatterCallback: 스크린 리더(접근성 지원)가 현재 슬라이더의 값을 읽어줄 때 사용할 텍스트 포맷을 반환한다
              ///   allowedInteraction: 사용자가 슬라이더와 상호작용(터치/드래그)할 수 있는 방식을 지정한다
              ///       -SliderInteraction.slideAndTap: 슬라이딩 및 트랙 임의 지점 클릭 모두 허용 (기본값)
              ///       -SliderInteraction.slideOnly: 오직 손잡이를 잡고 드래그하는 것만 허용 (트랙 클릭 이동 방지)
              ///       -SliderInteraction.tapAndSlide: 클릭 후 드래그 허용
              ///       -SliderInteraction.tapOnly: 클릭으로만 위치 이동 허용
              /// 
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Slider(
                      value: _sliderValue,
                      min: 0.0,
                      max: 10.0,
                      onChanged: (value) {
                        setState(() {
                          _sliderValue = value;
                        });
                      },
                    ),
                  ),
                  Text('현재 슬라이더의 값: $_sliderValue')
                ],
              ),
              Divider(),

              /// onChangeStart와 onChangeEnd가 일어나는 시점
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Slider(
                      value: _sliderEventValue,
                      min: 0.0,
                      max: 10.0,
                      onChanged: (value) {
                        setState(() {
                          _sliderEventValue = value;
                          _whatEventDoing = "onChanged";
                          debugPrint("onChanged 발생");
                        });
                      },
                      onChangeStart: (value) {
                        setState(() {
                          _whatEventDoing = "onChangeStart";
                          debugPrint("onChangeStart 발생");
                        });
                      },
                      onChangeEnd: (value) {
                        setState(() {
                          _whatEventDoing = "onChangeEnd";
                          debugPrint("onChangeEnd 발생");
                        });
                      },
                    ),
                  ),
                  Text('현재 발생한 이벤트: $_whatEventDoing')
                ],
              ),
              Divider(),

              /// division과 label사용
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Slider(
                      value: _sliderDivisionValue,
                      min: 0.0,
                      max: 10.0,
                      divisions: 5,
                      label: '${_sliderDivisionValue.round()}점',
                      onChanged: (value) {
                        setState(() {
                          _sliderDivisionValue = value;
                        });
                      },
                    ),
                  ),
                  Text('현재 슬라이더의 값: $_sliderDivisionValue')
                ],
              ),
              Divider(),


              /// 슬라이더의 스타일
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Slider(
                      value: _sliderStyleValue,
                      min: 0.0,
                      max: 10.0,
                      activeColor: Colors.deepOrange, // slider의 범위 트랙 영역 및 노브(동그란거)
                      inactiveColor: Colors.lightGreen, // sldier의 범위 밖 트랙 영역
                      thumbColor: Colors.blueAccent,
                      onChanged: (value) {
                        setState(() {
                          _sliderStyleValue = value;
                        });
                      },
                      secondaryTrackValue: 7.0,
                      secondaryActiveColor: Colors.grey.shade400,
                      overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                        if (states.contains(WidgetState.hovered)) {
                          return Colors.purple.withAlpha(50);
                        }
                        if (states.contains(WidgetState.pressed)) {
                          return Colors.pink.withAlpha(100);
                        }
                        return null;
                      }),
                    ),
                  ),
                  Text('현재 슬라이더의 값: $_sliderStyleValue')
                ],
              ),
              Divider(),


              /// 슬라이더 상호작용 지정
              /// SliderInteraction.slideOnly: 트랙을 선택해도 이동하지 않고, 슬라이드만 취급
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Slider(
                      value: _sliderIneractionValue,
                      min: 0.0,
                      max: 10.0,
                      allowedInteraction: SliderInteraction.slideOnly,
                      onChanged: (value) {
                        setState(() {
                          _sliderIneractionValue = value;
                        });
                      },
                    ),
                  ),
                  Text('현재 슬라이더의 값: $_sliderIneractionValue')
                ],
              ),
              Divider(),


              /// SliderTheme 사용
              /// SliderTheme는 Slider 및 RangeSlider 위젯의 시각적 스타일을 커스텀하는 위젯
              /// 위젯 단위 적용과 앱 전체 단위 적용 2가지로 나뉜다
              ///   -위젯단위 적용은 Sldier위젯을 SliderTheme 위젯으로 감싸고 data에 원하는 속성만 수정한다
              ///   -단, SliderTheme를 사용했을에도 자식 Slider에서 따로 같은 속성을 지정했을 경우 자식의 속성을 우선으로 둔다 
              Container(
                padding: EdgeInsets.all(16),
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    // 트랙 관련
                    trackHeight: 12.0,  // 슬라이더 트랙바의 높이 지정
                    activeTrackColor: Colors.red.shade600,  // 선택 영역의 범위 색상
                    inactiveTrackColor: Colors.grey.shade300,  // 선택 영역의 범위 색상
                    // secondaryActiveTrackColor: value가 아닌 보조 트랙구간의 색상을 설정
                    trackShape: RectangularSliderTrackShape(),    // 트랙바의 전체적인 형태 및 양 끝의 라운드 처리 방식 지정
                    
                    // 썸 관련
                    thumbColor: Colors.red.shade600, // 썸의 색상
                    disabledThumbColor: Colors.grey, // onChanged: null로 슬라이더가 비활성화되었을 때 썸 색상
                    // 썸 형태 지정 - RectangularSliderThumbShape, RoundSliderThumbShape(기본값)
                    thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: 14.0,  // 활성화 상태 시 반지름
                      disabledThumbRadius: 8.0,  // 비활성화 상태 시 반지름
                      elevation: 4.0,            // 그림자 깊이
                    ),
                    
                    // 오버레이 관련
                    // 썸을 누르거나 드래그할 때 썸 주변으로 퍼지는 터치 반응 원형 이펙트의 색상
                    overlayColor: Colors.purple.withAlpha(50),  
                    // 터치 반경 이펙트의 크기(반지름)를 지정 
                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 28.0),

                    // 눈금자 관련 속성
                    // slider에 divisions 속성이 설정되어 있을 때 나타나는 구분을 눈금이라고 한다
                    activeTickMarkColor: Colors.white,  // 선택 구간에 있는 눈금 점의 색상
                    inactiveTickMarkColor: Colors.purple.shade700,  //미선택 구간에 있는 눈금 점의 색상
                    tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 4.0), //눈금 점의 모양과 크기를 지정

                    // label 관련 속성
                    // divisions 설정 시 드래그 중에 상단에 나타나는 값 안내 말풍선(Label) 스타일
                    valueIndicatorColor: Colors.deepOrange,  // 말풍선 툴팁의 배경색을 지정
                    valueIndicatorTextStyle: const TextStyle( // 말풍선 내부 텍스트의 글꼴, 크기, 색상 등을 지정
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    // valueIndicatorShape: 말풍선의 형태를 결정
                    //    -PaddleSliderValueIndicatorShape(): 노루발/물방울 모양 (Material 기본)
                    //    -RectangularSliderValueIndicatorShape(): 네모 직사각형 모양
                    valueIndicatorShape: const RectangularSliderValueIndicatorShape(),
                    // showValueIndicator: 말풍선 라벨이 표시되는 시점을 지정
                    //    -ShowValueIndicator.onlyForDiscrete: divisions가 설정된 경우에만 표시 (기본값)
                    //    -ShowValueIndicator.always: 언제나 표시
                    //    -ShowValueIndicator.never: 표시하지 않음
                    showValueIndicator: ShowValueIndicator.always,
                  ),
                  child: Slider(
                    min: 0.0,
                    max: 10.0,
                    value: _sliderThemeValue, 
                    divisions: 5,
                    label: '${_sliderThemeValue.round()}값',
                    onChanged: (value) {
                      setState(() {
                        _sliderThemeValue = value;
                      });
                    },
                  )
                ),
              ),
              Divider(),

              /// 앱 전체 슬라이더에 테마 동일 적용
              /// MaterialApp의 theme 설정 내에 sliderTheme를 지정하면 앱 내의 모든 Slider에 동일한 스타일이 적용됨
              // MaterialApp(
              //   theme: ThemeData(
              //     sliderTheme: const SliderThemeData(
              //       trackHeight: 8.0,
              //       activeTrackColor: Colors.blue,
              //       inactiveTrackColor: Colors.grey,
              //     ),
              //   ),
              //   home: const MyHomePage(),
              // )

              // Slider의 Thumb를 직접 구현하기 - 숫자 표시하는 Thumb
              // SliderComponentShape를 상속받아 객체 구현
              Container(
                padding: EdgeInsets.all(16),
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbShape: NumberSliderThumbShape(
                      thumbRadius: 16, 
                      value: _sliderThemeNumValue
                    )
                  ), 
                  child: Slider(
                    min: 0.0,
                    max: 10.0,
                    divisions: 11,
                    value: _sliderThemeNumValue,
                    onChanged: (value) {
                      setState(() {
                        _sliderThemeNumValue = value;
                      });
                    },
                  )
                ),  
              ),
              Divider(),



              // Slider의 Thumb를 직접 구현하기 - 아이콘 표시하는 Thumb
              Container(
                padding: EdgeInsets.all(16),
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbShape: IconSliderThumbShape(
                      thumbRadius: 16, 
                      iconData: Icons.check
                    )
                  ), 
                  child: Slider(
                    min: 0.0,
                    max: 10.0,
                    value: _sliderThemeIconValue,
                    onChanged: (value) {
                      setState(() {
                        _sliderThemeIconValue = value;
                      });
                    },
                  )
                ),  
              ),
              Divider(),



              /// 세로 방향의 Sldier 구현하기 - rotateBox 사용
              /// RotatedBox를 사용하여 Slider를 회전하는 방식이다
              /// 또는 외부 라이브로리를 사용하는 방식(another_xlider)
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape: RectangularSliderThumbShape(),
                        tickMarkShape: CustomTickMarkShape()
                      ), 
                      // quarterTurns: 1 - 시계방향으로 90도 회전
                      // quarterTurns: 3 - 시계방향으로 270도 회전
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Slider(
                          min: 0.0,
                          max: 10.0,
                          divisions: 5,
                          value: _sliderVerticalValue,
                          onChanged: (value) {
                            setState(() {
                              _sliderVerticalValue = value;
                            });
                          },
                        ),
                      )
                    ),

                    Text('현재 값: $_sliderVerticalValue')
                  ],
                ),
              ),
              Divider(),


              /// RangeSlider 기본 사용 방법
              /// 단일 값 대신에 시작값과 끝값을 함께 담는 RangeValues 클래스를 상태로 사용한다
              /// 속성은 대부분 Sldier와 동일하다
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    RangeSlider(
                      min: 0.0,
                      max: 100.0,
                      divisions: 10,
                      values: _currentRangeValues, 
                      onChanged: (value) {
                        setState(() {
                          _currentRangeValues = value;
                        });
                      },
                    ),
                    Text('선택범위 ${_currentRangeValues.start.round()} ~ ${_currentRangeValues.end.round()}')
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}



/// SliderComponentShape를 상속받아 커스텀 Thumb 만들기
class NumberSliderThumbShape extends SliderComponentShape {
  final double thumbRadius;
  final double value;

  const NumberSliderThumbShape({
    required this.thumbRadius,
    required this.value,
  });

  // Thumb의 최소 크기를 정의
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  // 실제 Canvas에 그려주는 메인 메서드
  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    // 1. Thumb 바깥 원(원형 배경) 그리기
    final paint = Paint()
      ..color = sliderTheme.thumbColor ?? Colors.blue
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, thumbRadius, paint);

    // 2. 숫자를 그려줄 TextPainter 설정
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: thumbRadius * 0.8,
      fontWeight: FontWeight.bold,
    );

    final textSpan = TextSpan(
      text: '${this.value.round()}', // 정수 형태로 출력
      style: textStyle,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: textDirection,
      textAlign: TextAlign.center,
    );

    // 3. 텍스트 레이아웃 계산 후 중앙 정렬하여 캔버스에 그리기
    textPainter.layout();
    final textOffset = Offset(
      center.dx - (textPainter.width / 2),
      center.dy - (textPainter.height / 2),
    );

    textPainter.paint(canvas, textOffset);
  }
}


/// 아이콘 표시하는 Thumb 만들기
class IconSliderThumbShape extends SliderComponentShape {
  final double thumbRadius;
  final IconData iconData;

  const IconSliderThumbShape({
    required this.thumbRadius,
    required this.iconData,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    // 1. 배경 원
    final paint = Paint()
      ..color = sliderTheme.thumbColor ?? Colors.blue
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, thumbRadius, paint);

    // 2. IconData를 문자 코드로 변환하여 TextStyle에 적용
    final textPainter = TextPainter(
      textDirection: textDirection,
      text: TextSpan(
        text: String.fromCharCode(iconData.codePoint),
        style: TextStyle(
          fontSize: thumbRadius * 1.2,
          fontFamily: iconData.fontFamily,
          package: iconData.fontPackage,
          color: Colors.white,
        ),
      ),
    );

    // 3. 중앙 배치 후 그리기
    textPainter.layout();
    final textOffset = Offset(
      center.dx - (textPainter.width / 2),
      center.dy - (textPainter.height / 2),
    );

    textPainter.paint(canvas, textOffset);
  }
}


/// Thumb 형태가 사각형
class RectangularSliderThumbShape extends SliderComponentShape {
  final double thumbWidth;
  final double thumbHeight;
  final double borderRadius;

  const RectangularSliderThumbShape({
    this.thumbWidth = 16.0,
    this.thumbHeight = 24.0,
    this.borderRadius = 4.0, // 0.0으로 설정하면 완벽한 직사각형
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(thumbWidth, thumbHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    // 1. Thumb의 가로/세로 영역(Rect) 계산 (center 기준)
    final rect = Rect.fromCenter(
      center: center,
      width: thumbWidth,
      height: thumbHeight,
    );

    // 2. 색상 및 스타일 지정
    final paint = Paint()
      ..color = sliderTheme.thumbColor ?? Colors.blue
      ..style = PaintingStyle.fill;

    // 3. 사각형 그리기 (borderRadius에 따라 둥근 사각형 또는 직사각형)
    if (borderRadius > 0) {
      final RRect rrect = RRect.fromRectAndRadius(
        rect,
        Radius.circular(borderRadius),
      );
      canvas.drawRRect(rrect, paint);
    } else {
      canvas.drawRect(rect, paint);
    }
  }
}

/// 
class CustomTickMarkShape extends SliderTickMarkShape {
  @override
  Size getPreferredSize({required SliderThemeData sliderTheme, required bool isEnabled}) {
    return const Size(6, 6);
  }

  @override
  void paint(
    PaintingContext context, 
    Offset center, {
      required RenderBox parentBox, 
      required SliderThemeData sliderTheme, 
      required Animation<double> enableAnimation, 
      required Offset thumbCenter, 
      required bool isEnabled, 
      required TextDirection textDirection
    }) {
      // center 위치에 원 대신 세로선(|)이나 점, 혹은 작은 아이콘 그리기
      final paint = Paint()..color = Colors.white;
      context.canvas.drawCircle(center, 3, paint);
  }
}



