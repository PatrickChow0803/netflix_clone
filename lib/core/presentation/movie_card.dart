import 'package:flutter/material.dart';
import 'package:netflix_clone/core/models/now_showing_model.dart';

Widget movieItem(Result movie) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 150,
        child: Align(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movie.title,
            ),
          ),
          alignment: Alignment.bottomLeft,
        ),
        color: Colors.green,
      ),
    ),
  );
}
