import 'package:mobize_app/features/post_result/domain/entities/user_enitites.dart';

class UserModel extends UserEntities {
  const UserModel({required super.uid, super.name, super.score});

  factory UserModel.fromDocument(Map<String, dynamic> data) {
    return UserModel(
      name: data['name'],
      score: data['score'],
      uid: data['uid'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'score': score,
      'uid': uid,
    };
  }
}
