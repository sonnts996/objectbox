import 'package:objectbox_test/src/domain/profille_entity.dart';

class TokenEntity {
  const TokenEntity({
    this.expiredDate,
    this.token = '',
    this.username,
    this.profile = const ProfileEntity(),
  });

  final String? username;
  final DateTime? expiredDate;
  final String token;

  final ProfileEntity profile;

  @override
  String toString() {
    return 'TokenEntity(username: $username, expiredDate: $expiredDate, token: $token, profile: $profile)';
  }
}
