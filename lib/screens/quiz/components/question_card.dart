import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../controllers/question_controller.dart';
import '../../../models/question.dart';
import 'option.dart';

class QuestionCard extends StatelessWidget {
  final Question question;

  const QuestionCard({
    super.key,
    // It means we have to pass this
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
  final QuestionController controller = Get.put(QuestionController());
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Text(
            question.question,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: kBlackColor),
          ),
          const SizedBox(
            height: kDefaultPadding / 2,
          ),
          ...List.generate(
              question.options.length,
              (index) => Option(
                    text: question.options[index],
                    index: index,
                    press: () => controller.checkAns(question, index),
                  ))
        ],
      ),
    );
  }
}
