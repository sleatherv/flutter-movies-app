import 'package:flutter/material.dart';
import 'package:peliculas_app/models/models.dart';

class MovieSlider extends StatefulWidget {

  final List<Movie> popularMovies;
  final String? title;
  final Function onNextPage;

  const MovieSlider({Key? key, required this.popularMovies, this.title, required this.onNextPage}) : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  
  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if(scrollController.position.pixels>= scrollController.position.maxScrollExtent - 500){
        widget.onNextPage();
      }
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    if(widget.popularMovies.isEmpty ){
    return const SizedBox(
        width: double.infinity,
        height: 190,
        child: Center(child: CircularProgressIndicator()),
      );
  }
    return SizedBox(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(widget.title != null) Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(widget.title!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.popularMovies.length,
              itemBuilder: (_, int index){
                final movie = widget.popularMovies[index];
                return _MoviePoster(movie: movie);
              } 
            ),
          )
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;
  const _MoviePoster({ Key? key, required this.movie }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
                  width: 130,
                  height: 190,
                  
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, 'details', arguments: 'movie-details'),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FadeInImage(
                            placeholder: const AssetImage('assets/img/no-image.jpg'),
                            image: NetworkImage(movie.fullPosterImg),
                            fit: BoxFit.fill,
                            height: 170,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Startwars: El retorno el jedi y sus amigos extraterrestes',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                );
  }
}