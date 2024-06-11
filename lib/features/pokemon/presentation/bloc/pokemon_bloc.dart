import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/usecases/get_pokemons.dart' as getPokemonsUsecase;
import '../../domain/usecases/get_pokemon_details.dart' as getPokemonDetailsUsecase;
import '../../../../core/error/failures.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final getPokemonsUsecase.GetPokemons getPokemons;
  final getPokemonDetailsUsecase.GetPokemonDetails getPokemonDetails;

  PokemonBloc({
    required this.getPokemons,
    required this.getPokemonDetails,
  }) : super(PokemonInitial()) {
    on<FetchPokemons>(_onFetchPokemons);
    on<FetchPokemonDetails>(_onFetchPokemonDetails);
  }

  void _onFetchPokemons(FetchPokemons event, Emitter<PokemonState> emit) async {
    emit(PokemonLoading());

    final failureOrPokemons = await getPokemons(getPokemonsUsecase.GetPokemonsParams(offset: event.offset, limit: event.limit));

    emit(failureOrPokemons.fold(
      (failure) => PokemonError(_mapFailureToMessage(failure)),
      (pokemons) => PokemonLoaded(pokemons: event.currentPokemons + pokemons),
    ));
  }

  void _onFetchPokemonDetails(FetchPokemonDetails event, Emitter<PokemonState> emit) async {
    emit(PokemonLoading());

    final failureOrPokemon = await getPokemonDetails(getPokemonDetailsUsecase.GetPokemonDetailsParams(id: event.id));

    emit(failureOrPokemon.fold(
      (failure) => PokemonError(_mapFailureToMessage(failure)),
      (pokemon) => PokemonDetailsLoaded(pokemon),
    ));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return 'Server Failure';
      default:
        return 'Unexpected Error';
    }
  }
}
