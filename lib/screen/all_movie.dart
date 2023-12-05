import 'package:cinema_booking_v2/common_widget/common_widget.dart';
import 'package:cinema_booking_v2/entity/day.dart';
import 'package:cinema_booking_v2/entity/movie.dart';
import 'package:cinema_booking_v2/screen/home_screen.dart';
import 'package:cinema_booking_v2/screen/movie_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllMovieScreen extends StatefulWidget {
  const AllMovieScreen({super.key});

  @override
  State<AllMovieScreen> createState() => _AllMovieScreenState();
}

class _AllMovieScreenState extends State<AllMovieScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(title: 'Browse'),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(30.0),
              // child: TextField(
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(30.0),
              //       borderSide: const BorderSide(width: 8.0),
              //     ),
              //     hintText: 'Search movies or theatres',
              //     prefixIcon: const Icon(
              //       Icons.search,
              //       size: 30.0,
              //     ),
              //   ),
              // ),
              child: CupertinoSearchTextField(
                controller: _searchController,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: const Row(
                children: [
                  Expanded(
                      child: Text(
                    'All Movies',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  )),
                  Text(
                    'Filters',
                  )
                ],
              ),
            ),
            Expanded(
                child: FirebaseGridView(searchController: _searchController)),
          ],
        ));
  }
}

class FirebaseGridView extends StatefulWidget {
  final TextEditingController searchController;

  FirebaseGridView({super.key, required this.searchController});

  @override
  _FirebaseGridViewState createState() => _FirebaseGridViewState();
}

class _FirebaseGridViewState extends State<FirebaseGridView> {
  List _allMovie = [];

  List _resultMovie = [];
  @override
  void initState() {
    widget.searchController.addListener(_onSearchChanged);
    super.initState();
  }

  getClientStream() async {
    var data = await FirebaseFirestore.instance
        .collection('poster_items')
        .orderBy('name')
        .get();

    setState(() {
      _allMovie = data.docs;
    });

    searchResultMovie();
  }

  @override
  void dispose() {
    widget.searchController.removeListener(_onSearchChanged);
    widget.searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    getClientStream();
    super.didChangeDependencies();
  }

  void _onSearchChanged() {
    print(widget.searchController.text);
    searchResultMovie();
  }

  searchResultMovie() {
    var showResult = [];
    if (widget.searchController != '') {
      for (var clientSnapshot in _allMovie) {
        var name = clientSnapshot['name'].toString().toLowerCase();
        if (name.contains(widget.searchController.text.toLowerCase())) {
          showResult.add(clientSnapshot);
        }
      }
    } else {
      showResult = List.from(_allMovie);
    }

    setState(() {
      _resultMovie = showResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //   // Replace 'yourCollection' with the name of your Firebase collection
    //   future: FirebaseFirestore.instance.collection('poster_items').get(),
    //   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Center(child: CircularProgressIndicator());
    //     }

    //     if (snapshot.hasError) {
    //       return Center(child: Text('Error: ${snapshot.error}'));
    //     }

    //     // Process data from Firebase
    //     List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

    //     return GridView.builder(
    //       scrollDirection: Axis.vertical,
    //       shrinkWrap: true,
    //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //         crossAxisCount: 3,
    //         crossAxisSpacing: 8.0,
    //         mainAxisSpacing: 8.0,
    //         childAspectRatio: 1,
    //       ),
    //       itemCount: documents.length,
    //       itemBuilder: (context, index) {
    //         var data = documents[index].data() as Map<String, dynamic>;
    //         Movie temp = Movie(
    //           imageUrl: data['ImageUrl'] ?? '',
    //           name: data['name'] ?? '',
    //           time: data['time'] ?? '',
    //           category: [data['category1'] ?? '', data['category2'] ?? ''],
    //           description: data['description'] ?? '',
    //           rate: data['rate'] ?? '',
    //           year: data['year'] ?? '',
    //         );
    //         return GridItem(
    //           movie: temp,
    //         );
    //       },
    //     );
    //   },
    // );
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          // crossAxisSpacing: 0,
          // mainAxisSpacing: 0,
          childAspectRatio: 0.54,
        ),
        itemCount: _resultMovie.length,
        itemBuilder: (context, index) {
          var data = _resultMovie[index].data() as Map<String, dynamic>;
          return GridItem(
            movie: Movie.fromMap(data),
          );
        },
      ),
    );
    //   },
  }
}

class GridItem extends StatelessWidget {
  final Movie movie;

  GridItem({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100.0,
        child: Column(
          children: [
            Container(
              height: 180.0,
              width: 120.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MoviePageScreen(movie: movie)), //jdshfjkashfdkj
                  );
                },
                child: Container(
                  // padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                        Radius.circular(8.0)), // Điều chỉnh độ cong để bo góc
                    child: Image.network(
                      movie.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 150.0,
              height: 50.0,
              child: ListTile(
                title: Text(
                  movie.name,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 14.0,
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
        ));
  }
}
