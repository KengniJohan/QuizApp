import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/controllers/question_controller.dart';
import 'package:flutter_quiz_app/screens/quiz/components/body.dart';
import 'package:get/get.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionController controller = Get.put(QuestionController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // Flutter show the back button automatically
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: controller.nextQuestion,
            child: const Text("Skip", style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
      body: const Body(),
    );
  }
}
