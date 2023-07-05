import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notnetflix/repository/data_repository.dart';
import 'package:notnetflix/utils/constantes.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getMovies();
  }

  Future<void> getMovies() async {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    await dataProvider.getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: Image.asset('assets/images/netflix_logo_2.png'),
      ),
      body: ListView(
        children: [
          Container(
            height: 500,
            color: kPrimaryColor,
            child: dataProvider.popularMovieList.isEmpty
                ? const Center()
                : Image.network(
                    dataProvider.popularMovieList[0].posterURL(),
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(height: 20),
          Text(
            'Tendances actuelles',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 160,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (BuildContext context, index) => Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: 110,
                      color: Colors.yellow,
                      child: dataProvider.popularMovieList.isEmpty
                          ? Center(
                              child: Text(index.toString()),
                            )
                          : Image.network(
                              dataProvider.popularMovieList[0].posterURL(),
                              fit: BoxFit.cover,
                            ),
                    )),
          ),
          const SizedBox(height: 20),
          Text(
            'Au cinema',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 360,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (BuildContext context, index) => Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: 210,
                      color: const Color.fromARGB(255, 59, 255, 105),
                      child: Center(
                        child: Text(index.toString()),
                      ),
                    )),
          ),
          const SizedBox(height: 20),
          Text(
            'À venir',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 160,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (BuildContext context, index) => Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: 110,
                      color: const Color.fromARGB(255, 59, 180, 255),
                      child: Center(
                        child: Text(index.toString()),
                      ),
                    )),
          )
        ],
      ),
    );
  }
}
