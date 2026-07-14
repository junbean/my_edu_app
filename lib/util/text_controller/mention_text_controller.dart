import 'package:flutter/material.dart';

class MentionTextController extends TextEditingController {
  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    // 1. 정규식 정의: '@'로 시작하고 뒤에 영문/숫자/한글이 붙는 패턴
    final RegExp mentionRegex = RegExp(r'@[a-zA-Z0-9ㄱ-ㅎㅏ-ㅣ가-힣]+');

    // 분리된 텍스트 조각들을 담을 리스트
    final List<InlineSpan> children = [];

    // 2. 전체 텍스트를 정규식 기준으로 검사하며 쪼갭니다.
    text.splitMapJoin(
      mentionRegex,
      // 정규식 패턴과 일치하는 단어를 찾았을 때 실행 (@홍길동 등)
      onMatch: (Match match) {
        children.add(
          TextSpan(
            text: match[0],
            // 기본 스타일에 파란색과 굵은 서체를 덮어씌움
            style: style?.copyWith(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
        return '';
      },
      // 패턴과 일치하지 않는 일반 글자일 때 실행
      onNonMatch: (String nonMatchText) {
        children.add(
          TextSpan(text: nonMatchText, style: style), // 기본 스타일 유지
        );
        return '';
      },
    );

    // 3. 최종적으로 스타일이 쪼개진 자식들을 품은 부모 TextSpan을 리턴
    return TextSpan(style: style, children: children);
  }
}