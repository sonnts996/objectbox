class ProfileEntity {
  const ProfileEntity({
    this.height = 0,
    this.name = '',
    this.weight = 0,
  });

  final String name;
  final int height;
  final int weight;

  @override
  String toString() {
    return 'ProfileEntity(name: $name, height: $height, weight: $weight)';
  }
}
