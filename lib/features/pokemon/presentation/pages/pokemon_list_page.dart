import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_task/features/pokemon/domain/entities/pokemon.dart';
import '../bloc/pokemon_bloc.dart';
import 'pokemon_details_page.dart';

class PokemonListPage extends StatelessWidget {
  const PokemonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon List'),
      ),
      body: const PokemonListView(),
    );
  }
}

class PokemonListView extends StatefulWidget {
  const PokemonListView({super.key});

  @override
  State<PokemonListView> createState() => _PokemonListViewState();
}

class _PokemonListViewState extends State<PokemonListView> {
  final ScrollController _scrollController = ScrollController();
  int _offset = 0;
  final int _limit = 10;
  List<Pokemon> _currentPokemons = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      BlocProvider.of<PokemonBloc>(context).add(
        FetchPokemons(
          offset: _offset,
          limit: _limit,
          currentPokemons: _currentPokemons,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        if (state is PokemonLoading && _currentPokemons.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PokemonLoaded) {
          _currentPokemons = state.pokemons;
          _offset += _limit;
        } else if (state is PokemonError) {
          return Center(child: Text(state.message));
        }

        return GridView.builder(
          controller: _scrollController,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 2,
          ),
          itemCount: _currentPokemons.length,
          itemBuilder: (context, index) {
            final pokemon = _currentPokemons[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PokemonDetailsPage(pokemonId: pokemon.id),
                  ),
                );
              },
              child: Card(
                color: const Color(0xFFA890F0).withOpacity(0.5),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                            shape: BoxShape.circle,
                            
                            image: DecorationImage(
                                image: NetworkImage(pokemon.imageUrl))),
                      )),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        pokemon.name.capitalize(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
