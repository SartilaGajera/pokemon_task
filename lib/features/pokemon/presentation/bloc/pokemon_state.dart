part of 'pokemon_bloc.dart';

abstract class PokemonState extends Equatable {
  @override
  List<Object> get props => [];
}

class PokemonInitial extends PokemonState {}

class PokemonLoading extends PokemonState {}

class PokemonLoaded extends PokemonState {
  final List<Pokemon> pokemons;

  PokemonLoaded({required this.pokemons});

  @override
  List<Object> get props => [pokemons];
}

class PokemonDetailsLoaded extends PokemonState {
  final Pokemon pokemon;

  PokemonDetailsLoaded(this.pokemon);

  @override
  List<Object> get props => [pokemon];
}

class PokemonError extends PokemonState {
  final String message;

  PokemonError(this.message);

  @override
  List<Object> get props => [message];
}
