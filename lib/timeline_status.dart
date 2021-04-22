library timeline_status;

import 'package:flutter/material.dart';

const sunflowerYellow = const Color(0xfffad200);
const white = const Color(0x0ffffffff);
const warmGrey = const Color(0xFF777777);
const black = const Color(0xFF000000);
const whiteFive = Color(0xFFDDDDDD);
const redAccent = Color(0xFFFF5252);

/*
    The getTimeline widget will give widget in timeline format
    statuses - list of strings to be displayed below counter
    currentPoistion - to display the current position with different background 
    currentStepNumberTextColor - counter color for current postion
    currentStepBackground - current counter background color 
    activatedStepBackground - the background color of the step already passed
    activatedStepBackground - the counter text color of the step already passed
    inActivatedStepBackground - the background color of the step next of current
    inActivatedStepBackground - the counter text color of the step next of current
    height - display height of the widget by default 70 us given
    wholePadding - EdgeInsets variable to give padding
    backgroundColor - background color of whole widget
  */
class TimeLineStatus extends StatelessWidget {
  final List<String> statuses;
  final int currentPosition;
  final Color currentStepBackground,
      currentStepNumberTextColor,
      activatedStepBackground,
      activatedStepNumberTextColor,
      inActivatedStepBackground,
      inActivatedStepNumberTextColor,
      backgroundColor;
  final double height;
  final EdgeInsets wholePadding;
  final double textSize;
  final double pointCircleRadius;
  const TimeLineStatus({
    required this.statuses,
    required this.currentPosition,
    this.currentStepBackground = sunflowerYellow,
    this.currentStepNumberTextColor = black,
    this.activatedStepBackground = sunflowerYellow,
    this.activatedStepNumberTextColor = white,
    this.inActivatedStepBackground = redAccent,
    this.inActivatedStepNumberTextColor = sunflowerYellow,
    this.height = 70,
    this.wholePadding = const EdgeInsets.only(
      top: 15,
      left: 10,
      right: 10,
    ),
    this.backgroundColor = white,
    this.textSize = 18,
    this.pointCircleRadius = 25,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: wholePadding,
      child: Row(
        children: _map<Widget>(
          list: statuses,
          handler: (position, item) {
            return Expanded(
              child: Container(
                height: height,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runSpacing: 10,
                  direction: Axis.horizontal,
                  runAlignment: WrapAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Divider(
                          color:
                              currentPosition > 0 && currentPosition > position
                                  ? activatedStepBackground
                                  : inActivatedStepBackground,
                          thickness: 2,
                          indent: position == 0 ? 50 : 0,
                          endIndent: position == statuses.length - 1 ? 50 : 0,
                        ),
                        Visibility(
                          visible: position == currentPosition,
                          child: Divider(
                            color: activatedStepBackground,
                            thickness: 2,
                            indent: position == 0 ? 50 : 0,
                            endIndent: 50,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: pointCircleRadius + 5,
                              width: pointCircleRadius + 5,
                              decoration: BoxDecoration(
                                color: currentPosition == position
                                    ? currentStepBackground
                                    : (currentPosition < position
                                        ? inActivatedStepBackground
                                        : activatedStepBackground),
                                borderRadius:
                                    BorderRadius.circular(pointCircleRadius),
                              ),
                              child: Center(
                                child: Text(
                                  (position + 1).toString(),
                                  style: TextStyle(
                                    color: position == currentPosition
                                        ? currentStepNumberTextColor
                                        : (currentPosition < position
                                            ? inActivatedStepNumberTextColor
                                            : activatedStepNumberTextColor),
                                    fontWeight: FontWeight.w700,
                                    fontSize: textSize,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      statuses[position],
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: textSize),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            );
          },
        ) as List<Widget>,
      ),
    );
  }
}

List<T?> _map<T>({required List list, required Function handler}) {
  List<T?> result = [];
  if (list.length > 0) {
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
  }
  return result;
}

class HexColor {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
