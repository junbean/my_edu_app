import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShowTimePickerPage extends StatefulWidget {
  const ShowTimePickerPage({super.key});

  @override
  State<ShowTimePickerPage> createState() => _ShowTimePickerPageState();
}

class _ShowTimePickerPageState extends State<ShowTimePickerPage> {

  // timePicker 기본적인 사용방법
  TimeOfDay? _selectedTime;
  String? get _selectedPriod {
    if(_selectedTime != null) {
      return _selectedTime!.period == DayPeriod.am ? '오전' : '오후'; 
    }
    return null; 
  }

  Future<void> _openTimePicker() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context, 
      initialTime: _selectedTime ?? TimeOfDay.now()
    );

    if(pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  } 

  
  ///
  TimeOfDay? _selectedTimeText;
  late TextEditingController _controller;
  
  Future<void> _openTimePickerToText() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context, 
      initialTime: _selectedTimeText ?? TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
      barrierDismissible: false
    );

    if(pickedTime != null) {
      setState(() {
        _selectedTimeText = pickedTime;
        _controller.text = _selectedTimeText!.format(context);
      });
    }
  }


  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('showTimePicker 연습 페이지'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          alignment: .topCenter,
          child: Column(
            children: [
              /// showTimePicker의 기본 사용 방법
              ///   context: 다이얼로그를 띄울 위치의 빌드 컨텍스트
              ///       -context: context,
              ///   initialTime: 다이얼로그가 처음 열렸을 때 시계 바늘이나 숫자가 가리키고 있을 기본 시간
              ///       -initialTime: const TimeOfDay(hour: 14, minute: 30), // 오후 2시 30분 기본 선택
              ///   initialEntryMode: 다이얼로그가 처음 열릴 때 시계 형태(dial)로 보일지, 키보드 직접 입력 형태(input)로 보일지 설정
              ///       -dial: 원형 시계 모드 (기본값)
              ///       -input: 숫자 직접 입력 모드
              ///       -dialOnly: 키보드 입력 전환 버튼을 없애고 시계만 사용
              ///       -inputOnly: 시계 전환 버튼을 없애고 숫자 입력만 사용
              ///       -initialEntryMode: TimePickerEntryMode.inputOnly, // 숫자 직접 입력 모드로 고정
              ///   builder: 다이얼로그의 테마(ThemeData)나 다이얼로그 포맷(24시간제 강제 지정 등)을 커스텀할 때 사용
              //        -builder: (BuildContext context, Widget? child) {
              //        -  return MediaQuery(
              //        -    // 기기 설정과 무관하게 24시간제(13:00 등) 강제 적용
              //        -    data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              //        -    child: Theme(
              //        -      data: ThemeData.dark().copyWith(
              //        -        timePickerTheme: const TimePickerThemeData(
              //        -          dialHandColor: Colors.orange, // 시계 바늘 색상
              //        -        ),
              //        -      ),
              //        -      child: child!,
              //        -    ),
              //        -  );
              //        -},
              ///   helpText: 다이얼로그 상단에 표시되는 안내 타이틀 문구
              ///       -helpText: '알람 시간 선택',
              ///   cancelText: 취소 버튼의 텍스트를 변경
              ///       -cancelText: '닫기',
              ///   confirmText: 확인 버튼의 텍스트를 변경
              ///       -confirmText: '설정완료',
              ///   errorInvalidText: 텍스트 입력 모드에서 유효하지 않은 시간(예: 25시, 65분)을 입력했을 때 출력되는 에러 메시지
              ///       -errorInvalidText: '올바른 시간을 입력해주세요.',
              ///   orientation: 다이얼로그의 세로/가로 방향을 강제로 지정합니다 
              ///       -Orientation.portrait 또는 Orientation.landscape
              ///       -orientation: Orientation.portrait,
              ///   switchToCalendarEntryModeIcon / switchToInputEntryModeIcon: 시계 뷰와 키보드 입력 뷰 사이를 전환하는 다이얼로그 좌측 하단 아이콘을 커스텀
              //        -switchToDialEntryModeIcon: const Icon(Icons.access_time),
              //        -switchToInputEntryModeIcon: const Icon(Icons.keyboard),
              ///   useRootNavigator: 최상위 루트 내비게이터를 사용할지 여부를 지정합니다. (기본값: true)
              ///       -useRootNavigator: true,
              ///   routeSettings: 다이얼로그 라우트에 지정할 분석/추적용 설정 객체
              ///       -routeSettings: const RouteSettings(name: '/time_picker_dialog'),
              ///   anchorPoint: 멀티 디스플레이 환경 등에서 다이얼로그가 위치할 기준 좌표점을 지정
              ///       -anchorPoint: const Offset(100, 200),
              ///   barrierDismissible: 바깥 영역을 눌러 다이얼로그를 닫을 수 있게 할지 여부를 결정합니다. (기본값: true)
              ///       -barrierDismissible: false, // 버튼을 통해서만 닫을 수 있음
              ///   barrierColor: 다이얼로그 뒤쪽 배경 딤(Dim) 색상을 변경
              ///       -barrierColor: Colors.black.withAlpha(150),
              ///   barrierLabel: 접근성(스크린 리더) 음성 읽기용 바깥 영역 라벨
              ///       -barrierLabel: '시간 선택 창 닫기',

  
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: ContinuousRectangleBorder(),
                      ),
                      onPressed: _openTimePicker,
                      child: Text('시간 선택하기'),
                    ),
                    Text(
                      _selectedTime != null ? '선택한 시간: $_selectedPriod ${_selectedTime!.hour}시 ${_selectedTime!.minute}분' : '시간 선택 안됨' 
                    ),
                    Text(
                      _selectedTime != null ? '포맷팅 텍스트: ${_selectedTime!.format(context)}' : '시간 선택 안됨' 
                    )
                  ],
                ),
              ),
              Divider(),

              /// 직접 화면에 포멧팅
              TimePickerDialog(
                initialTime: _selectedTime ?? TimeOfDay.now(),
                initialEntryMode: TimePickerEntryMode.dial,
              ),
              Divider(),


              /// 선택된 시간을 입력창에 입력하게 함
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: ContinuousRectangleBorder(),
                      ),
                      onPressed: _openTimePickerToText,
                      child: Text('시간 선택하기'),
                    ),
                    TextField(
                      controller: _controller,
                      style: TextStyle(color: Colors.black),
                      cursorColor: Colors.black,
                      readOnly: true,
                      enabled: false,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.zero),
                          borderSide: BorderSide(color: Colors.black)
                        ),
                        isDense: true,
                      ),
                    )
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