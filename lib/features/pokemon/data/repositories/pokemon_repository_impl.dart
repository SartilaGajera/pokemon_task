import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../models/pokemon_model.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final http.Client client;

  PokemonRepositoryImpl({required this.client});

  @override
  Future<Either<Failure, List<Pokemon>>> getPokemons(
      int offset, int limit) async {
    try {
      final response = await client.get(Uri.parse(
          'https://pokeapi.co/api/v2/pokemon?offset=$offset&limit=$limit'));
      if (response.statusCode == 200) {
        final List<dynamic> results = json.decode(response.body)['results'];
        final pokemons = results.map((json) {
          final Map<String, dynamic> pokemonData = json as Map<String, dynamic>;
          final int id = int.parse(pokemonData['url'].split('/')[6]);
          return PokemonModel(
              id: id,
              name: pokemonData['name'],
              imageUrl:
                  'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png',
              height: 10,
              weight: 20,
              types: const []);
        }).toList();
        return Right(pokemons);
      } else {
        return Left(ServerFailure());
      }
    } catch (_) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Pokemon>> getPokemonDetails(int id) async {
    try {
      final response =
          await client.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'));
      if (response.statusCode == 200) {
        final pokemon = PokemonModel.fromJson(json.decode(response.body));
        return Right(pokemon);
      } else {
        return Left(ServerFailure());
      }
    } catch (_) {
      return Left(ServerFailure());
    }
  }
}
