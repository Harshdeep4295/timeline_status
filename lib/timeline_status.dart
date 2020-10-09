library timeline_status;

import 'package:flutter/material.dart';
import 'package:timeline_status/app_assest.dart';

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
  List<String> statuses;
  int currentPosition;
  Color currentStepBackground,
      currentStepNumberTextColor,
      activatedStepBackground,
      activatedStepNumberTextColor,
      inActivatedStepBackground,
      inActivatedStepNumberTextColor,
      backgroundColor;
  double height = 70;
  EdgeInsets wholePadding;

  TimeLineStatus({
    @required this.statuses,
    @required this.currentPosition,
    this.currentStepBackground = AppColors.sunflowerYellow,
    this.currentStepNumberTextColor = AppColors.black,
    this.activatedStepBackground = AppColors.sunflowerYellow,
    this.activatedStepNumberTextColor = AppColors.white,
    this.inActivatedStepBackground = AppColors.redAccent,
    this.inActivatedStepNumberTextColor = AppColors.sunflowerYellow,
    this.height = 70,
    this.wholePadding = const EdgeInsets.only(
      top: 15,
      left: 10,
      right: 10,
    ),
    this.backgroundColor = AppColors.white,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: wholePadding,
      child: Row(
        children: _map(
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
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: currentPosition == position
                                    ? currentStepBackground
                                    : (currentPosition < position
                                        ? inActivatedStepBackground
                                        : activatedStepBackground),
                                borderRadius: BorderRadius.circular(30),
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
                                    fontSize: 18,
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
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

List<T> _map<T>({@required List list, @required Function handler}) {
  List<T> result = [];
  if (list != null) {
    if (list.length > 0) {
      if (handler != null) {
        for (var i = 0; i < list.length; i++) {
          result.add(handler(i, list[i]));
        }
      }
    }
  }
  return result;
}
