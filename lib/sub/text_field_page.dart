import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:my_edu_app/util/formatter/phone_number_formatter.dart';
import 'package:my_edu_app/util/text_controller/mention_text_controller.dart';

class TextFieldPage extends StatefulWidget {
  const TextFieldPage({super.key});

  @override
  State<TextFieldPage> createState() => _TextFieldPageState();
}

class _TextFieldPageState extends State<TextFieldPage> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _countController = TextEditingController();
  final TextEditingController _enableController = TextEditingController();
  final TextEditingController _errorController = TextEditingController();
  String? _errorMsg;

  final TextEditingController _formController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _userId = '';

  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();

  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  String _currentOTP = '';

  final TextEditingController _pwController = TextEditingController();
  bool _isObscure = true;
  String? _pwErrorMsg;
  int _pwScore = 0;
  double _pwProgress = 0.0;
  Color _pwProgressColor = Colors.red;

  final TextEditingController _formatterController = TextEditingController();

  final TextEditingController _numberFormatterController =
      TextEditingController();
  final FocusNode _numberFormatterFocusNode = FocusNode();
  final _formatter = NumberFormat('#,###'); // 천 단위 콤마

  final TextEditingController _debounceController = TextEditingController();

  final List<String> _allItems = [
    '하나',
    '하나씩',
    '하나둘삼넷',
    '둘삼넷',
    '삼넷오여섯',
    '둘삼칠',
    '오공공',
  ];

  final _overlayController = TextEditingController();
  final _overlayFocusNode = FocusNode();
  final _overlayerLink = LayerLink(); // 입력창 ↔ 드롭다운 연결
  OverlayEntry? _overlayEntry; // 떠 있는 드롭다운 (없을 땐 null)

  final _overlayerItems = ['apple', 'banana', 'cherry', 'grape', 'orange'];
  final List<String> _overlayerFiltered = [];

  final List<String> _tags = []; // 태그 저장소
  final TextEditingController _tagController = TextEditingController();
  final FocusNode _tagFocusNode = FocusNode();

  final MentionTextController _mentionTextController = MentionTextController();

  // ============================================================================

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controllers = List.generate(6, (index) => TextEditingController());
    _focusNodes = List.generate(6, (index) => FocusNode());

    for (int i = 0; i < 6; i++) {
      _focusNodes[i].addListener(() {
        if (_focusNodes[i].hasFocus) {
          _controllers[i].selection = TextSelection(
            baseOffset: 0,
            extentOffset: _controllers[i].text.length,
          );
        }
      });
    }

    _numberFormatterFocusNode.addListener(() {
      if (!_numberFormatterFocusNode.hasFocus) {
        final raw = _numberFormatterController.text.replaceAll(
          ',',
          '',
        ); // 기존엥 있던 콤마 제거
        final number = int.parse(raw); // 정수로 변환
        _numberFormatterController.text = _formatter.format(
          number,
        ); // 포멧터를 적용 - 포커스 사라진후에 적용함
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _countController.dispose();
    _enableController.dispose();
    _errorController.dispose();
    _formController.dispose();
    _controller1.dispose();
    _controller2.dispose();

    _focusNode1.dispose();
    _focusNode2.dispose();

    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }

    _pwController.dispose();

    _formatterController.dispose();

    _numberFormatterController.dispose();
    _numberFormatterFocusNode.dispose();

    _debounceController.dispose();
    _debounce?.cancel();

    _tagController.dispose();
    _tagFocusNode.dispose();

    _mentionTextController.dispose();
    super.dispose();
  }

  // ===========================================================================

  OutlineInputBorder myBorder(Color color) {
    return OutlineInputBorder(borderSide: BorderSide(width: 1.0, color: color));
  }

  int checkPasswordStrength(String password) {
    int score = 0;
    if (password.length >= 8) score++;
    if (password.length >= 12) score++;
    if (password.contains(RegExp(r'[0-9]'))) score++;
    if (password.contains(RegExp(r'[A-Z]'))) score++;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) score++;
    return score;
  }

  double calculateProgress(int score) {
    return score / 5.0;
  }

  Color calculateProgressColor(double progress) {
    // progress = 0.0 ~ 1.0
    Color color;
    if (progress <= 0.4) {
      color = Colors.red;
    } else if (progress <= 0.7) {
      color = Colors.orange;
    } else {
      color = Colors.green;
    }
    return color;
  }

  Timer? _debounce;

  void _onDebounce(String text) {
    _debounce?.cancel(); // 이전 타이머 취소
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (text != "") _callApi(text);
    });
  }

  // 목업 api호출
  void _callApi(String query) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(query)));
  }

  // 태그 추가
  void _addTag(String value) {
    final tag = value.replaceAll(',', '');
    if (tag.isEmpty || _tags.contains(tag)) return;
    setState(() {
      _tags.add(tag);
    });
    _tagController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("텍스트필드 학습"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: .start,
          children: [
            // 첫번째 텍스트 필드 영역
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _textController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    // 엔터 누르면 -> 다음으로
                    maxLength: 20,
                    maxLines: 1,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      labelText: "텍스트 필드",
                      hintText: "아무글자나 입력하세요",
                      prefixIcon: const Icon(Icons.person),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _textController.clear();
                          });
                        },
                        icon: const Icon(Icons.clear),
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  Container(
                    alignment: .center,
                    child: Text(
                      _textController.text.isNotEmpty
                          ? _textController.text.toString()
                          : "텍스트 필드 따라 입력됨",
                      style: TextStyle(
                        fontSize: 16,
                        color: _textController.text.isNotEmpty
                            ? Colors.black
                            : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),

            // 두번째 영역
            // 알아낸거 - 텍스트필드에서 border는 포커스 상태일때 무시된다
            //    border — 특정 상태용 테두리가 지정되지 않았을 때 적용되는 기본값
            //    enabledBorder — 활성화 상태이고 포커스가 없으며 오류도 없을 때
            //    focusedBorder — 포커스를 받았을 때 (오류 없음)
            //    errorBorder — 오류(errorText)가 있고 포커스가 없을 때ㅁ
            //    focusedErrorBorder — 오류가 있으면서 포커스도 받았을 때
            //    disabledBorder — 비활성화(enabled: false)일 때

            //    비활성화 → disabledBorder
            //    오류 + 포커스 → focusedErrorBorder
            //    오류 + 포커스 없음 → errorBorder
            //    포커스 (오류 없음) → focusedBorder
            //    활성·포커스 없음·오류 없음 → enabledBorder
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _countController,
                    decoration: InputDecoration(
                      labelText: "텍스트 카운터",
                      labelStyle: TextStyle(
                        color: _countController.text.length >= 10
                            ? Colors.redAccent
                            : Colors.black,
                      ),
                      hintText: "입력한 텍스트에 따라 카운트 합니다",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _countController.clear();
                          });
                        },
                        icon: const Icon(Icons.clear),
                      ),
                      suffixIconColor: _countController.text.length >= 10
                          ? Colors.red
                          : Colors.black,
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: _countController.text.length >= 10
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: _countController.text.length >= 10
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: _countController.text.length >= 10
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                      // maxLength를 설정하면 하단에 나오는 0/10 같은 카운터 텍스트
                      counterStyle: TextStyle(
                        color: _countController.text.length >= 10
                            ? Colors.red
                            : Colors.grey,
                        fontSize: 12,
                      ),
                      // 혹은 counterText을 아예 빈문자로 만들수 있음
                      //counterText: '',
                    ),
                    style: TextStyle(
                      color: _countController.text.length >= 10
                          ? Colors.red
                          : Colors.black,
                    ),
                    onChanged: (_) => setState(() {}),
                    maxLength: 10,
                  ),
                  Container(
                    alignment: .center,
                    child: Text(
                      _countController.text.isNotEmpty
                          ? _countController.text.length.toString()
                          : "글자수에 따라 카운트",
                    ),
                  ),
                ],
              ),
            ),
            Divider(),

            // 세번째 영역
            // 텍스트 유무에 따른 버튼 활성화
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _enableController,
                    onChanged: (value) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: "",
                      suffixIcon: IconButton(
                        onPressed: () => setState(() {
                          _enableController.clear();
                        }),
                        icon: Icon(Icons.clear, color: Colors.black),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.grey,
                      filled: true,
                    ),
                    style: TextStyle(color: Colors.white),
                    maxLength: 15,
                  ),
                  Container(
                    alignment: .center,
                    child: TextButton(
                      onPressed: () {
                        if (_enableController.text.isEmpty) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(_enableController.text.toString()),
                            duration: Duration(seconds: 5),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        shape: ContinuousRectangleBorder(),
                        backgroundColor: _enableController.text.isEmpty
                            ? Colors.amberAccent
                            : Colors.lightGreen,
                      ),
                      child: Text(
                        _enableController.text.isEmpty ? "버튼 비활성화" : "버튼 활성화",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),

            // 네번째 영역
            // 에러 텍스트 사용
            // errorText는 안에 실제 문자열 값이 있는 경우에 표시, null이면 에러 상태가 아니게됨
            // 에러텍스트는 하단에 표시된다
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _errorController,
                    onChanged: (value) {
                      setState(() {
                        if (_errorController.text.contains("@")) {
                          _errorMsg = "@를 붙이면 에러텍스트입니다.";
                        } else {
                          _errorMsg = null;
                        }
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "에러텍스트 테스트",
                      hintText: "@을 붙이면 에러텍스트",
                      errorText: _errorMsg,
                      errorStyle: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0, color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0, color: Colors.red),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0),
                      ),
                    ),
                    cursorColor: Colors.blueAccent,
                    // 깜빡거리는 커서 색상을 바꿀때
                    cursorErrorColor: Colors.pink,
                  ),
                ],
              ),
            ),
            Divider(),

            // 다섯번째 영역
            // TextFormField - form 사용
            Container(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _formController,
                      decoration: InputDecoration(
                        labelText: '아이디',
                        border: myBorder(Colors.grey),
                        enabledBorder: myBorder(Colors.grey),
                        focusedBorder: myBorder(Colors.blueAccent),
                        errorBorder: myBorder(Colors.red),
                        focusedErrorBorder: myBorder(Colors.redAccent),
                      ),
                      // 유효성 검사 로직

                      // validator에서 반환하는건 errorText로 전달됨
                      validator: (value) {
                        if (value == null || value == '') return '아이디를 입력해주세요';

                        if (value.length < 4) return '4글자 이상 입력하세요';

                        return null;
                      },
                      // formKey.currentState!.save() 호출 시 실행됨
                      onSaved: (newValue) {
                        _userId = newValue ?? '';
                      },
                      // 검증을 언제 자동으로 수행할지 결정
                      autovalidateMode: AutovalidateMode
                          .disabled, //validate()를 명시적으로 호출할 때만 검증
                      // AutovalidateMode.onUserInteraction - 사용자가 입력을 시작한 뒤부터 입력이 바뀔 때마다 자동 검증
                      // AutovalidateMode.always - 항상 검증
                    ),
                    // 버튼 영역
                    TextButton(
                      onPressed: () {
                        // 클릭 시 모든 TextFormField의 validator 실행
                        // _formKey.currentState.validation()
                        //    모든 자식 필드의 validator를 실행, 하나라도 오류 메세지를 반환하면 false(+에러메세지 표시), 접부 통과하면 true반환
                        // _formKey.currentState.save()
                        //    모든 자식 필드의 onSaved 콜백을 실행. 입력값을 한꺼번에 모델/변수로 옮길때 쓴다
                        // _formKey.currentState.reset()
                        //    모든 필드를 초기값으로 되돌리고 오류 표시를 지운다
                        if (_formKey.currentState != null &&
                            _formKey.currentState!.validate()) {
                          // 모든 검사가 통과되면 onSaved 실행
                          _formKey.currentState!.save();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('로그인 유효성 검사 성공')),
                          );
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.indigoAccent,
                        shape: ContinuousRectangleBorder(),
                      ),
                      child: Text(
                        "Form 아이디 유효성 검사",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(),

            // 여섯번째 영역
            // focusNode 다루기
            // focusNode를 직접 연결하지 않으면 플러터 내부적으로 focus자동노드를 만들어씀
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _controller1,
                    focusNode: _focusNode1,
                    decoration: InputDecoration(
                      hintText: "입력하고 엔터하면 다음 필드로",
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.black87,
                      filled: true,
                    ),
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.next,
                    // 실행 환경에 의존성이 있음, 엔터키를 누르면 입력값을 인자로 받음
                    onSubmitted: (_) {
                      print("onSubmitted 실행");
                      print("_focusNode1에 포커스가 있나? ${_focusNode1.hasFocus}");
                      // 이러면 false가 나올것 같지만 true가 나온다
                      // onEditingComplete에서 _focusNode2에 포커스를 줬지만 즉시 적용이 되는것이 아님 -> 아직 반영이 되지 않음
                    },
                    // 이것도 모바일에서만 동작하는듯, onSubmitted보다 먼저 실행됨, 입력값을 인자로 받지 않고 단순 입력이 끝났다에 한정됨
                    onEditingComplete: () {
                      print("onEditingComplete 실행");
                      // FocusScope.of(context).nextFocus(); - 트리구조에 따라서 다음 텍스트필드에 접근하지 못하는 경우가 있음

                      // 포커스를 코드로 주입하는 방법(즉시가 아닌 비동기로 반영, 화면빌드가 끝나기 전 호출하면 노드가 아직 트리에 연결되지 않아 동작하지 않을 수 있음)
                      _focusNode2.requestFocus();
                      //FocusScope.of(context).requestFocus(_focusNode2);
                    },
                  ),
                  Container(height: 8),
                  TextField(
                    controller: _controller2,
                    focusNode: _focusNode2,
                    decoration: InputDecoration(
                      hintText: "여기로",
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.black,
                      filled: true,
                    ),
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                  ),
                ],
              ),
            ),
            Divider(),

            // 일곱번째 영역
            // OTP 비번과 같은 것
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: List.generate(
                      6,
                      (index) => Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: TextField(
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
                            maxLength: 1,
                            decoration: InputDecoration(
                              counterText: '',
                              border: OutlineInputBorder(),
                            ),
                            textAlign: TextAlign.center,
                            style: TextStyle(),
                            onChanged: (value) {
                              print('${value.length}, $value');
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _currentOTP = '';
                      for (var controller in _controllers) {
                        if (controller.text.isEmpty) return;

                        _currentOTP += controller.text;
                      }

                      if (_currentOTP.length == 6) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(_currentOTP)));
                      }
                    },
                    style: TextButton.styleFrom(
                      shape: ContinuousRectangleBorder(),
                      backgroundColor: Colors.black,
                    ),
                    child: Text(
                      "OPT 전송",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),

            // 여덟번째 영역
            // 비밀번호 강도 수치 측정 로직
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _pwController,
                    decoration: InputDecoration(
                      labelText: "비밀번호 강도 테스트",
                      hintText: "비밀번호을 입력하세요",
                      border: OutlineInputBorder(),
                      errorText: _pwErrorMsg,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                    ),
                    obscureText: _isObscure,
                    onChanged: (value) {
                      setState(() {
                        _pwScore = checkPasswordStrength(value);
                        _pwProgress = calculateProgress(_pwScore);
                        _pwProgressColor = calculateProgressColor(_pwProgress);
                        print('$_pwScore , $_pwProgress, $_pwProgressColor');
                      });
                    },
                    onSubmitted: (value) {
                      if (value.length < 4) {
                        _pwErrorMsg = '비밀번호는 최소 5이상입니다';
                      } else {
                        _pwErrorMsg = null;
                      }
                    },
                  ),
                  Container(height: 8),
                  LinearProgressIndicator(
                    value: _pwProgress,
                    backgroundColor: Colors.grey[300],
                    color: _pwProgressColor,
                  ),
                ],
              ),
            ),
            Divider(),

            // 아홉번재 영역
            // 포메터를 사용
            //    TextInputFormatter는 사용자가 텍스트필드에 입력하는 도중에 그 값을 가로채 원하는 형태로 변형·제한하는 객체
            //    FilteringTextInputFormatter — 특정 문자만 허용하거나 차단한다.
            //        FilteringTextInputFormatter.digitsOnly                    // 숫자만
            //        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))       // 정규식 허용
            //        FilteringTextInputFormatter.deny(RegExp(r'[\s]'))         // 정규식 차단(공백 등)
            //    LengthLimitingTextInputFormatter — 최대 길이 제한
            //        LengthLimitingTextInputFormatter(10)
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: '전화번호 포멧',
                      hintText: '-없이 번호를 입력하세요',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly, // 숫자만 허용
                      LengthLimitingTextInputFormatter(13), // 하이픈 포함 텍스트 길이
                      PhoneNumberFormatter(),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),

            // 열번째 영역
            // 사후 포멧팅 - 포커스가 끝나면 포멧을 적용시킴 - 근데 이거 좀 구린듯
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _numberFormatterController,
                    focusNode: _numberFormatterFocusNode,
                    decoration: InputDecoration(
                      labelText: '사후 포메터 적용',
                      hintText: '포커스가 사라지면 -> #.###형태로 포메팅됨',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ],
              ),
            ),
            Divider(),

            // 11번째 영역
            // 검색 디바운스 - 입력이 끝난 0.3-0.5초 후에 api연결
            // 디바운스란? -> 입력이 멈출때까지 기다렸다면 마지막에 한번만 호출함
            // 이러면 onchange로 계속 연결하면 계속 api호출을 하게되어 불필요한 요청이 나감 -> 이게 해결됨
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _debounceController,
                    decoration: InputDecoration(
                      hintText: '디바운스 적용',
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.black,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    onChanged: (value) {
                      _onDebounce(value);
                    },
                  ),
                ],
              ),
            ),
            Divider(),

            // 12번째 영역
            // 입력창 자동완성 기능
            // 방법1. AutoComplete 위젯 - 플러터가 제공함
            // 방법2. OverlayEntry 위젯 - 수동으로 구현 - 좀 빡셈
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Autocomplete(
                    optionsBuilder: (textEditingValue) {
                      if (textEditingValue.text.isEmpty) {
                        // 빈 입력이라면
                        return const Iterable<String>.empty(); // 후보가 없음
                      }
                      return _allItems.where(
                        (item) => item.contains(textEditingValue.text),
                      );
                    },
                    onSelected: (option) {
                      print('선택됨: $option');
                    },
                    fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted,) {
                      return TextField(
                        controller: textEditingController,
                        focusNode: focusNode,
                        decoration: InputDecoration(
                          hintText: '검색어',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        onSubmitted: (_) => onFieldSubmitted(),
                      );
                    },
                  ),
                ],
              ),
            ),
            Divider(),

            // 13번재 영역
            // 태그 사용
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  KeyboardListener(
                    focusNode: FocusNode(),
                    onKeyEvent: (event) {
                      if (event is KeyDownEvent &&
                          event.logicalKey == LogicalKeyboardKey.backspace &&
                          _tagController.text.isEmpty &&
                          _tags.isNotEmpty) {
                        setState(() {
                          _tags.removeLast();
                        });
                      }
                    },
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        ..._tags.map(
                          (tag) => Chip(
                            label: Text(tag),
                            onDeleted: () => setState(() {
                              _tags.remove(tag);
                            }),
                          ),
                        ),
                        SizedBox(
                          width: 120,
                          child: TextField(
                            controller: _tagController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '태그 사용',
                            ),
                            onSubmitted: _addTag,
                            onChanged: (value) {
                              if (value.endsWith(',')) {
                                _addTag(value);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(),

            // 14번째 영역
            // buildSpan 사용하기
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _mentionTextController,
                    decoration: InputDecoration(
                      hintText: '@멘션을 해보세요',
                      labelText: '해시태그 text',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),

            Container(height: 800),
          ],
        ),
      ),
    );
  }
}
