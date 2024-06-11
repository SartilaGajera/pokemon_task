import '../../domain/entities/pokemon.dart';

class PokemonModel extends Pokemon {
  const PokemonModel({required super.id, required super.name, required super.imageUrl, required super.height, required super.weight,required super.types});

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['sprites']['front_default'],
      height: json['height'],
      weight: json['weight'],
        types: (json['types'] as List)
          .map((typeInfo) => typeInfo['type']['name'] as String)
          .toList(),
    );
  }
}
