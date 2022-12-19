import 'package:objectbox/objectbox.dart';
import 'package:objectbox_test/src/data/local/model/profile_model.dart';
import 'package:objectbox_test/src/domain/token_entity.dart';

@Entity()
class TokenModel extends TokenEntity {
  TokenModel(
      {this.id = 0,
      required this.token,
      this.username,
      this.expiredDate,
      ProfileModel? profile}) {
    dbProfile.target = profile;
  }

  @Id()
  int id;

  @override
  final String? username;

  @override
  final String token;

  @Property(type: PropertyType.date)
  @override
  final DateTime? expiredDate;

  final dbProfile = ToOne<ProfileModel>();

  @override
  ProfileModel get profile => dbProfile.target ?? ProfileModel();

  // @override
  // String toString() {
  //   return 'TokenEntity(id: $id,username: $username, expiredDate: $expiredDate, token: $token, profile: ${dbProfile.target})';
  // }
}
