import 'package:flutter/material.dart';
import 'package:tictactoe/minimax.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  final Minimax minimax = Minimax();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff36248d),
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: minimax.currentPlayer == 'X'
                        ? const Color(0xfffed031)
                        : const Color(0xff332167),
                  ),
                  color: const Color(0xff332167),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Image.asset(
                        'images/user.png',
                        width: 55,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'User',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Image.asset(
                        'images/x.png',
                        width: 30,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: size.width * 0.075),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: minimax.currentPlayer == 'O'
                        ? const Color(0xfffed031)
                        : const Color(0xff332167),
                  ),
                  color: const Color(0xff332167),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Image.asset(
                        'images/bot.png',
                        width: 55,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Bot',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Image.asset(
                        'images/o.png',
                        width: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.02),
          if (minimax.gameEnded())
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/${minimax.winner().toLowerCase()}.png',
                  width: 32,
                ),
                const SizedBox(width: 8),
                const Text(
                  'WIN!',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          SizedBox(height: size.height * 0.025),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xff6549c4),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: GridView.builder(
                itemCount: 9,
                shrinkWrap: true,
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (minimax.currentPlayer == minimax.minimaxBot) {
                        return;
                      } else {
                        minimax.userMove(index);
                        setState(() {});
                      }
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xff332167),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: minimax.originalBoard[index] == ''
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Image.asset(
                                  'images/${minimax.originalBoard[index].toLowerCase()}.png'),
                            ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
