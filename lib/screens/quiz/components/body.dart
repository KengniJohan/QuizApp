import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/controllers/question_controller.dart';
import 'package:flutter_quiz_app/screens/quiz/components/progress_bar.dart';
import 'package:flutter_quiz_app/screens/quiz/components/question_card.dart';
import 'package:get/get.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../../constants.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    // So we have access to our controller
    QuestionController questionController = Get.put(QuestionController());
    return Stack(
      children: [
        Center(
          child: WebsafeSvg.asset(
            kBgIcon,
            fit: BoxFit.fill,
          ),
        ),
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: ProgressBar(),
              ),
              const SizedBox(
                height: kDefaultPadding,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Obx(
                  () => Text.rich(
                    TextSpan(
                      text:
                          "Question ${questionController.questionNumber.value}",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: kSecondaryColor),
                      children: [
                        TextSpan(
                          text: "/${questionController.questions.length}",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: kSecondaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(
                thickness: 1.5,
              ),
              const SizedBox(
                height: kDefaultPadding,
              ),
              Expanded(
                child: PageView.builder(
                  // Block swipe to next qn
                  physics: const NeverScrollableScrollPhysics(),
                  controller: questionController.pageController,
                  onPageChanged: questionController.updateTheQnNumber,
                  itemCount: questionController.questions.length,
                  itemBuilder: (context, index) => QuestionCard(
                    question: questionController.questions[index],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
