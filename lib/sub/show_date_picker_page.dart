import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ShowDatePickerPage extends StatefulWidget {
  const ShowDatePickerPage({super.key});

  @override
  State<ShowDatePickerPage> createState() => _ShowDatePickerPageState();
}

class _ShowDatePickerPageState extends State<ShowDatePickerPage> {
  DateTime? _selectedDate;  // 선택할 날짜를 저장할 변수


  /// showDatePicker의 매개변수 정리
  ///   -context(필수): 다이얼로그를 띄울 위치의 빌드 컨텍스트, 테마 및 화면 트리를 참조
  ///   -initialDate(필수): 달력이 열렸을 때 기본으로 선택되어 있는 날짜, 테마 및 화면 트리를 참조
  ///       -반드시 firstDate와 lastDate 사이에 있어야 한다, 안하면 에러남
  ///       -initialDate: DateTime.now(), // 오늘 날짜를 기본값으로 설정
  ///   -firstDate(필수): 선택할 수 있는 가장 과거의 날짜(시작 범위), 이 이전 날짜는 비활성화, DateTime 자료형을 가짐
  ///       -DateTime(2020, 1, 1), // 2020년 1월 1일부터 선택 가능
  ///   -lastDate(필수): 선택할 수 있는 가장 미래의 날짜(종료 범위), 이 이후 날짜는 비활성화된다
  ///       -lastDate: DateTime(2030, 12, 31), // 2030년 12월 31일까지 선택 가능
  ///   -initialDatePickerMode: 력이 처음 열릴 때 월(day) 기준 뷰로 보일지, 연도(year) 선택 뷰로 보일지 결정, DatePickerMode자료형을 가진다
  ///       -DatePickerMode.day(기본값) 또는 DatePickerMode.year
  ///       -initialDatePickerMode: DatePickerMode.year, // 처음 열릴 때 연도 선택 화면부터 표시
  ///   -initialEntryMode: 초기 입력 모드를 설정(달력 형태, 직접 텍스트 입력 형태 등)
  ///       -calendar: 기본 달력 형태(기본값)
  ///       -input: 텍스트 직접 입력 형태
  ///       -calendarOnly: 텍스트 입력 전환 버튼을 없애고 달력만 사용
  ///       -inputOnly: 달력 전환 버튼을 없애고 텍스트 입력만 사용
  ///       -initialEntryMode: DatePickerEntryMode.calendarOnly, // 달력 모드로만 고정
  ///   -switchToCalendarEntryModeIcon / switchToInputEntryModeIcon
  ///       -달력 뷰와 텍스트 입력 뷰 사이를 전환할 때 다이얼로그 상단에 표시되는 아이콘을 변경
  ///       -Icon자료형을 가짐
  ///       -switchToCalendarEntryModeIcon: const Icon(Icons.calendar_month),
  ///       -switchToInputEntryModeIcon: const Icon(Icons.edit),
  ///   -currentDate: '오늘' 날짜를 시각적으로 테두리나 강조 표시할 날짜를 지정
  ///       -기본값은 실제 시스템의 DateTime.now()
  ///       -currentDate: DateTime(2026, 7, 23), // 특정 날짜를 '오늘'로 간주하여 테두리 강조
  ///   -selectableDayPredicate: 특정 규칙에 따라 개별 날짜의 활성화/비활성화 여부를 bool 함수로 제어
  ///       -false를 반환하면 해당 날짜는 선택할 수 없게 됨
  ///       -달력이 그려질 때 표출되는 모든 날짜(day)에 대해 이 함수가 실행, 반환되는 bool 값(true 또는 false)에 따라 활성/비활성이 나뉜다
  ///       -비활성화된 날짜에는 이벤트가 발생하지 않는다
  ///       -예시      
  ///         selectableDayPredicate: (DateTime date) {
  //            토요일(6), 일요일(7)은 선택 불가 처리
  ///           return date.weekday != DateTime.saturday && date.weekday != DateTime.sunday;
  ///         },
  ///   -helpText: 다이얼로그 상단 헤더 영역에 표시되는 안내 텍스트, String자료형을 가짐
  ///       -기본값은 'select date'
  ///       -helpText: '생년월일을 선택해주세요',
  ///   -cancelText: 취소 버튼의 텍스트를 변경, String자료형을 가짐
  ///       -기본값은 'cancel' 또는 로케일 변수
  ///       -cancelText: '닫기',
  ///   -confirmText: 확인 버튼의 텍스트를 변경, String자료형을 가짐
  ///       -기본값은 'OK' 또는 로케일 변수
  ///       -confirmText: '선택완료',
  ///   -errorFormatText: 텍스트 입력 모드(input)에서 날짜 포맷이 올바르지 않을 때 표시되는 에러 메시지, String자료형을 가짐
  ///       -기본값은 'Invalid format'
  ///       -errorFormatText: '올바른 날짜 형식(YYYY/MM/DD)이 아닙니다.',
  ///   -errorInvalidText: 텍스트 입력 모드에서 firstDate와 lastDate 범위를 벗어난 날짜를 입력했을 때 나타나는 에러 메시지
  ///       -기본값은 'Out of range'
  ///       -errorInvalidText: '선택할 수 없는 범위의 날짜입니다.',
  ///   -fieldHintText: 텍스트 입력 모드의 입력 폼 내부 힌트 텍스트
  ///       -기본값은 'mm/dd/yyyy'
  ///       -fieldHintText: 'YYYY/MM/DD',
  ///   -fieldLabelText: 텍스트 입력 모드 폼 위쪽에 위치하는 라벨 텍스트
  ///       -Enter Date
  ///       -fieldLabelText: '날짜 입력',
  ///   -keyboardType: 텍스트 입력 모드에서 열리는 키보드의 타입을 설정
  ///       -기본값은 TextInputType.datetime
  ///       -keyboardType: TextInputType.number, // 숫자 키패드로 고정
  ///   -builder: 다이얼로그의 테마(색상, 폰트, 모서리 모양 등)나 상위 위젯 트리 구조를 재정의할 때 사용
  ///     -예시 (다크 테마 적용):
  ///     builder: (BuildContext context, Widget? child) {
  //        return Theme(
  //          data: ThemeData.dark().copyWith(
  //            colorScheme: const ColorScheme.dark(
  //              primary: Colors.deepOrange, // 헤더 및 선택 색상
  //              onPrimary: Colors.white,
  //              surface: Colors.grey,
  //              onSurface: Colors.white,
  //            ),
  //          ),
  //        child: child!,
  //        );
  //      },
  ///   -locale: 다이얼로그 내의 언어 및 날짜 표시 형식을 설정
  ///       -앱 전체 설정과 다르게 해당 다이얼로그만 언어를 다르게 지정할 때 사용
  ///       -locale: const Locale('ko', 'KR'), // 한국어 설정
  ///   -textDirection: 텍스트 및 레이아웃의 방향을 설정
  ///       -TextDirection.ltr 또는 TextDirection.rtl
  ///       -textDirection: TextDirection.ltr,
  ///   -useRootNavigator: 내비게이션 트리의 루트 내비게이터를 사용할지 여부를 결정
  ///       -기본값은 true
  ///       -중첩 내비게이터 환경에서 다이얼로그 위치를 잡을 때 활용
  ///       -useRootNavigator: true,
  ///   -routeSettings: 다이얼로그 라우트에 지정할 라우트 설정 객체
  ///       -화면 전환 분석 및 추적용
  ///       -routeSettings: const RouteSettings(name: '/date_picker_dialog'),
  ///   -anchorPoint: 멀티 디스플레이 환경이나 특수한 레이아웃 배치 시 다이얼로그가 위치할 기준 좌표점(Offset)을 지정
  ///       -anchorPoint: const Offset(100, 200),
  ///   -barrierDismissible: 다이얼로그 바깥 영역을 클릭했을 때 다이얼로그를 닫을지 여부를 결정 
  ///       -기본값은 true 
  ///       -false로 설정하면 확인/취소 버튼으로만 다이얼로그를 닫을 수 있다
  ///   -barrierColor: 다이얼로그 배경에 깔리는 어두운 딤(Dim) 색상을 지정
  ///       -barrierColor: Colors.black.withAlpha(180), // 배경 어둡게 처리
  ///   -barrierLabel: 접근성(Screen Reader)을 위한 바깥 영역 라벨, 시각적으로 표시되는 라벨이 아님, 스크린리더가 읽는 라벨임
  ///       -barrierLabel: '날짜 선택 창 닫기',
  ///   -onDatePickerModeChange: 사용자가 달력 입력 방식(calendar)과 텍스트 입력 방식(input) 간 모드를 전환할 때 호출되는 콜백 함수
  ///       -예시 코드
  ///       onDatePickerModeChange: (DatePickerEntryMode mode) {
  ///         print('현재 모드 변경됨: $mode');
  ///       },
  /// 
  /// 

  
  Future<void> _openDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context, 
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000), 
      lastDate: DateTime(2030), // 이러면 2029.12 까지만 나오게 됨
      // switchToCalendarEntryModeIcon: Icon(Icons.abc),             // 텍스트입력뷰에서 달력뷰로 전환되는 아이콘
      // switchToInputEntryModeIcon: Icon(Icons.access_alarm_sharp),  // 달력뷰에서 텍스트입력뷰으로 전환되는 아이콘
      // helpText: '하나둘삼넷',
      // cancelText: '가나다라',
      // confirmText: '선택완료',
      barrierLabel: '날짜 선택 창 닫기',
    );

    if(pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }
  


  /// DateFormat 패키지를 사용해서 텍스트필드에 넣기 - intl패키지
  DateTime? _selectedTextDate;   
  late TextEditingController _textController;

  Future<void> _openDateText() async {
    String dateText = '';
    final DateTime? pickedDate = await showDatePicker(
      context: context, 
      firstDate: DateTime(2026,1,1), 
      lastDate: DateTime(2027,1,1),
      initialDate: _selectedTextDate ?? DateTime.now(),
    );

    if(pickedDate != null) {
      _selectedTextDate = pickedDate;
      // 기본 문자열을 사용할 때
      // dateText = '${_selectedTextDate!.year}년 ${_selectedTextDate!.month}월 ${_selectedTextDate!.day}일';
      // _textController.text = dateText;
      final String formattedDate = DateFormat('yyyy년 MM월 dd일').format(pickedDate);
      _textController.text = formattedDate;
    }
  }

  
  /// 날짜필드 두개를 받기
  /// 시작일, 종료일을 통해서 종료일이 시작일보다 먼저라면 에러텍스트를 표시
  DateTime? _selectedStart;
  DateTime? _selectedEnd;

  bool get _isDateRangeValid =>
      _selectedStart != null &&
      _selectedEnd != null &&
      !_selectedStart!.isAfter(_selectedEnd!);

  String get _validationMessage {
    if (_selectedStart == null || _selectedEnd == null) {
      return '시작일과 종료일을 선택하십시오';
    }
    return _isDateRangeValid ? '확인되었습니다' : '종료일자를 다시 확인하십시오';
  }
  
  Future<void> _openDateStart() async {
    DateTime? pickedDate = await showDatePicker(
      context: context, 
      helpText: '시작일',
      initialDate: _selectedStart ?? DateTime.now(),
      firstDate: DateTime(2024, 1, 1), 
      lastDate: DateTime(2028, 1, 1),
    );

    if(pickedDate != null) {
      setState(() {
        _selectedStart = pickedDate;
      });
    }
  }

  Future<void> _openDateEnd() async {
    final DateTime minDate = _selectedStart ?? DateTime(2024, 1, 1);
    final DateTime targetDate = _selectedEnd ?? minDate.add(const Duration(days: 1));

    DateTime? pickedDate = await showDatePicker(
      context: context, 
      helpText: '종료일',
      initialDate: targetDate.isBefore(minDate) ? minDate : targetDate,
      firstDate: minDate,
      lastDate: DateTime(2028, 1, 1),
    );
    
    if(pickedDate != null) {
      setState(() {
        _selectedEnd = pickedDate;
      });
    }
  }

  // String checkValidDate() {
  //   String message = '';

  //   if(_selectedStart == null || _selectedEnd == null) {
  //     _isDateEnable = false;
  //     return '시작일과 종료일을 선택하십시오';
  //   }
    
  //   // 시작일이 종료일보다 뒤에 있다면
  //   if (_selectedStart!.isAfter(_selectedEnd!)) {
  //     _isDateEnable = false;
  //     return '종료일자를 다시 확인하십시오'; 
  //   } else {
  //     _isDateEnable = true;
  //     return '확인되었습니다'; 
  //   }
  // }





  /// 주말 선택 불가 캘린더 만들기
  DateTime? _selectedDateNotWeekend;

  Future<void> _openDateNotWeekend() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateNotWeekend ?? DateTime.now() ,
      firstDate: DateTime(2026,1,1), 
      lastDate: DateTime(2027,1,1),
      selectableDayPredicate: (day) {
        return day.weekday != DateTime.saturday && day.weekday != DateTime.sunday;
      }
    );

    if(pickedDate != null) {
      setState(() {
        _selectedDateNotWeekend = pickedDate;
      });
    }
  }


  /// 날짜 입력 형식 변경
  CalendarFormat _selectedFormat = CalendarFormat.calendar;
  DatePickerEntryMode get _selectedMode {
    switch(_selectedFormat) {
      case CalendarFormat.calendar: 
        return DatePickerEntryMode.calendar;
      case CalendarFormat.input: 
        return DatePickerEntryMode.input;
      case CalendarFormat.calendarOnly: 
        return DatePickerEntryMode.calendarOnly;
      case CalendarFormat.inputOnly: 
        return DatePickerEntryMode.inputOnly;
    }
  }

  DateTime? _selectedValue;

  Future<void> _openDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedValue ?? DateTime.now(),
      firstDate: DateTime(2026,1,1), 
      lastDate: DateTime(2027,1,1),
      initialEntryMode: _selectedMode
    );

    if(pickedDate != null) {
      setState(() {
        _selectedValue = pickedDate;
      });
    }
  }


  /// 색상이 변경된 달력 출력
  DateTime? _selectedStyleDate;
  
  Future<void> _openStyleDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedStyleDate ?? DateTime.now(),
      firstDate: DateTime(2026,1,1), 
      lastDate: DateTime(2027,1,1),
      barrierDismissible: false,   // 바깥 영역 눌러도 안 닫히도록 
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.indigo,      // 헤더 배경, 선택된 날짜 배경색
              onPrimary: Colors.white,     // 헤더/선택된 날짜의 텍스트색
              onSurface: Colors.black87,   // 캘린더 본문 텍스트색
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white, // 취소/확인 버튼 텍스트색
                shape: ContinuousRectangleBorder()
              ),
            ),
            datePickerTheme: DatePickerThemeData(
              shape: ContinuousRectangleBorder(),        // 다이얼로그 창 자체의 모서리를 직각으로 설정
              // dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
              //   if (states.contains(WidgetState.selected)) {
              //     return Colors.deepPurple; // 선택된 날짜 배경색
              //   }
              //   return null;
              // }),
              // dayForegroundColor: WidgetStateProperty.resolveWith((states) {
              //   if (states.contains(WidgetState.selected)) {
              //     return Colors.white; // 선택된 날짜 글자색
              //   }
              //   return null;
              // }),
            )
          ),
          child: child!, // 실제 DatePicker 다이얼로그
        );
      },
    );

    if(pickedDate != null) {
      setState(() {
        _selectedStyleDate = pickedDate;
      });
    }
  }

  
  /// showDateRangePicker 사용하기
  Future<void> _openRangeDate() async {
    final DateTimeRange? pickedDate = await showDateRangePicker(
      context: context, 
      firstDate: DateTime(2025,1,1), 
      lastDate: DateTime(2027,1,1)
    );

  }

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ShowDatePicker 연습 페이지'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          alignment: .topCenter,
          child: Column(
            children: [
              /// ShowDatePicker의 기본적인 사용 방법 - 참고로 showDatePicker는 위젯이 아니라 독립적인 함수이다 -> showDatePicker함수를 호출하면 마테리얼 디자인의 다이얼로그가 출력될뿐이다
              /// showDatePicker 함수는 비동기(Future<DateTime?>)로 작동하는 머티리얼 디자인 날짜 선택 다이얼로그
              /// 사용자가 날짜를 선택하면 DateTime 객체를 반환하고, 취소하거나 다이얼로그 바깥을 누르면 null을 반환
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      _selectedDate == null
                      ? '날짜를 선택해주세요'
                      : '선택한 날짜: ${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}',
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue, 
                        foregroundColor: Colors.white, 
                        shape: ContinuousRectangleBorder()
                      ),
                      onPressed: () {
                        _openDatePicker();
                      }, 
                      child: Text('날짜 선택하기')
                    )
                  ],
                ),
              ),
              Divider(),

              /// showDatePicker로 넣은 날짜를 textField에 표시하기
              /// DateFormat를 사용하면 편하게 됨 
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: ContinuousRectangleBorder()
                      ),
                      onPressed: () => _openDateText(),
                      child: Text('날짜 선택하기 -> 텍스트 변환'),
                    ),
                    TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        isDense: true,
                        enabled: false,
                        hintText: "날짜가 입력됨",
                        border: OutlineInputBorder()
                      ),

                    )

                  ],
                ),
              ),
              Divider(),

              /// showDatePicker를 사용해서 두개의 날짜 필드를 사용 -> 시작일,종료일
              /// 종료일이 시작일보다 이전이면 유효성 에러 표시하기
              /// firstDate, endDate를 지정하여 날짜 범위 지정
              /// + 시작일을 선택하고 - 종료날짜의 firstDate를 동적으로 갱신(시작일보다 이전 날짜를 선택하게 하지 않도록)
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      _validationMessage,
                      style: TextStyle(
                        color: (_selectedStart == null || _selectedEnd == null) 
                          ? Colors.grey 
                          : (_isDateRangeValid ? Colors.blue : Colors.red)
                      ), 
                    ),
                    Row(
                      mainAxisAlignment: .spaceAround,
                      children: [
                        Column(
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.indigo,
                                foregroundColor: Colors.white,
                                shape: ContinuousRectangleBorder()
                              ),
                              onPressed: () => _openDateStart(),
                              child: Text('시작일 지정하기')
                            ),
                            Text(_selectedStart != null ? DateFormat('yyyy년 MM월 dd일').format(_selectedStart!) : '시작일을 선택하십시오'),
                          ],
                        ),
                        
                        Column(
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.indigo,
                                foregroundColor: Colors.white,
                                shape: ContinuousRectangleBorder()
                              ),
                              onPressed: () => _openDateEnd(),
                              child: Text('종료일 지정하기')
                            ),
                            Text(_selectedEnd != null ? DateFormat('yyyy년 MM월 dd일').format(_selectedEnd!) : '종료일을 선택하십시오'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),

              /// 주말 선택 불가 캘린더
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                        shape: ContinuousRectangleBorder()
                      ),
                      onPressed: _openDateNotWeekend, 
                      child: Text('날짜 선택(주말은 안됨)')
                    ),
                    Text(_selectedDateNotWeekend == null 
                        ? '날짜를 선택하세요' 
                        : DateFormat('yyyy년 MM월 dd일 - EEEE', 'ko_KR').format(_selectedDateNotWeekend!))
                  ],
                ),
              ),
              Divider(),

              /// 날짜 표시 형식 변경
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    RadioGroup<CalendarFormat>(
                      groupValue: _selectedFormat,
                      onChanged: (value) {
                        setState(() {
                          if(value != null) {
                            _selectedFormat = value;
                          }
                        });
                      }, 
                      child: Row(
                        mainAxisAlignment: .spaceEvenly,
                        children: [
                          Row(
                            children: [                             
                              Radio(value: CalendarFormat.calendar),
                              Text(CalendarFormat.calendar.name)
                            ],
                          ),

                          Row(
                            children: [                             
                              Radio(value: CalendarFormat.input),
                              Text(CalendarFormat.input.name)
                            ],
                          ),
                          
                          Row(
                            children: [                             
                              Radio(value: CalendarFormat.calendarOnly),
                              Text(CalendarFormat.calendarOnly.name)
                            ],
                          ),
                          
                          Row(
                            children: [                             
                              Radio(value: CalendarFormat.inputOnly),
                              Text(CalendarFormat.inputOnly.name)
                            ],
                          )
                        ],
                      )
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.white,
                        shape: ContinuousRectangleBorder()
                      ),
                      onPressed: () => _openDate(), 
                      child: Text('달력 출력')
                    )
                  ],
                ),
              ),
              Divider(),


              /// 달력 테마 변경 + 딤 
              Container(
                padding: EdgeInsets.all(16),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.lightGreen,
                    foregroundColor: Colors.white,
                    shape: ContinuousRectangleBorder()
                  ),
                  onPressed: _openStyleDate, 
                  child: Text('테마 달력 열기')
                ),
              ),
              Divider(),



              /// 날짜 범위 지정하기 - showDateRangePicker
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextButton(onPressed: onPressed, child: child),
                    Text('')
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

enum CalendarFormat {
  calendar,
  input,
  calendarOnly,
  inputOnly
}