import '../models/models.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/usecases.dart';
import '../firebase/firebase.dart';

class RemoteLoadUser implements LoadUser {
  FirebaseCloudFirestore firebaseCloudFirestore;
  FirebaseAuthentication firebaseAuthentication;

  RemoteLoadUser({
    required this.firebaseCloudFirestore,
    required this.firebaseAuthentication,
  });

  @override
  Future<UserEntity> loadUserByUID({required String uid}) async {
    final response = await firebaseCloudFirestore
        .getCollection(collectionName: 'users')
        .doc(uid)
        .get();

    return RemoteUserModel.fromMap(response.data() as Map<String, dynamic>)
        .toEntity();
  }
}