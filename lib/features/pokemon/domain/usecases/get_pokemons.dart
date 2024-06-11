import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/pokemon.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemons implements UseCase<List<Pokemon>, GetPokemonsParams> {
  final PokemonRepository repository;

  GetPokemons(this.repository);

  @override
  Future<Either<Failure, List<Pokemon>>> call(GetPokemonsParams params) async {
    return await repository.getPokemons(params.offset, params.limit);
  }
}

class GetPokemonsParams {
  final int offset;
  final int limit;

  GetPokemonsParams({required this.offset, required this.limit});
}
