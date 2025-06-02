import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/populkar_model.dart';
import 'package:flutter_application_1/network/api_movie.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  ApiPopular? apiPopular;

  @override
  void initState() {
    super.initState();
    apiPopular = ApiPopular();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Películas Populares'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Botón de acceso rápido a favoritos
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/favorites');
              },
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Ver mis favoritos',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Lista de películas
          Expanded(
            child: FutureBuilder(
              future: apiPopular!.getPopularMovies(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ItemPopoular(snapshot.data![index]);
                    },
                  );
                } else {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget para cada ítem de película popular
  Widget ItemPopoular(PopularModel popular) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          FadeInImage(
            placeholder: AssetImage('assets/gifUno.gif'),
            image: NetworkImage(popular.backdropPath),
          ),
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            color: Colors.black.withOpacity(0.7),
            child: ListTile(
              onTap: () => Navigator.pushNamed(
                context,
                '/detail',
                arguments: popular,
              ),
              title: Text(
                popular.title,
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(Icons.chevron_right, size: 50, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}