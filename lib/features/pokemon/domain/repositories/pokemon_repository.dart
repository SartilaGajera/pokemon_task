import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/pokemon.dart';

abstract class PokemonRepository {
  Future<Either<Failure, List<Pokemon>>> getPokemons(int offset, int limit);
  Future<Either<Failure, Pokemon>> getPokemonDetails(int id);
}
