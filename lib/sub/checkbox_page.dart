import 'package:flutter/material.dart';

class CheckboxPage extends StatefulWidget {
  const CheckboxPage({super.key});

  @override
  State<CheckboxPage> createState() => _CheckboxPageState();
}

class _CheckboxPageState extends State<CheckboxPage> {
  bool _isChecked = false;
  bool _isCheckedState = false;
  bool? _value = false;
  String get _stateLabel {
    if(_value == true) return "전체 선택됨";
    if(_value == false) return "전체 해제됨";
    return "일부만 선택됨(중간 상태)";
  }


  bool _basicChecked = true;
  bool? _fillColorChecked = true;


  final Set<String> _selectedIds = {};
  final List<_Item> _items = List.generate(
    3,
    (i) => _Item(id: 'ITEM-$i', name: '품목 ${i + 1}'),
  );

  void _toggleItem(String id, bool? checked) {
    setState(() {
      if (checked == true) {
        _selectedIds.add(id);
      } else {
        _selectedIds.remove(id);
      }
    });
  }
  

  final Set<String> _selectedTriIds = {};
  final List<_Item> _triItems = List.generate(
    3,
    (i) => _Item(id: 'ITEM-$i', name: '품목 ${i + 1}'),
  );

  // 하위 항목 상태로부터 상단 체크박스의 value를 계산
  bool? get _selectAllValue {
    if (_selectedTriIds.isEmpty) return false;
    if (_selectedTriIds.length == _triItems.length) return true;
    return null; // 일부만 선택된 상태 → 중간 상태
  }
  void _toggleTriItem(String id, bool? checked) {
    setState(() {
      if (checked == true) {
        _selectedTriIds.add(id);
      } else {
        _selectedTriIds.remove(id);
      }
    });
  }
  void _onSelectAllChanged(bool? checked) {
    setState(() {
      if (checked == true) {
        // 1. 전체 선택: 모든 항목의 ID를 Set에 추가
        _selectedTriIds.addAll(_triItems.map((item) => item.id));
      } else {
        // 2. 전체 해제 (false 또는 null에서 클릭 시): Set을 완전히 비움
        _selectedTriIds.clear();
      }
    });
  }


  final Set<String> _selectedCheckListIds = {};
  final List<_Item> _checkList = List.generate(2, (index) => _Item(id: 'ITEM-$index', name: '품목 ${index + 1}'));
  
  bool get _isValideButton {
    if(_selectedCheckListIds.length == _checkList.length) return true;
    return false;
  }
  void _toggleCheckItem(String id, bool? chekced) {
    setState(() {
      if(chekced == true) {
        _selectedCheckListIds.add(id);
      } else {
        _selectedCheckListIds.remove(id);
      }
    });
  }


  final _formKey = GlobalKey<FormState>();
  bool _agreedToTerms = false; // onSaved로 최종 저장될 값

  void _submit() {
    final isValid = _formKey.currentState!.validate();

    if(!isValid) {
      return;
    }

    // save는 각 필드의 onSaved 콜백을 실행함
    _formKey.currentState!.save();

    debugPrint('제출됨: 약관 동의 = $_agreedToTerms');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('제출 완료')),
    );
  }


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

              // tristate를 활용한 checkbox에 true/fasle 그리고 null값 전달
              Container(
                padding: EdgeInsets.all(16),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Checkbox(
                      value: _value,
                      tristate: true, // 기본값은 false 
                      onChanged: (bool? newValue) {
                        // newValue는 Checkbox 내부 로직에 따라
                        // false -> true -> null -> false 순서로 자동 전달됨
                        setState(() {
                          _value = newValue;
                        });
                      }, 
                    ),
                    Text(_stateLabel),
                    Text('현재 value: $_value'),
                  ],
                ),
              ),
              Divider(),

              // 색상 커스텀
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Checkbox(
                      value: _basicChecked,
                      activeColor: Colors.deepOrange,   // 체크되었을 때 배경 상자의 색상
                      checkColor: Colors.white,         // 체크 표시의 색상
                      side: BorderSide(                   // 체크되지 않은 상태일 때 테두리의 색상과 두께
                        color: Colors.grey,
                        width: 2
                      ), 
                      shape: RoundedRectangleBorder(),    // 체크박스의 외형 모양
                      onChanged: (value) => setState(() => _basicChecked = value ?? false),
                    ),

                    Checkbox(
                      tristate: true, 
                      value: _fillColorChecked,
                      // 모든 상태별 배경색 제어(체크/해제/비활성화/호버) - activeColor보다 더 높은 우선순위를 가짐
                      fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
                        // 비활성화 상태 - (onChanged: null) - onChanged가 null이면 기능을 할수 없는 상태
                        if (states.contains(WidgetState.disabled)) { 
                          return Colors.white;  
                        }

                        // selected 삼중 제어
                        if (states.contains(WidgetState.selected)) {
                          // value가 null(삼중 상태)인 경우 별도 색상 지정
                          if (_fillColorChecked == null) {
                            return Colors.amber; // null 상태일 때 (예: 노란색)
                          }
                          return Colors.teal; // true(체크됨)일 때
                        }
                        
                        // 호버 상태일때
                        if(states.contains(WidgetState.hovered)) {
                          return Colors.grey; 
                        }
                        
                        // 기본 상태 (체크 해제 및 활성화 상태)
                        return Colors.white; 
                      }),
                      checkColor: Colors.white,
                      //side: const BorderSide(color: Colors.teal, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16), // 모서리 둥글게
                      ),
                      onChanged: (value) => setState(() => _fillColorChecked = value),
                    )
                  ],
                ),
              ),
              Divider(),


              // CheckboxListTile로 다중 선택 리스트
              Container(
                padding: EdgeInsets.all(16),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    final isChecked = _selectedIds.contains(item.id);

                    return CheckboxListTile(
                      title: Text(item.name), // 제목
                      subtitle: Text(item.id),  // 부제목
                      value: isChecked,
                      controlAffinity: ListTileControlAffinity.leading, // 체크박스를 왼쪽에 배치
                      onChanged: (value) => _toggleItem(item.id, value),
                    );
                  },
                ),
              ),
              Divider(),


              // 전체선택/전체해제 + tristate 동기화
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    CheckboxListTile(
                      title: Text(
                        '전체선택 (${_selectedIds.length}/${_items.length})',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      value: _selectAllValue,
                      tristate: true, // value가 null(중간 상태)을 표시할 수 있어야 하므로 필수
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: _onSelectAllChanged,
                    ),
                    const Divider(height: 1),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        final item = _items[index];
                        final isChecked = _selectedTriIds.contains(item.id);
                    
                        return CheckboxListTile(
                          title: Text(item.name),
                          subtitle: Text(item.id),
                          value: isChecked,
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (checked) => _toggleTriItem(item.id, checked),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Divider(),

              // 전체 선택해야 다음 버튼 활성화
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _checkList.length,
                      itemBuilder: (context, index) {
                        final item = _checkList[index];
                        final checked = _selectedCheckListIds.contains(item.id);

                        return Checkbox(
                          value: checked, 
                          onChanged: (value) => _toggleCheckItem(item.id, value)                          
                        );
                      },
                    ),
                    TextButton(
                      onPressed: _isValideButton 
                        ? () { print('버튼 클릭됨'); }
                        : null,
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(),
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: Colors.grey,
                        disabledForegroundColor: Colors.white70,
                      ),
                      child: Text(_isValideButton ? '활성화' : '비활성화'),
                    )
                  ],
                ),
              ),
              Divider(),


              // Form + checkBox 연결
              // Container(
              //   padding: EdgeInsets.all(16),
              //   child: Form(
              //     key: _formKey,
              //     child: Padding(
              //       padding: const EdgeInsets.all(16),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           CheckboxFormField(
              //             title: '[필수] 이용약관에 동의합니다',
              //             initialValue: false,
              //             validator: (bool? value) {
              //               if (value != true) {
              //                 return '필수 약관에 동의해야 합니다.';
              //               }
              //               return null; // 문제 없음
              //             },
              //             onSaved: (bool? value) {
              //               _agreedToTerms = value ?? false;
              //             },
              //           ),
              //           const SizedBox(height: 16),
              //           ElevatedButton(
              //             onPressed: _submit,
              //             child: const Text('제출'),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // Divider(),


              // 


            ]
          ),
        ),
      ),
      bottomNavigationBar: _selectedTriIds.isEmpty
        ? null
        : SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: ElevatedButton(
                onPressed: () {
                  debugPrint('확정된 id 목록: $_selectedTriIds');
                },
                child: Text('${_selectedTriIds.length}개 항목 처리'),
              ),
            ),
          ),
    );
  }
}

class _Item {
  final String id;
  final String name;
  _Item({required this.id, required this.name});
}

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField({
    super.key,
    required String title,
    bool initialValue = false,
    super.onSaved,
    super.validator,
    super.autovalidateMode,
  }) : super(
          initialValue: initialValue,
          builder: (FormFieldState<bool> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CheckboxListTile(
                  title: Text(title),
                  value: state.value ?? false, 
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (value) {
                    // 값변경 + 리빌드 + (설정에 따라)재검증을 한번에 처리하는 메서드
                    // setState를 직접 호출하는 대신 이것을 써야 함
                    state.didChange(value);
                  },
                ),
                // 에러 메세지 표시 영역
                // state.hasError가 true일 때만(즉 validator가 null이 아닌 문자열을 반환했을 때만) 렌더링
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 8),
                    child: Text(
                      state.errorText!,
                      style: TextStyle(
                        color: Theme.of(state.context).colorScheme.error,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            );
          }
        );
}