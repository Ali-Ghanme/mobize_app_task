// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobize_app/features/sing_up/presentation/cubit/sing_up_cubit.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'تسجيل الدخول بإستخدام قوقل',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: AppColors.black2,
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'يمكنك التسجيل من خلال حسابك في جيميل',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: AppColors.grayColor,
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: InkWell(
              onTap: () async {
                await BlocProvider.of<SingUpCubit>(context)
                    .authAndstore(context);
                Navigator.pushNamed(context, Routes.initialRoute);
              },
              child: Container(
                height: 70,
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.aleart,
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.email,
                        color: AppColors.whiteColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'تسجيل الدخول بإستخدام قوقل',
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  color: AppColors.whiteColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
