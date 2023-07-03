import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/constants.dart';
import 'package:flutter_quiz_app/controllers/question_controller.dart';
import 'package:flutter_quiz_app/screens/welcome/welcome_screen.dart';
import 'package:get/get.dart';
import 'package:websafe_svg/websafe_svg.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionController qnController = Get.put(QuestionController());
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: WebsafeSvg.asset(
              kBgIcon,
              fit: BoxFit.fill,
            ),
          ),
          Column(
            children: [
              const Spacer(),
              Text(
                "Score",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: kSecondaryColor),
              ),
              const Spacer(),
              Text(
                "${qnController.numOfCorrectAns * 10}/${qnController.questions.length * 10}",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: kSecondaryColor),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => Get.to(const WelcomeScreen()),
                icon: const Icon(
                  Icons.refresh,
                  color: kSecondaryColor,
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>((states) => kSecondaryColor)
                ),
              ),
              const Spacer(
                flex: 3,
              )
            ],
          ),
        ],
      ),
    );
  }
}
