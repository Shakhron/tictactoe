import 'package:flutter/material.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  final List<String> _board = List.filled(9, '');
  String _currentPlayer = 'X';
  String _winner = "";

  _play(int index) {
    if (_winner != '' || _board[index] != '') {
      return;
    }
    setState(() {
      _board[index] = _currentPlayer;
      _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
      _checkForWinner();
    });
  }

  _checkForWinner() {
    List<List<int>> lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (List<int> line in lines) {
      String player1 = _board[line[0]];
      String player2 = _board[line[1]];
      String player3 = _board[line[2]];
      if (player1 == '' || player2 == '' || player3 == '') {
        continue;
      }
      if (player1 == player2 && player2 == player3) {
        setState(() {
          _winner = player1;
        });
        break;
      }
    }
  }

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
                    color: _currentPlayer == 'X'
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
                    color: _currentPlayer == 'O'
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
          if (_winner != '')
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/${_winner.toLowerCase()}.png',
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
                    onTap: () => _play(index),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xff332167),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: _board[index] == ''
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Image.asset(
                                  'images/${_board[index].toLowerCase()}.png'),
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
