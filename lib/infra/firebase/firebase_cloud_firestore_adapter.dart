import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/firebase/firebase.dart';

class FirebaseCloudFirestoreAdapter implements FirebaseCloudFirestore {
  FirebaseFirestore firebaseFirestore;
  FirebaseCloudFirestoreAdapter({
    required this.firebaseFirestore,
  });

  @override
  Future<void> setDataDocument({required String doc, required Object data}) async {
    try {
      await getCollection(collectionName: "users").doc(doc).set(data);
    } catch (_) {
      throw FirebaseCloudFirestoreError.internalError;
    }
  }

  @override
  CollectionReference getCollection({required String collectionName}) {
    try {
      return firebaseFirestore.collection(collectionName);
    } catch (_) {
      throw FirebaseCloudFirestoreError.internalError;
    }
  }

  @override
  Stream<QuerySnapshot<Object?>> getStreamCollection({required String collectionName}) {
    throw UnimplementedError();
  }

  @override
  Future<CollectionReference> getCollectionReference({required String collectionPath}) async {
    CollectionReference reference = firebaseFirestore.collection(collectionPath);
    return reference;
  }

  @override
  DocumentReference<Map<String, dynamic>> getPublishesByUserID({required String userId, required String publishId}) {
    return firebaseFirestore.collection('publishes').doc(userId).collection('publishes').doc(publishId);
  }
}
