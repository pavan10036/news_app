import 'package:flutter/cupertino.dart';

class TextWidget extends StatelessWidget {
  TextWidget(this.title, this.fontSize, this.color, this.fontWeight);
  String? title;
  Color? color;
  FontWeight? fontWeight;
  double? fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? "",
      overflow: TextOverflow.visible,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ),
    );
  }
}
