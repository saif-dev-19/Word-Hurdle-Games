import 'package:flutter/material.dart';
import 'package:word_hurdle_project/wardle.dart';

class WordleView extends StatelessWidget {
  final Wordle wordle;
  const WordleView({super.key, required this.wordle});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: wordle.existInTarget ? Colors.greenAccent :
            wordle.doesNotExistInTarget ? Colors.black12
                :null,
        border : Border.all(
          color: Colors.amber,
          width: 1.5,
        ),
      ),
      child: Text(wordle.letter, style: TextStyle(
        fontSize: 16,
        color: wordle.existInTarget ? Colors.black :
            wordle.doesNotExistInTarget ? Colors.white30
                :null,
      ),

       ),
    );
  }
}
