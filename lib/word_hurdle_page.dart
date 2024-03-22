import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_hurdle_project/helper_function.dart';
import 'package:word_hurdle_project/hurdle_provider.dart';
import 'package:word_hurdle_project/keyboard_view.dart';
import 'package:word_hurdle_project/launcher_Screen.dart';
import 'package:word_hurdle_project/wordle_view.dart';

class WordHurdlePage extends StatefulWidget {
  static const String routeName = "/wordhurdlepage";
  const WordHurdlePage({super.key});

  @override
  State<WordHurdlePage> createState() => _WordHurdlePageState();
}

class _WordHurdlePageState extends State<WordHurdlePage> {
  @override
  void didChangeDependencies() {
    Provider.of<HurdleProvider>(context, listen: false).init();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Word Hurdle"),
        actions: [
          IconButton(
              onPressed: (){
                _gameRules();
              },
              icon: Icon(Icons.info),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: 250,
                height: 250,
                child: Consumer<HurdleProvider>(
                  builder: (context, provider, child) => GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                      ),
                      itemCount:provider.hurdleBoard.length,
                      itemBuilder:(context,index){
                        final wordle = provider.hurdleBoard[index];
                        return WordleView(wordle: wordle);
                      }
                  ),
                ),
              ),
            ),
            Consumer<HurdleProvider>(
              builder: (context, provider, child) => KeyboardView(
                excludedLetters: provider.excludedLetters,
                onPressed:(value){
                  provider.inputLetter(value);
                }
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(16.0),
              child: Consumer<HurdleProvider>(
                builder: (context, provider, child) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: (){
                          provider.deleteLetter();
                        },
                        child:const Text("DELETE"),
                    ),
                    ElevatedButton(
                        onPressed: (){
                            _submit(provider);

                        },
                        child:const Text("SUBMIT"),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  _submit(HurdleProvider provider){
    if(!provider.isAValidWord){
      showMsg(context, "Not a word in dictionary");
      return;
    }

    if(provider.shouldCheckForAnswer){
      provider.checkAnswer();
    }
    if(provider.wins){
      showResult(
          context: context,
          title:"YOU WIN!!!",
          body: "The word was ${provider.targetWord}",
          onPlayAgain: (){
            Navigator.pop(context);
            provider.reset();
          },
          onCancel: (){
            Navigator.pushReplacementNamed(context, LauncherScreen.routeName);
          }
      );
    } else if(provider.notAttempLeft){
      showResult(
          context: context,
          title: "YOU LOST!!!",
          body: "The word was ${provider.targetWord}",
          onPlayAgain: (){
            Navigator.pop(context);
            provider.reset();
          },
          onCancel: (){
            Navigator.pushReplacementNamed(context, LauncherScreen.routeName);

          });
    }
  }

  void _gameRules() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Game Rules"),
          content: Text(Rules),
          actions: [
            OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("CLOSE"),
            ),
          ],

        ),
    );
  }
}
const Rules= '''
  1.There is a random target word.
  Which word you guess and
  submit in 6 rows.
  
  2.Must enter a valid word.
  
  3.Never submit without enter five
  word.
  
  4.After submission,the green 
  marked words
  in the rows are target word.
''';
