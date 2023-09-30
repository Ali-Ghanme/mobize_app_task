
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../post_result/domain/entities/user_enitites.dart';

abstract class GetAllUserDataRemoteDataSource {
  Future<List<UserEntities>> getAllUsers();
}

class GetAllUserDataRemoteDataSourceImpl
    implements GetAllUserDataRemoteDataSource {
  @override
  Future<List<UserEntities>> getAllUsers() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    List<UserEntities> users = [];
    for (var doc in querySnapshot.docs) {
      users.add(
        UserEntities.fromDocument(doc.data() as Map<String, dynamic>),
      );
    }

    return users;
  }
}
