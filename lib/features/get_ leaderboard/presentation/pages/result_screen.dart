import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobize_app/core/utils/app_colors.dart';
import 'package:mobize_app/features/post_result/presentation/pages/home_screen.dart';

import '../../../post_result/domain/entities/user_enitites.dart';
import '../cubit/get_leaderboard_cubit.dart';

class ResultScreen extends StatefulWidget {
  final List<Question>? questions;
  final List<Answers>? userAnswers;

  const ResultScreen({
    super.key,
    this.questions,
    this.userAnswers,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late GetLeaderboardCubit getLeaderboardCubit;

  @override
  void initState() {
    getLeaderboardCubit = BlocProvider.of<GetLeaderboardCubit>(context);
    getLeaderboardCubit.getAllUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int correctAnswers = 0;
    int wrongAnswers = 0;

    Widget loadMyLostData(BuildContext context2) {
      return BlocBuilder<GetLeaderboardCubit, GetLeaderboardState>(
        builder: (context, state) {
          if (state is GetLeaderboardLoading) {
            return const Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is GetLeaderboardError) {
            return CircularProgressIndicator(
              color: AppColors.aleart,
            );
          } else if (state is GetLeaderboardLoaded) {
            return Expanded(
              child: ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context2, index) {
                  state.users
                      .sort((a, b) => b.score!.compareTo(a.score as num));

                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CircleAvatar(),
                        Text('${state.users[index].score}'),
                        Text(state.users[index].name ?? ''),
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
            return CircularProgressIndicator(
              color: AppColors.aleart,
            );
          }
        },
      );
    }

    for (var answer in widget.userAnswers!) {
      var question = widget.questions?.firstWhere(
          (q) => q.text == answer.question,
          orElse: () => Question('', [], ''));
      if (answer.answer == question?.correctAnswer) {
        correctAnswers++;
      } else {
        wrongAnswers++;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('النتيجة'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(' الأجابات الصحيحة: $correctAnswers'),
              Text('الإجابات الخاطئة : $wrongAnswers'),
              Text('المعدل: ${correctAnswers * 10}'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'المتصدرين',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: AppColors.textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ),
              loadMyLostData(context),
            ],
          ),
        ),
      ),
    );
  }
}
