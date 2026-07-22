import 'package:flutter/material.dart';

class DropDownPage extends StatefulWidget {
  const DropDownPage({super.key});

  @override
  State<DropDownPage> createState() => _DropDownPageState();
}

class _DropDownPageState extends State<DropDownPage> {
  String? _selectedValue = null;

  String? _selectedDisableValue = null;
  bool isEnable = true;

  String? _selected = null;

  final Map<String, List<String>> _cityMap = {
    '한국': ['서울', '부산', '대전'],
    '일본': ['도쿄', '오사카', '교토'],
    '미국': ['뉴욕', 'LA', '시카고'],
  };
  String? _selectedCountry;
  String? _selectedCity;


  SortOption _sortOption = SortOption.latest;
  final List<Map<String, dynamic>> _items = [
    {'name': '상품A', 'date': 3, 'popularity': 10, 'price': 5000},
    {'name': '상품B', 'date': 1, 'popularity': 30, 'price': 2000},
    {'name': '상품C', 'date': 2, 'popularity': 20, 'price': 8000},
  ];

  List<Map<String, dynamic>> get _sortedItems {
    final sorted = [..._items]; // 원본 훼손 방지를 위한 복사
    switch (_sortOption) {
      case SortOption.latest:
        sorted.sort((a, b) => b['date'].compareTo(a['date']));
        break;
      case SortOption.popular:
        sorted.sort((a, b) => b['popularity'].compareTo(a['popularity']));
        break;
      case SortOption.price:
        sorted.sort((a, b) => a['price'].compareTo(b['price']));
        break;
    }
    return sorted;
  }

  String _label(SortOption option) {
    switch (option) {
      case SortOption.latest:
        return '최신순';
      case SortOption.popular:
        return '인기순';
      case SortOption.price:
        return '가격순';
    }
  }



  final List<String> _countries = ['한국', '일본', '미국', '중국'];
  String? _selectedMenu;



  @override
  Widget build(BuildContext context) {
    final cityOptions = _selectedCountry == null
        ? <String>[]
        : _cityMap[_selectedCountry]!;


    return Scaffold(
      appBar: AppBar(
        title: Text('DropDownButton 연습 페이지'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          alignment: .topCenter,
          child: Column(
            children: [
              /// 드롭다운 기본 사용
              /// value: 현재 선택되어 화면에 표시되는 값
              ///     -items 리스트 내부의 DropdownMenuItem이 가진 value 중 하나와 일치해야 함
              ///     -일치하는 값이 없으면 에러 발생
              /// items: 드롭다운을 눌렀을 때 펼쳐지는 선택 항목들의 리스트
              /// onChanged: 사용자가 목록에서 다른 항목을 선택했을 때 실행되는 콜백 함수
              ///     -null로 지정 시 비활성화 상태
              /// disabledHint: onChanged가 null이거나 items가 비어있어 드롭다운이 비활성화되었을 때 표시할 텍스트나 위젯
              ///     -items 목록이 null이거나 빈 리스트일때도 비활성 상태가 됨
              ///     -주의) 만약 이미 selected에 value가 있다면 disabledHint가 나오지 않는다
              ///     -주의2) 위의 경우는 선택한 값이 null일때 items에 null이 있는 경우에도 똑같이 disabledHint가 나오지 않음
              /// hint가 value가 null일 때 기본으로 보여줄 안내 문구 위젯
              ///     -items 목록 내에 value: null을 가진 메뉴아이템이 존재하는지 확인
              ///     -존재한다면, hint 대신 해당 아이템(Text('없음'))을 선택된 것으로 간주하여 화면에 표시
              ///     -items 목록 내에 value: null인 아이템이 전혀 없을 때만 hint를 화면에 노출한다
              /// onTap: 사용자가 드롭다운 메뉴를 클릭하여 목록을 열 때 호출되는 이벤트 함수
              /// style: 선택된 항목 및 드롭다운 메뉴 내부 텍스트의 글꼴, 크기, 색상 등 기본 스타일을 지정
              /// isExpanded: true로 설정하면 드롭다운 위젯이 부모 컨테이너의 가로 너비(Width)를 가득 채우도록 확장
              /// isDense: true로 설정하면 위아래 패딩(여백)이 줄어들어 드롭다운의 높이가 촘촘하게 축소 (기본값: false)
              /// itemHeight: 펼쳐지는 드롭다운 메뉴 항목 개별 높이를 지정
              /// alignment: 드롭다운 버튼 내부 텍스트 및 아이콘의 정렬 방식을 정함
              /// selectedItemBuilder: 메뉴 목록에 표시되는 디자인과, 선택되어 버튼 상단에 표시되는 디자인을 다르게 커스텀하고 싶을 때 사용한다
              /// icon: 드롭다운 우측에 표시되는 화살표 아이콘을 다른 위젯으로 변경
              /// iconDisabledColor / iconEnabledColor: 드롭다운 활성화/비활성화 상태에 따른 화살표 아이콘의 색상
              /// 
              /// elevation: 드롭다운을 눌렀을 때 펼쳐지는 팝업 메뉴 박스의 그림자 깊이
              /// dropdownColor: 펼쳐지는 팝업 메뉴 상자 자체의 배경색을 지정
              /// menuMaxHeight: 펼쳐지는 팝업 메뉴의 최대 높이를 제한
              ///       -메뉴 항목이 너무 많을 때 이 값을 넘어가면 스크롤바가 생김
              /// borderRadius: 펼쳐지는 팝업 메뉴 상자 테두리의 둥글기(Radius)를 설정
              /// underline: 드롭다운 버튼 하단에 그려지는 기본 밑줄 표시를 지정하거나 제거할 때 사용
              ///       -빈 상자(SizedBox())를 넣으면 하단 테두리 선이 사라진다
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    DropdownButton<String>(
                      value: _selectedValue,  // 현재 선택 값
                      hint: Text('좋아하는 과일을 선택하세요'),
                      isDense: true,
                      items: [
                        //DropdownMenuItem(value: null, child: Text('없음')),
                        DropdownMenuItem(value: '사과', child: Text('사과')),
                        DropdownMenuItem(value: '바나나', child: Text('바나나')),
                        DropdownMenuItem(value: '포도', child: Text('포도')),
                      ], 
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value;
                        });
                      },
                    ),
                    Text('현재 선택된 아이템: $_selectedValue')
                  ]
                ),
              ),
              Divider(),

              // 드롭다운을 비활성화 - 버튼 제어
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    DropdownButton<String>(
                      value: _selectedDisableValue,  // 현재 선택 값
                      disabledHint: Text('현재 비활성화중'),
                      hint: Text('좋아하는 과일을 선택하세요'),
                      isDense: true,
                      items: [
                        // DropdownMenuItem(value: null, child: Text('없음')),
                        DropdownMenuItem(value: '사과', child: Text('사과')),
                        DropdownMenuItem(value: '바나나', child: Text('바나나')),
                        DropdownMenuItem(value: '포도', child: Text('포도')),
                      ], 
                      onChanged: isEnable 
                      ? (value) {
                          setState(() {
                            _selectedDisableValue = value;
                          });
                        }
                      : null,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: isEnable ? Colors.blue : Colors.grey,
                        shape: ContinuousRectangleBorder()
                      ),
                      onPressed: () {
                        setState(() {
                          isEnable = !isEnable;
                        });
                      }, 
                      child: Text(
                        isEnable ? '활성화중' : '비활성화중',
                        style: TextStyle(
                          color: Colors.white
                        ),  
                      )
                    )
                  ]
                ),
              ),
              Divider(),

              // onTap 사용 및 스타일 
              Container(
                padding: EdgeInsets.all(16),
                child: DropdownButton<String>(
                  value: _selected,  // 현재 선택 값
                  disabledHint: Text('현재 비활성화중'),
                  hint: Text('좋아하는 과일을 선택하세요'),
                  isDense: true,
                  onTap: () {
                    debugPrint("클릭함");
                  },
                  style: TextStyle( // 선택된 항목 및 메뉴 텍스트에 적용
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600
                  ),
                  // isExpanded: true,  // 메뉴 너비를 부모에 맞춤(가로 최대로)
                  //borderRadius: BorderRadius.circular(8),   // 모서리 둥글기 다듬기
                  dropdownColor: Colors.white, // 배경색 깔끔하게 통일
                  itemHeight: 48,
                  // "선택되었을 때 위젯 상단(버튼 부분)에 보여줄 디자인"과 "클릭해서 아래로 펼쳐졌을 때(메뉴 리스트) 보여줄 디자인"을 서로 다르게 만들고 싶을 때
                  // 선택 후 상단 선택된 아이템에 표시될 디자인 
                  selectedItemBuilder: (context) {
                    return ['사과', '바나나', '포도'].map((e) {
                      return Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '선택됨: $e',
                          style: const TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList();
                  },
                  underline: SizedBox(),
                  // 펼쳐진 메뉴 리스트
                  items: [
                    // DropdownMenuItem(value: null, child: Text('없음')),
                    DropdownMenuItem(
                      value: '사과', 
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle_outline, color: Colors.green),
                          const SizedBox(width: 8),
                          Text('사과'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: '바나나', 
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle_outline, color: Colors.green),
                          const SizedBox(width: 8),
                          Text('바나나'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: '포도', 
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle_outline, color: Colors.green),
                          const SizedBox(width: 8),
                          Text('포도'),
                        ],
                      ),
                    ),
                  ], 
                  onChanged: (value) {
                    setState(() {
                      _selected = value;
                    });
                  },
                ),
              ),
              Divider(),
              

              /// 국가도시 선택 폼
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    DropdownButton<String>(
                      value: _selectedCountry,
                      hint: const Text('국가 선택'),
                      items: _cityMap.keys.map((country) {
                        return DropdownMenuItem<String>(
                          value: country,
                          child: Text(country),
                        );
                      }).toList(),
                      onChanged: (newCountry) {
                        setState(() {
                          _selectedCountry = newCountry;
                          _selectedCity = null; // 핵심: 하위 선택값 초기화
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButton<String>(
                      value: _selectedCity,
                      hint: const Text('도시 선택'),
                      // 국가 미선택 시 빈 리스트 → 비활성처럼 보이게 처리
                      items: cityOptions.map((city) {
                        return DropdownMenuItem<String>(
                          value: city,
                          child: Text(city),
                        );
                      }).toList(),
                      onChanged: _selectedCountry == null
                          ? null // onChanged가 null이면 자동으로 비활성화(disabled) 상태가 됨
                          : (newCity) {
                              setState(() {
                                _selectedCity = newCity;
                              });
                            },
                    ),
                  ],
                ),
              ),
              Divider(),


              /// 정렬 기준 선택 - 리스트뷰
              /// enum 제네릭 타입을 사용하기
              /// value와 child를 분리해서 매핑하기
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    DropdownButton<SortOption>(
                      value: _sortOption,
                      items: SortOption.values.map((option) {
                        return DropdownMenuItem<SortOption>(
                          value: option,
                          child: Text(_label(option)),
                        );
                      }).toList(),
                      onChanged: (newOption) {
                        if (newOption != null) {
                          setState(() {
                            _sortOption = newOption;
                          });
                        }
                      },
                    ),
                    ListView(
                      shrinkWrap: true,
                      children: _sortedItems
                          .map((item) => ListTile(title: Text(item['name'])))
                          .toList(),
                    ),
                  ],
                ),
              ),
              Divider(),

              // dropdownMenu 사용
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    DropdownMenu<String>(
                      dropdownMenuEntries: _countries.map((e) {
                        return DropdownMenuEntry(
                          value: e, 
                          label: e
                        );
                      }).toList(),
                      onSelected: (value) {
                        setState(() {
                          _selectedMenu = value;
                        });
                      },
                    )
                  ],
                ),
              ),
              Divider()


              /// 

            ],
          ),
        ),
      )
    );
  }
}


enum SortOption { latest, popular, price }

