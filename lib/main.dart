import 'package:flutter/material.dart';

import 'QuizBrain.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuizBrain quizBrain = QuizBrain();

  void checkAnswer(bool isTrueButton) {
    void displayTick(IconData myIcon, Color buttonColor) {
      setState(() {
        scoreKeeper.add(
          Icon(
            myIcon,
            color: buttonColor,
          ),
        );
        quizBrain.nextQuestion();
      });
    }

    //The user picked true or false.
    /*
    * This tries to check for logical equivalence
    * If the answer picked by the user is equal to the correct answer for that question then display good tick else ...
    *
    * First check what button is calling (true button or false button)
    * If it is the true button then the result can only be correct if th user picked true
    * */
    bool correctAnswer = quizBrain.getQuestionAnswer();
    if (isTrueButton) {
      if (isTrueButton == correctAnswer) {
        print('user got it right!');
        displayTick(Icons.check, Colors.green);
      } else {
        print('user got it wrong');
        displayTick(Icons.close, Colors.red);
      }
    } else {
      if (isTrueButton == correctAnswer) {
        print('user got it right!');
        displayTick(Icons.check, Colors.green);
      } else {
        print('user got it wrong');
        displayTick(Icons.close, Colors.red);
      }
    }
  }

  Expanded answerButton(
      {String text, Color buttonColor, bool isTrueButton, IconData myIcon}) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: FlatButton(
          textColor: Colors.white,
          color: buttonColor,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          onPressed: () {
            checkAnswer(isTrueButton);
          },
        ),
      ),
    );
  }

  List<Icon> scoreKeeper = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestion(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        answerButton(
            text: 'True',
            buttonColor: Colors.green,
            isTrueButton: true,
            myIcon: Icons.check),
        answerButton(
            text: 'False',
            buttonColor: Colors.red,
            isTrueButton: false,
            myIcon: Icons.close),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
