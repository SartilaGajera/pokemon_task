import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_task/features/pokemon/presentation/pages/pokemon_list_page.dart';
import '../bloc/pokemon_bloc.dart';
import '../../domain/entities/pokemon.dart';

class PokemonDetailsPage extends StatelessWidget {
  final int pokemonId;

  const PokemonDetailsPage({super.key, required this.pokemonId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon Details'),
      ),
      body: BlocProvider(
        create: (context) => PokemonBloc(
          getPokemons: BlocProvider.of<PokemonBloc>(context).getPokemons,
          getPokemonDetails:
              BlocProvider.of<PokemonBloc>(context).getPokemonDetails,
        )..add(FetchPokemonDetails(pokemonId)),
        child: BlocBuilder<PokemonBloc, PokemonState>(
          builder: (context, state) {
            if (state is PokemonLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PokemonDetailsLoaded) {
              final Pokemon pokemon = state.pokemon;
              return Column(
                children: [
                  Text(
                    pokemon.name.capitalize(),
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Hero(
                          tag: pokemon.imageUrl,
                          child: Container(
                            height: 180.0,
                            width: 180.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFFA890F0).withOpacity(0.5),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(pokemon.imageUrl))),
                          )),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: const Color(0xFFA890F0).withOpacity(0.3),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40))),
                        child: DefaultTabController(
                          length: 2,
                          initialIndex: 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 50,
                                child: TabBar(
                                    unselectedLabelColor:
                                        Colors.black.withOpacity(0.6),
                                    labelColor: Colors.black,
                                    indicatorColor: Colors.black,
                                    labelStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    onTap: (value) {},
                                    tabs: [
                                      const Tab(
                                        child: Text(
                                          "About",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                      GestureDetector(
                                        onLongPress: () async {},
                                        child: Tab(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Other".toUpperCase(),
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                              Expanded(
                                child: TabBarView(children: [
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 30),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Height:${pokemon.height} ",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Weight:${pokemon.weight}",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                         vertical: 30),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Types",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: pokemon.types
                                              .map((t) => ElevatedButton(
                                                  onPressed: () {},
                                                  child: Text(t)))
                                              .toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ))
                ],
              );
              /*  Stack(
                children: <Widget>[
                  Positioned(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    top: MediaQuery.of(context).size.height / 3,
                    child: Container(
                      decoration: BoxDecoration(
                        color:const Color(0xFFA8A878),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.9),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          const SizedBox(
                            height: 70.0,
                          ),
                          Text(
                            pokemon.name.capitalize(),
                            style: const TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold),
                          ),
                          Text("Height:${pokemon.height} "),
                          Text("Weight:${pokemon.weight}"),
                          const SizedBox(
                            height: 40,
                          ),
                          const Text(
                            "Types",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: pokemon.types
                                .map((t) => FilterChip(
                                    backgroundColor:
                                        Colors.green.withOpacity(0.5),
                                    label: Text(t.capitalize()),
                                    onSelected: (b) {}))
                                .toList(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Hero(
                        tag: pokemon.imageUrl,
                        child: Container(
                          height: 180.0,
                          width: 180.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(pokemon.imageUrl))),
                        )),
                  )
                ],
              ); */
            } else if (state is PokemonError) {
              return Center(child: Text(state.message));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
