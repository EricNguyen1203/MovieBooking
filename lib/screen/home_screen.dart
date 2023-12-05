import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinema_booking_v2/common_widget/common_widget.dart';
import 'package:cinema_booking_v2/entity/movie.dart';
import 'package:cinema_booking_v2/screen/all_movie.dart';
import 'package:cinema_booking_v2/screen/movie_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: const MyAppBar(title: 'Now Showing ..'),
      body: Column(children: [
        Container(
          margin: const EdgeInsets.all(30.0),
          width: 400.0,
          height: 400.0,
          child: ImageSlider(),
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          child: Row(children: [
            const Expanded(
                child: Text(
              'All Movies',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            )),
            InkWell(
              onTap: () => {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AllMovieScreen()),
                )
              },
              child: Container(
                child: const Text(
                  'View all',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ]),
        ),
        PosterListView(),
      ]),
    );
  }
}


// Cần cải tiến cái này
class ImageSlider extends StatelessWidget {
  final List<String> imageUrls = [
    'https://firebasestorage.googleapis.com/v0/b/cinemabookingv4.appspot.com/o/ixLH2iM9at8BbuLr5wQWnCfwhJO.jpg?alt=media&token=62bdb25c-ee09-4b37-8b85-ae3bb058ce26',
    'https://firebasestorage.googleapis.com/v0/b/cinemabookingv4.appspot.com/o/images2.jpg?alt=media&token=484d1675-b688-4649-84ae-06d6b84da243',
    'https://firebasestorage.googleapis.com/v0/b/cinemabookingv4.appspot.com/o/8n8bF1hPICIYC4byBj0pqNn9vXs.jpg?alt=media&token=44a66854-e830-41b1-ae9a-983bff1fd481'
    // Add more image URLs as needed
  ];


  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 400.0,
        aspectRatio: 16/9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items: imageUrls.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
            
              child: Image.network(
                url,
                fit: BoxFit.cover,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}


class PosterListView extends StatelessWidget {
  Future<List<Movie>> fetchData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('poster_items').get();

    List<Movie> movies = querySnapshot.docs.map((doc) {
      var data = doc.data() as Map<String, dynamic>;
      return Movie.fromMap(data);
    }).toList();

    return movies;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0,
      child: FutureBuilder(
        future: fetchData(),
        builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          List<Movie> movies = snapshot.data!;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              Movie movie = movies[index];
              return ListItem(
                movie: movie,
              );
            },
          );
        },
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final Movie movie;

  ListItem({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 150.0,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MoviePageScreen(movie: movie),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                      Radius.circular(8.0)), // Adjust the corner radius
                  child: Image.network(
                    movie.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 120.0,
            height: 100.0,
            child: ListTile(
              title: Text(
                movie.name,
                softWrap: true,
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              subtitle: Text(
                movie.time,
                softWrap: true,
                style: TextStyle(
                  fontSize: 10.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
