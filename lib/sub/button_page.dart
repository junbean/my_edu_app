import 'package:flutter/material.dart';

class ButtonPage extends StatefulWidget {
  const ButtonPage({super.key});

  @override
  State<ButtonPage> createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  bool isVisible = true;
  List<String> dropDownMenuList = ["A", "B", "C"];
  late String selectedDropDown;

  @override
  void initState() {
    super.initState();
    selectedDropDown = dropDownMenuList[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("버튼들"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        alignment: .center,
        child: Column(
          mainAxisAlignment: .spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: .spaceEvenly,
              children: [
                // SnackBar 호출
                TextButton(
                  style: TextButton.styleFrom(
                    shape: ContinuousRectangleBorder(),
                    backgroundColor: Colors.lightGreen,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("스낵바 메세지 호출"),
                        duration: const Duration(seconds: 2),
                        behavior: SnackBarBehavior.fixed,
                        //margin: const EdgeInsets.all(1),
                        // 스낵바 버튼 액션
                        action: SnackBarAction(
                          label: '액션',
                          onPressed: () {
                            print('action button 클릭');
                          },
                        ),
                      ),
                    );
                  },
                  child: Text(("토스트 메세지 호출")),
                ),

                // AlertDialog
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          // icon: Icon(Icons.thirty_fps_sharp),
                          title: Row(
                            mainAxisAlignment: .center,
                            children: [
                              Icon(Icons.alarm),
                              Text("알림")
                            ],
                          ),
                          content: Text("이것은 다이얼로그입니다"),
                          shape: ContinuousRectangleBorder(),
                          actions: [
                            TextButton(
                              style: TextButton.styleFrom(
                                shape: ContinuousRectangleBorder(),
                                backgroundColor: Colors.white70,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("확인", style: TextStyle(color: Colors.black)),
                            ),

                            TextButton(
                              style: TextButton.styleFrom(
                                shape: ContinuousRectangleBorder(),
                                backgroundColor: Colors.white70,
                              ),
                              onPressed: () {
                              },
                              child: Text("취소", style: TextStyle(color: Colors.black)),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: TextButton.styleFrom(
                    shape: ContinuousRectangleBorder(),
                    backgroundColor: Colors.lime,
                  ),
                  child: Text("다이얼로그 호출"),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: .spaceEvenly,
              children: [
                // isVisible 사용하기
                TextButton(
                  style: TextButton.styleFrom(
                    shape: ContinuousRectangleBorder(),
                    backgroundColor: Colors.amberAccent,
                  ),
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  child: Text(isVisible ? "사라지게 하기" : "보여주기"),
                ),


              ],
            ),

            Row(
              mainAxisAlignment: .spaceEvenly,
              children: [
                // 아이콘 버튼
                IconButton(
                  onPressed: () {},
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                  icon: Icon(Icons.shield_moon_sharp, color: Colors.white,),
                ),

                // 드롭다운 버튼

                DropdownButton(
                  value: selectedDropDown,
                  underline: Container(),
                  items: dropDownMenuList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedDropDown = newValue;
                      });
                    }
                  },
                )

              ],
            ),
          ],
        ),
      ),
    );
  }
}
