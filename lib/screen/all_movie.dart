import 'package:cinema_booking_v2/common_widget/common_widget.dart';
import 'package:cinema_booking_v2/entity/movie.dart';
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
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
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