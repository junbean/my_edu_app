import 'package:flutter/material.dart';

class CheckboxPage extends StatefulWidget {
  const CheckboxPage({super.key});

  @override
  State<CheckboxPage> createState() => _CheckboxPageState();
}

class _CheckboxPageState extends State<CheckboxPage> {
  bool _isChecked = false;
  bool _isCheckedState = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("체크버튼 학습"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          alignment: .topCenter,
          child: Column(
            children: [
              /// setState없이 checkbox사용 - 화면에 반응없음
              Container(
                padding: EdgeInsets.all(16),
                child: Checkbox(
                  value: _isChecked,
                  onChanged: (bool? newValue) {
                    _isChecked = newValue ?? false;
                    // setState가 없으므로 이 대입은 로컬 변수만 바꿀 뿐
                    // Flutter에게 "다시 그려라"는 신호를 전혀 주지 못함
                    debugPrint('isChecked 변경됨: $_isChecked (하지만 화면엔 반영 안 됨)');
                  },
                ),
              ),
              Divider(),

              /// setStaet를 사용한 checkbox - 화면에 반영됨
              Container(
                padding: EdgeInsets.all(16),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Checkbox(
                      value: _isCheckedState,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _isCheckedState = newValue ?? false;
                        });
                      },
                    ),
                    Text(_isCheckedState ? "체크됨" : "체크안됨")
                  ],
                ),
              ),
              Divider(),


            ]
            
          ),
        ),
      )
    );
  }
}