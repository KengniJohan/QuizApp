import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/controllers/question_controller.dart';
import 'package:get/get.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../../constants.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
          border:
              Border.all(color: const Color(0XFF3F4768), width: 3),
          borderRadius: BorderRadius.circular(50)),
      child: GetBuilder<QuestionController>(
        init: QuestionController(),
        builder: (controller) {
          return Stack(
            children: [
              // LayoutBuilder provides us the available space for the container
              // constraints.mainWith needed for our animation
              LayoutBuilder(
                builder: (context, constraints) => Container(
                  // From 0 to 1 it takes 60s
                  width: constraints.maxWidth * controller.animation.value, // cover 50%
                  decoration: BoxDecoration(
                      gradient: kPrimaryGradient,
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding / 2,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${(controller.animation.value * 60).round()} sec"),
                      WebsafeSvg.asset(kClockIcon)
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
