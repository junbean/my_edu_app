import 'package:flutter/material.dart';

class SwitchPage extends StatefulWidget {
  const SwitchPage({super.key});

  @override
  State<SwitchPage> createState() => _SwitchPageState();
}

class _SwitchPageState extends State<SwitchPage> {
  bool _isSwitched = false;
  bool _isDisabled = false;
  bool _isNotificationOn = true;
  
  ThemeMode _themeMode = ThemeMode.system;
  bool get _isDark {
    if(_themeMode == ThemeMode.dark) return true;
    return false;
  }  
  void _toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      appBar: AppBar(
        title: Text("스위치 연습 페이지"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          alignment: .topCenter,
          child: Column(
            children: [

              // 기본적인 스위치 사용 방법
              Container(
                padding: EdgeInsets.all(16),
                child: Switch(
                  value: _isSwitched, 
                  onChanged: (value) {
                    setState(() {
                      _isSwitched = value;
                      debugPrint('스위치의 값은 $_isSwitched');
                    });
                  },
                ),  
              ),
              Divider(),

              /// 스위치의 속성 활용
              ///   value: 스위치의 현재 On/Off 상태(true면 켜짐, false면 꺼짐)
              ///   onChanged: 사용자가 스위치를 누르거나 드래그하여 상태를 바꿨을 때 실행되는 콜백 함수
              ///       -이 속성에 null을 전달하면 스위치가 비활성화되어 터치할 수 없게 됨
              ///   activeColor: 스위치가 켜졌을 때(On) 동그란 원(Thumb)의 색상
              ///   activeTrackColor: 스위치가 켜졌을 때(On) 뒤쪽 트랙(Track)의 색상
              ///   inactiveThumbColor: 스위치가 꺼졌을 때(Off) 동그란 원(Thumb)의 색상
              ///   inactiveTrackColor: 스위치가 꺼졌을 때(Off) 뒤쪽 트랙(Track)의 색상
              Container(
                padding: EdgeInsets.all(16),
                child: Switch(
                  value: _isNotificationOn,
                  // 비활성화 토글 체크
                  onChanged: _isDisabled
                      ? null // null이면 비활성화 상태
                      : (bool value) {
                          setState(() {
                            _isNotificationOn = value;
                          });
                        },
                  // On / Off 시 색상 설정
                  activeColor: Colors.white,
                  activeTrackColor: Colors.deepPurple,
                  inactiveThumbColor: Colors.grey.shade400,
                  inactiveTrackColor: Colors.grey.shade200,
                  
                  // Thumb 내부에 상태별 아이콘 넣기 (상태에 맞게 아이콘 변경)
                  thumbIcon: WidgetStateProperty.resolveWith<Icon?>((states) {
                    if (states.contains(WidgetState.selected)) {
                      return const Icon(Icons.check, color: Colors.deepPurple);
                    }
                    return const Icon(Icons.close, color: Colors.white);
                  }),
                ),
              ),
              Divider(),

              // switchListTiel을 활용 및 배경 색상 제어
              Container(
                padding: EdgeInsets.all(16),
                child: SwitchListTile(
                  title: Text('다크 모드', style: TextStyle(color: _isDark ? Colors.white : Colors.black)),
                  subtitle: Text('앱의 테마를 어둡게 전환합니다.', style: TextStyle(color: _isDark ? Colors.white : Colors.black)), 
                  secondary: Icon(Icons.brightness_6, color: _isDark ? Colors.white : Colors.black), // 좌측 아이콘
                  tileColor: _isDark ? Colors.black : Colors.white,
                  activeThumbColor: Colors.black,
                  activeTrackColor: Colors.white,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.black,
                  trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((states) {
                    if(states.contains(WidgetState.selected)) return Colors.white;
                    return Colors.black;
                  }),
                  thumbIcon: WidgetStateProperty.resolveWith<Icon?>((states) {
                    if(states.contains(WidgetState.selected)) return Icon(Icons.brightness_2, color: Colors.white,);
                    return Icon(Icons.brightness_5, color: Colors.black,);
                    
                  }),
                  value: _isDark,
                  onChanged: (bool value) {
                    setState(() => _toggleTheme(value));
                  },
                ),
              ),
              Divider(),



            ],
          ),
        ),
      ),
    );
  }
}