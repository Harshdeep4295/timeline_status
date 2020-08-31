library timeline_status;

import 'package:flutter/material.dart';
import 'package:timeline_status/app_assest.dart';

class StatusTime {
  static Widget getTimeline({
    @required List<String> statuses,
    @required int currentPosition,
    Color currentColorIndicator = AppColors.redAccent,
    Color disabledIndicator = AppColors.whiteFive,
    Color activatedIndicator = AppColors.sunflowerYellow,
    Color currentText = AppColors.white,
    Color otherText = AppColors.black,
    double height = 70,
    EdgeInsets wholePadding =
        const EdgeInsets.only(top: 15, left: 10, right: 10),
    Color backgroundColor = AppColors.white,
  }) {
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
                                  ? activatedIndicator
                                  : disabledIndicator,
                          thickness: 2,
                          indent: position == 0 ? 60 : 0,
                          endIndent: position == statuses.length - 1 ? 60 : 0,
                        ),
                        Visibility(
                          visible: position == currentPosition,
                          child: Divider(
                            color: activatedIndicator,
                            thickness: 2,
                            indent: position == 0 ? 50 : 0,
                            endIndent: 50,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: currentPosition == position
                                    ? currentColorIndicator
                                    : (currentPosition < position
                                        ? disabledIndicator
                                        : activatedIndicator),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text((position + 1).toString(),
                                    style: TextStyle(
                                      color: position == currentPosition
                                          ? AppColors.white
                                          : AppColors.black,
                                      fontWeight: FontWeight.w700,
                                    )),
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

  static List<T> _map<T>({@required List list, @required Function handler}) {
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
}
