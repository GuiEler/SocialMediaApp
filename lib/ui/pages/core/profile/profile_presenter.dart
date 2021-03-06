import 'dart:io';

import '../../../../domain/entities/entities.dart';
import '../../../helpers/helpers.dart';

abstract class ProfilePresenter   {
  Stream<int> get postsCount;
  Stream<File?> get userImage;
  Stream<UIError> get userImageError;
  Stream<String> get errorStream;
  Stream<UserEntity> get user;

  void setImage();

  void updateUserId();
}
