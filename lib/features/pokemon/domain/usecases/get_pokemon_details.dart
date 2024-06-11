import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/pokemon.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemonDetails implements UseCase<Pokemon, GetPokemonDetailsParams> {
  final PokemonRepository repository;

  GetPokemonDetails(this.repository);

  @override
  Future<Either<Failure, Pokemon>> call(GetPokemonDetailsParams params) async {
    return await repository.getPokemonDetails(params.id);
  }
}

class GetPokemonDetailsParams {
  final int id;

  GetPokemonDetailsParams({required this.id});
}
