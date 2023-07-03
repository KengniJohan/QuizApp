import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/models/question.dart';
import 'package:flutter_quiz_app/screens/score/score_screen.dart';
import 'package:get/get.dart';

// We use get package for our state management

class QuestionController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Let's animated ours progress bar

  AnimationController? _animationController;
  Animation? _animation;

  // So that we can access our animation outside
  Animation get animation => _animation!;

  PageController? _pageController;
  PageController get pageController => _pageController!;

  final List<Question> _questions = sampleData
      .map((question) => Question(
          id: question['id'],
          question: question['question'],
          options: question["options"],
          answer: question["answer_index"]))
      .toList();

  List<Question> get questions => _questions;

  bool _isAnswered = false;
  bool get isAnswered => _isAnswered;

  int? _correctAns;
  int get correctAns => _correctAns!;

  int? _selectedAns;
  int get selectedAns => _selectedAns!;

  final RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => _questionNumber;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => _numOfCorrectAns;

  @override
  void onInit() {
    // Our animation duration is 60 s
    // So our plan is to fill the progress bar
    _animationController =
        AnimationController(duration: const Duration(seconds: 60), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController!)
      ..addListener(() {
        // Update like setState
        update();
      });

    // Start our animation
    // Once 60s is completed, go to the next qn
    _animationController?.forward().whenComplete(nextQuestion);
    _pageController = PageController();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    _animationController!.dispose();
    _pageController!.dispose();
  }

  void checkAns(Question question, int selectedIndex) {
    // Because once user press any option then it will run
    _isAnswered = true;
    _correctAns = question.answer;
    _selectedAns = selectedIndex;

    if (_correctAns == _selectedAns) _numOfCorrectAns++;

    // It will stop the counter
    _animationController!.stop();
    update();

    // Once user select an ans after 3s, it will go to the next qn
    Future.delayed(const Duration(seconds: 3), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (_questionNumber.value != _questions.length) {
      _isAnswered = false;
      _pageController!.nextPage(
          duration: const Duration(milliseconds: 250), curve: Curves.ease);

      // Reset the counter
      _animationController!.reset();

      // Then start it again
      // Once timer is finished, go to the next qn
      _animationController!.forward().whenComplete(nextQuestion);
    } else {
      // Get package provide us single way to manipulate another page
      Get.to(const ScoreScreen());
    }
  }

  void updateTheQnNumber(int index) {
    _questionNumber.value = index + 1;
  }
}
