import 'package:objectbox_test/main.dart';
import 'package:objectbox_test/src/data/local/model/profile_model.dart';
import 'package:objectbox_test/src/data/local/model/token_model.dart';

import '../../../objectbox.g.dart';

class TokenDataSource {
  TokenDataSource()
      : box = objectbox.store.box<TokenModel>(),
        profileBox = objectbox.store.box<ProfileModel>();

  final Box<TokenModel> box;
  final Box<ProfileModel> profileBox;

  void add(TokenModel data) {
    box.put(data);
  }

  List<TokenModel> load() {
    return box.getAll();
  }

  List<TokenModel> where(String name) {
    final query = box.query(TokenModel_.username.equals(name)).build();

    return query.find();
  }

  List<TokenModel> whereProfile(String name) {
    final profileQuery =
        profileBox.query(ProfileModel_.name.equals(name)).build();
    final profile = profileQuery.findFirst();
    if (profile == null) {
      return [];
    }
    final query = box.query(TokenModel_.dbProfile.equals(profile.id)).build();

    return query.find();
  }

  void remove(TokenModel data) {
    box.remove(data.id);
  }
}
