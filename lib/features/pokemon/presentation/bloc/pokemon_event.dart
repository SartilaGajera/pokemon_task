part of 'pokemon_bloc.dart';

abstract class PokemonEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchPokemons extends PokemonEvent {
  final int offset;
  final int limit;
  final List<Pokemon> currentPokemons;

  FetchPokemons({required this.offset, required this.limit, required this.currentPokemons});

  @override
  List<Object> get props => [offset, limit, currentPokemons];
}

class FetchPokemonDetails extends PokemonEvent {
  final int id;

  FetchPokemonDetails(this.id);

  @override
  List<Object> get props => [id];
}
