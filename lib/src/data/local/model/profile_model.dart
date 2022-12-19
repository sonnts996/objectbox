import 'package:objectbox/objectbox.dart';

import '../../../domain/profille_entity.dart';

@Entity()
class ProfileModel extends ProfileEntity {
   ProfileModel({
    this.id = 0,
    this.name = '',
    this.weight = 0,
    this.height = 0,
  });

  @Id()
  int id;

  @override
  final String name;

  @override
  final int weight;

  @override
  final int height;
}
