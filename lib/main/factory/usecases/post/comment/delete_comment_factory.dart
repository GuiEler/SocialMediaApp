import '../../../../../data/usecases/usecases.dart';
import '../../../../../domain/usecases/usecases.dart';
import '../../../firebase/firebase.dart';

DeleteComment makeDeleteComment() => RemoteDeleteComment(
      firebaseCloudFirestore: makeFirebaseCloudFirestore(),
    );
