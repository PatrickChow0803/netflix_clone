import 'package:flutter/material.dart';
import 'package:netflix_clone/core/models/now_showing_model.dart';
import 'package:netflix_clone/core/util/constant_strings.dart';

Widget movieItem(Result movie) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 300,
        child: Stack(children: [
          Container(
              // LayoutBuilder here because I want to get the dimensions of the parent widget
              // to make the image take up all of the container's dimensions
              child: LayoutBuilder(
            builder: (context, constraints) => Image.network(
              '${ConstantStrings.imageUrl}${movie.backdropPath}',
              fit: BoxFit.cover,
              height: constraints.maxHeight,
              width: constraints.maxWidth,
            ),
          )),
          Align(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      movie.title,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          backgroundColor: Colors.black,
                          fontSize: 16),
                    ),
                  ),
                  Text(
                    '${movie.voteAverage}',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.black,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
            alignment: Alignment.bottomLeft,
          ),
        ]),
        color: Colors.green,
      ),
    ),
  );
}
