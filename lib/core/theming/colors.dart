import 'package:flutter/material.dart';

class AppColor {
  static const Color appColor = Color(0xfff99441);
  static const Color appgreen = Color(0xff5E9E86);
  static const Color white = Color(0xffffffff);
  static const Color black = Color(0xff000000);
  static const Color oranegapp = Color(0xfff99441);

  static const Color grayColor = Color(0xff717B8C);
  static const Color fillTextFormGray = Color(0xffF5F5F6);
  static const Color appBlueColor = Color(0xff54ADD2);
  static const Color buttongreen = Color(0xff71bf9d);
  static const Color appbargreen = Color(0xff5e9e86);
  static const Color buttons = Color(0xff356e59);
  static const Color backgroundbutton = Color(0xffd9d9d9);
  static const Color citycolor = Color(0xffc4f300);
  static const Color black55 = Color(0x80000000);

  static Color whiteA700E5 = fromHex('#e5ffffff');

  static Color bluegray50 = fromHex('#f2f0f2');

  static Color gray900 = fromHex('#210d33');

  static Color bluegray100 = fromHex('#ccc7d1');

  static Color red300 = fromHex('#fa6969');

  static Color gray200 = fromHex('#ebe8ed');

  static Color whiteA700Cc = fromHex('#ccffffff');

  static Color whiteA70000 = fromHex('#00ffffff');

  static Color whiteA70099 = fromHex('#99ffffff');

  static Color black90000 = fromHex('#00000000');

  static Color black900 = fromHex('#000000');

  static Color bluegray400 = fromHex('#8c8096');

  static Color whiteA700Bf = fromHex('#bfffffff');

  static Color gray9001a = fromHex('#1a2e0047');

  static Color indigoA400 = fromHex('#3b63fa');

  static Color deepPurpleA200 = fromHex('#8766f2');

  static Color whiteA700 = fromHex('#ffffff');

  static Color deepPurpleA20066 = Color(0xf2668766);

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
