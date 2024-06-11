import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_task/features/pokemon/data/repositories/pokemon_repository_impl.dart';
import 'package:pokemon_task/features/pokemon/domain/usecases/get_pokemon_details.dart';
import 'package:pokemon_task/features/pokemon/domain/usecases/get_pokemons.dart';
import 'package:pokemon_task/features/pokemon/presentation/bloc/pokemon_bloc.dart';
import 'package:pokemon_task/features/pokemon/presentation/pages/pokemon_list_page.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
        final PokemonRepositoryImpl repository = PokemonRepositoryImpl(client: http.Client());

    return MultiBlocProvider(
       providers: [
        BlocProvider<PokemonBloc>(
          create: (context) => PokemonBloc(
            getPokemons: GetPokemons(repository),
            getPokemonDetails: GetPokemonDetails(repository),
          )..add(FetchPokemons(offset: 0, limit: 10, currentPokemons: const [])),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const PokemonListPage(),
      ),
    );
  }
}
