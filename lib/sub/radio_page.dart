import 'package:flutter/material.dart';

class RadioPage extends StatefulWidget {
  const RadioPage({super.key});

  @override
  State<RadioPage> createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage> {
  // 현재 선택된 값을 저장할 변수
  Gender? _selectedGender = Gender.male; 

  // 라디오 그룹 사용
  Option _selectedOption = Option.first;

  // 그룹에서 선택 라디오 보여주기
  String _selectedValue = '피자';
  
  // 그룹에서 선택 라디오 보여주기
  bool? _selectedBoolean = true;

  bool isEnalbe = true;

  PayMethod? _selectedMethod = PayMethod.card;

  Num? _selectedNum = Num.one;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('radio 연습 패이지'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          alignment: .topCenter,
          child: Column(
            children: [
              // 기본적인 radio - onChanged와 groupValue 사용 - deprecated됨
              // 단독으로 radio 위젯 사용이 가능하지만 
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 1. 남성 라디오 버튼
                    Radio<Gender>(
                      value: Gender.male,          // 이 버튼의 고유 값
                      groupValue: _selectedGender, // 현재 그룹 선택 값
                      onChanged: (Gender? value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                    ),
                    const Text('남성'),
                    // 2. 여성 라디오 버튼
                    Radio<Gender>(
                      value: Gender.female,        // 이 버튼의 고유 값
                      groupValue: _selectedGender, // 현재 그룹 선택 값
                      onChanged: (Gender? value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                    ),
                    const Text('여성'),
                  ],
                ),
              ),
              Divider(),


              // radio 단독으로 사용할 수 있지만 최신 radio는 RadioGroup과 같이 쓰기 편하도록 되어있음
              //    기존 radio의 radioGroup과 onChanged도 depcated되어있음
              Container(
                padding: EdgeInsets.all(16),
                child: RadioGroup<Option>(
                  groupValue: _selectedOption,
                  onChanged: (Option? value) {
                    if(value != null) {
                      setState(() {
                        _selectedOption = value;
                      });
                    }
                  }, 
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Radio<Option>(
                            value: Option.first,
                            activeColor: Colors.black,
                          ),
                          Text('첫 번째 옵션')
                        ],
                      ),
                      SizedBox(width: 16),
                      Row(
                        children: [
                          Radio<Option>(
                            value: Option.second,
                            activeColor: Colors.black,
                          ),
                          Text('두 번째 옵션')
                        ],
                      )
                    ],
                  )
                ),
              ),
              Divider(),


              /// select값을 문자열로 선택해도 된다
              Container(
                padding: EdgeInsets.all(16),
                child: RadioGroup<String>(
                  groupValue: _selectedValue,
                  onChanged: (String? value) {
                    debugPrint('현재 선택한 값은 $value');
                    setState(() {
                      if(value != null) {
                        _selectedValue = value;
                      }
                    });
                  },
                  child: Row(
                    mainAxisAlignment: .center,
                    children: [
                      Row(
                        children: [
                          Radio<String>(
                            value: '피자',
                            activeColor: Colors.blueAccent,
                          ),
                          Text(
                            "피자",
                            style: TextStyle(color: Colors.white, backgroundColor: Colors.blueAccent),
                          )
                        ],
                      ),
                      SizedBox(width: 32),
                      Row(
                        children: [
                          Radio<String>(
                            value: '치킨',
                            activeColor: Colors.blueAccent,
                          ),
                          Text(
                            "치킨",
                            style: TextStyle(color: Colors.white, backgroundColor: Colors.blueAccent),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Divider(),


              /// boolean을 사용해서 radio 구성
              /// radio의 스타일을 변경 및 속성 설명
              ///     value: 해당 라디오 버튼이 가지는 고유값(RadioGroup의 groupValue와 value가 일치하면 선택상태가 됨)
              ///     enabled: 라디오 버튼의 활성화 여부, boolean값을 가짐, false일 경우 비활성화 스타일이 적용됨
              ///     toggleable: 이미 선택된 라디오 버튼을 다시 클릭했을 때 선택을 해제(null처라)할 수 있게 허용할지 여부
              ///     
              ///     activeColor: 라디오 버튼이 선택되었을 때 중아 원과 테두리의 기본 색상, Color값을 가짐
              ///     fillColor: 위젯상태(선택,비활,호버)에 따른 배경/테두리 색상을 동적으로 지정, activeColor보다 우선순위 높음
              ///         -WidgetStateProperty<Color?>?을 받음
              ///     backgroundColor: 라디오 버튼 상자 자체의 안쪽 배경색을 지정
              ///         -WidgetStateProperty<Color?>?을 받음
              ///     side: 라디오 버튼의 외곽 테두리 선(border) 두께와 색상을 상태별로 지정
              ///         -WidgetStateProperty<BorderSide?>?
              ///     innerRadius: 라디오 버튼이 선택되었을 때 내부 안쪽에 생기는 동그란 원의 반지름 크기를 지정
              ///         -WidgetStateProperty<double?>?
              /// 
              ///     focusColor: 키보드 포커스를 얻었을 때 라디오 버튼 주변에 들어오는 하이라이트 색상
              ///     hoverColor: 호버 색상
              ///     overlayColor: 클릭하거나 포커스/호버 시 라디오 버튼 위에 반투명하게 덮어씌워지는 레이어 색상
              ///     splashRadius: 터치하거나 마우스를 올렸을 때 원형으로 퍼지는 효과(Splash)의 반지름 크기
              ///     mouseCursor: 웹/데스크톱 환경에서 라디오 버튼에 마우스를 올렸을 때의 커서 모양을 상태별로 제어
              /// 
              ///     visualDensity: 라디오 버튼 주변의 시각적 밀도(패딩 및 가로세로 간격)를 조절
              /// 
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    RadioGroup<bool?>(
                      groupValue: _selectedBoolean,
                      onChanged: (bool? value) {
                        setState(() {
                          _selectedBoolean = value;
                        });
                      }, 
                      child: Row(
                        mainAxisAlignment: .center,
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  Radio<bool?>(
                                    value: true,    // rlqhsrqlkt 
                                    // activeColor: Colors.amber, // 기본적인 radio 색상 지정
                                    // fillColor: 상태에 따른 메인 색상(선택 점 및 기본 테두리 색상)
                                    fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                      if(states.contains(WidgetState.disabled)) {
                                        return Colors.grey;
                                      }
                                      if(states.contains(WidgetState.selected)) {
                                        return Colors.amber;
                                      }
                                      if(states.contains(WidgetState.hovered)){
                                        return Colors.purple;
                                      }
                                      return Colors.black;  // 선택되지 않을때
                                    }),
                                    // backgroundColor: 라디오 원 안쪽의 바탕 배경색
                                    backgroundColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
                                      if (states.contains(WidgetState.disabled)) {
                                        return Colors.grey.shade200;
                                      }
                                      if (states.contains(WidgetState.selected)) {
                                        return Colors.black; // 선택되었을 때 
                                      }
                                      return Colors.white; // 기본 바탕 배경색
                                    }),
                                    side: BorderSide(
                                      color: Colors.green
                                    ),
                                    toggleable: true,  
                                    enabled: isEnalbe,
                                  ),
                                  Text(
                                    '예',
                                    style: TextStyle(color: Colors.white, backgroundColor: isEnalbe ? Colors.amber : Colors.grey),  
                                  )
                                ],
                              ),
                              SizedBox(width: 32),
                              Row(
                                children: [
                                  Radio<bool?>(
                                    value: false,
                                    fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                      if(states.contains(WidgetState.disabled)) {
                                        return Colors.grey;
                                      }
                                      if(states.contains(WidgetState.selected)) {
                                        return Colors.amber;
                                      }
                                      if(states.contains(WidgetState.hovered)){
                                        return Colors.purple;
                                      }
                                      return Colors.black;  // 선택되지 않을때
                                    }),
                                    backgroundColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
                                      if (states.contains(WidgetState.disabled)) {
                                        return Colors.grey.shade200;
                                      }
                                      if (states.contains(WidgetState.selected)) {
                                        return Colors.amber.shade50; // 선택되었을 때 
                                      }
                                      return Colors.white; // 기본 바탕 배경색
                                    }),
                                    toggleable: true,  
                                    enabled: isEnalbe,
                                  ),
                                  Text(
                                    '아니오',
                                    style: TextStyle(color: Colors.white, backgroundColor: isEnalbe ? Colors.amber : Colors.grey),  
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      )
                    ),

                    TextButton(
                      onPressed: () {
                        setState(() {
                          isEnalbe = !isEnalbe;
                        });
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: isEnalbe ? Colors.orange : Colors.grey,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder()
                      ),
                      child: Text("라디오 버튼 ON/OFF")
                    )
                  ],
                ),
              ),
              Divider(),

              /// RadioListTile 활용
              /// 
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    // 1. 신용카드 선택 타일
                    RadioListTile<PayMethod>(
                      title: const Text('신용/체크카드'),
                      subtitle: const Text('모든 카드사 할부 지원'),
                      secondary: const Icon(Icons.credit_card),
                      value: PayMethod.card,
                      groupValue: _selectedMethod,
                      onChanged: (PayMethod? value) {
                        setState(() => _selectedMethod = value);
                      },
                      activeColor: Colors.deepPurple,
                      controlAffinity: ListTileControlAffinity.leading, // 라디오 아이콘을 왼쪽에 배치
                    ),

                    const Divider(),

                    // 2. 계좌이체 선택 타일
                    RadioListTile<PayMethod>(
                      title: const Text('실시간 계좌이체'),
                      subtitle: const Text('현금영수증 자동 발급'),
                      secondary: const Icon(Icons.account_balance),
                      value: PayMethod.bank,
                      groupValue: _selectedMethod,
                      onChanged: (PayMethod? value) {
                        setState(() => _selectedMethod = value);
                      },
                      activeColor: Colors.deepPurple,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),

                    const Divider(),

                    // 3. 카카오페이 선택 타일 (우측 라디오 아이콘 배치 + selected 효과)
                    RadioListTile<PayMethod>(
                      title: const Text('카카오페이'),
                      subtitle: const Text('간편 결제 서비스'),
                      secondary: const Icon(Icons.payment, color: Colors.amber),
                      value: PayMethod.kakaoPay,
                      groupValue: _selectedMethod,
                      onChanged: (PayMethod? value) {
                        setState(() => _selectedMethod = value);
                      },
                      activeColor: Colors.amber,
                      // 선택되었을 때 글자/아이콘 색상 강조
                      selected: _selectedMethod == PayMethod.kakaoPay,
                      controlAffinity: ListTileControlAffinity.trailing, // 라디오 아이콘을 오른쪽에 배치
                    ),
                  ],
                ),
              ),
              Divider(),


              /// selected: 현재 이 타일 전체가 선택(Highlight)되어 있는지를 나타내는 bool 타입 설정값(기본값 false)
              ///   -true로 지정하면 라디오 버튼, 제목(title), 부제목(subtitle), 아이콘(secondary)의 색상이 Primary Color로 전환됨
              ///   -만약 activeColor속성이 채워졌을 경우 -> selected된 아이템의 색상은 primary가 아닌 activeColor색상을 우선적으로 받음
              ///   -fillColor는 라디오 버튼 색상 전용이라서 selected된 제목,부제,아이콘 등에 영향을 주지 않음
              /// 
              Container(
                padding: EdgeInsets.all(16),
                child: RadioGroup<Num?>(
                  groupValue: _selectedNum,
                  onChanged: (Num? value) {
                    setState(() {
                      _selectedNum = value;
                    });
                  }, 
                  child: Column(
                    children: [
                      RadioListTile<Num?>(
                        title: Text('하나'),
                        subtitle: Text('one'),
                        secondary: Icon(Icons.one_k_rounded),
                        value: Num.one,
                        toggleable: true,
                        activeColor: Colors.indigo,
                        selected: _selectedNum == Num.one,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      RadioListTile<Num?>(
                        title: Text('둘'),
                        subtitle: Text('two'),
                        secondary: Icon(Icons.two_k_rounded),
                        value: Num.two,
                        toggleable: true,
                        activeColor: Colors.indigo,
                        selected: _selectedNum == Num.two,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      RadioListTile<Num?>(
                        title: Text('셋'),
                        subtitle: Text('three'),
                        secondary: Icon(Icons.three_k_rounded),
                        value: Num.three,
                        toggleable: true,
                        activeColor: Colors.indigo,
                        selected: _selectedNum == Num.three,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ],
                  )
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}

enum Gender {
  male,
  female
}

enum Option {
  first,
  second
}

enum PayMethod { card, bank, kakaoPay }

enum Num {
  one, two, three
}