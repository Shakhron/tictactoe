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
              _playerCard('X', minimax.currentPlayer),
              SizedBox(width: size.width * 0.075),
              _playerCard('O', minimax.currentPlayer),
            ],
          ),
          SizedBox(height: size.height * 0.02),
          _gameResultWidget(minimax.gameResult()),
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
      floatingActionButton: IconButton(
        icon: const Icon(
          Icons.restart_alt,
          color: Colors.amber,
        ),
        onPressed: () {
          minimax.clear();
          setState(() {});
        },
      ),
    );
  }

  _playerCard(String player, String currentPlayer) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: currentPlayer == player
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
              player == 'X' ? 'images/user.png' : 'images/bot.png',
              width: 55,
            ),
            const SizedBox(height: 10),
            Text(
              player == 'X' ? 'User' : 'Bot',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 10),
            Image.asset(
              'images/${player.toLowerCase()}.png',
              width: 30,
            ),
          ],
        ),
      ),
    );
  }

  _gameResultWidget(String? result) {
    switch (result) {
      case 'DrawGame':
        return Image.asset(
          'images/${minimax.gameResult()!.toLowerCase()}.png',
          width: 45,
        );
      case 'X':
        return const Text(
          'You WIN!',
          style: TextStyle(
            fontSize: 32,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        );
      case 'O':
        return const Text(
          'You LOSE!',
          style: TextStyle(
            fontSize: 32,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        );
      default:
        return const SizedBox();
    }
  }
}
