import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobize_app/core/utils/app_colors.dart';

import '../../../sing_up/presentation/pages/sing_up_screen.dart';
import '../../domain/entities/user_enitites.dart';
import '../cubit/post_result_cubit.dart';
import '../../../get_ leaderboard/presentation/pages/result_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.name}) : super(key: key);
  final String? name;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userToken = '';
  List<Answers> userAnswers = [];
  bool isfinshe = false;
  int correctAnswers = 0;
  int wrongAnswers = 0;

  List<Question> questions = [
    Question('1 + 1 ما هو حل هذه المسألة ', ['5', '6', '2'], '2'),
    Question('2 + 2 ما هو حل هذه المسألة ', ['4', '6', '2'], '4'),
    Question('3 + 3 ما هو حل هذه المسألة  ', ['5', '9', '2'], '9'),
  ];

  void handleRadioValueChanged(Question question, String answer, bool isTrue) {
    setState(() {
      userAnswers.removeWhere((ans) => ans.question == question.text);
      userAnswers.add(Answers(question.text, answer, isTrue));
    });
  }

  List<Widget> buildRadioOptions(Question question) {
    return question.options.map(
      (option) {
        final bool isCorrect = option == question.correctAnswer;
        final bool isSelected = userAnswers.any((answer) =>
            answer.question == question.text && answer.answer == option);
        return RadioListTile(
          title: Text(
            option,
            style: TextStyle(
              color: isSelected && isfinshe
                  ? isCorrect
                      ? Colors.green
                      : Colors.red
                  : null,
            ),
          ),
          value: option,
          groupValue: userAnswers
              .firstWhere(
                (answer) => answer.question == question.text,
                orElse: () => Answers(question.text, '', isCorrect),
              )
              .answer,
          onChanged: (value) =>
              handleRadioValueChanged(question, value!, isCorrect),
          controlAffinity: ListTileControlAffinity.trailing,
          activeColor: Colors.blue,
        );
      },
    ).toList();
  }

  GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SingUpScreen(),
                  ),
                );
                await googleSignIn.signOut();
              },
              icon: const Icon(
                Icons.logout_outlined,
              ),
            )
          ],
          centerTitle: true,
          title: const Text('الرئيسية'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${widget.name} مرحبا بك  يا',
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                color: AppColors.textColor,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                ),
                for (var question in questions)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(question.text),
                      ...buildRadioOptions(question),
                    ],
                  ),
                ElevatedButton(
                  onPressed: () {
                    bool allQuestionsAnswered =
                        userAnswers.length == questions.length;
                    if (allQuestionsAnswered) {
                      for (var answer in userAnswers) {
                        var question = questions.firstWhere(
                          (q) => q.text == answer.question,
                          orElse: () => Question(
                            '',
                            [],
                            '',
                          ),
                        );

                        if (answer.answer == question.correctAnswer) {
                          correctAnswers++;
                        } else {
                          wrongAnswers++;
                        }
                      }

                      BlocProvider.of<PostResultCubit>(context).storeUserData(
                        context,
                        UserEntities(
                          uid: FirebaseAuth.instance.currentUser!.uid,
                          name: FirebaseAuth.instance.currentUser!.displayName,
                          answers: userAnswers,
                          score: correctAnswers * 10,
                        ),
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultScreen(
                            questions: questions,
                            userAnswers: userAnswers,
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: AppColors.aleart,
                          content: Text(
                            'أجب على كل الأسئلة',
                            textDirection: TextDirection.rtl,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  color: AppColors.whiteColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text('تأكيد الإجابة'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Question {
  final String text;
  final List<String> options;
  final String correctAnswer;
  Question(this.text, this.options, this.correctAnswer);
}
