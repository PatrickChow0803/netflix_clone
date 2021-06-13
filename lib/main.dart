import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:netflix_clone/core/models/now_showing_model.dart';
import 'package:netflix_clone/core/services/api.dart';

import 'core/presentation/movie_card.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late MovieController movieController;
  late Future<NowShowingModel> nowShowingFuture;

  void _setUp() {
    movieController = Get.put(MovieController());
    nowShowingFuture = () {
      return movieController.fetchShowingMovies();
    }();
  }

  @override
  void initState() {
    _setUp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height,
      // width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Now Showing',
                  textAlign: TextAlign.end,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: FutureBuilder(
                    future: nowShowingFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final NowShowingModel nowShowing =
                          snapshot.data as NowShowingModel;

                      return ListView.builder(
                        itemBuilder: (context, index) {
                          final Result movie = nowShowing.results[index];
                          return movieItem(movie);
                        },
                        itemCount: nowShowing.totalResults - 1,
                        scrollDirection: Axis.horizontal,
                      );
                    }),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Popular',
                  textAlign: TextAlign.end,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: FutureBuilder(
                    future: nowShowingFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final NowShowingModel nowShowing =
                          snapshot.data as NowShowingModel;

                      return ListView.builder(
                        itemBuilder: (context, index) {
                          final Result movie = nowShowing.results[index];
                          return movieItem(movie);
                        },
                        itemCount: nowShowing.totalResults - 1,
                        scrollDirection: Axis.horizontal,
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieController extends GetxController {
  // fetch now showing
  Future<NowShowingModel> fetchShowingMovies() async {
    try {
      final result = await Api.get('now_playing');
      return compute(nowShowingModelFromJson, result.body);
      // print(result.body)
    } catch (e) {
      throw 'Error in fetchShowingMovies(): $e';
    }
  }
}
