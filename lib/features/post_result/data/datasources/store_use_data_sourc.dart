import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user_enitites.dart';

abstract class StorUserDataRemoteDataSource {
  Future storeUserEntities(UserEntities userModel);
}

class StorUserDataRemoteDataSourceImpl implements StorUserDataRemoteDataSource {
  @override
  Future<void> storeUserEntities(UserEntities userModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.uid)
          .set({
        'name': userModel.name,
        'score': userModel.score,
        'uid': userModel.uid,
        'answers': userModel.answers?.map((answer) {
          return {
            'question': answer.question,
            'answer': answer.answer,
            'isTrue':answer.isTrue,
          };
        }).toList(),
      });
    } catch (e) {
      log('Error storing user entities: $e');
    }
  }
}
