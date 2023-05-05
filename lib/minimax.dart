class Minimax {
  List<String> originalBoard = List.filled(9, '');
  String user = 'X';
  String minimaxBot = 'O';
  String currentPlayer = 'X';

  List<int> _emptyBoardList(List<String> board) {
    List<int> emptyIndexies = [];
    board.map((e) => e == '' ? emptyIndexies.add(board.indexOf(e)) : null);
    return emptyIndexies;
  }

  bool winning(board, player) {
    if ((board[0] == player && board[1] == player && board[2] == player) ||
        (board[3] == player && board[4] == player && board[5] == player) ||
        (board[6] == player && board[7] == player && board[8] == player) ||
        (board[0] == player && board[3] == player && board[6] == player) ||
        (board[1] == player && board[4] == player && board[7] == player) ||
        (board[2] == player && board[5] == player && board[8] == player) ||
        (board[0] == player && board[4] == player && board[8] == player) ||
        (board[2] == player && board[4] == player && board[6] == player)) {
      return true;
    } else {
      return false;
    }
  }

  String winner() {
    if (winning(originalBoard, minimaxBot)) {
      return minimaxBot;
    } else {
      return user;
    }
  }

  bool gameEnded() {
    if (winning(originalBoard, 'X')) {
      return true;
    } else if (winning(originalBoard, 'O')) {
      return true;
    } else {
      return false;
    }
  }

  _minimax(List<String> board, int depth, String player) {
    List<int> availSpots = _emptyBoardList(board);

    if (winning(board, player)) {
      return 10;
    } else if (winning(board, player)) {
      return -10;
    } else if (availSpots.isEmpty) {
      return 0;
    }

    if (player == 'X') {
      int bestScore = -1000;
      for (int x = 0; x < 9; x++) {
        if (board[x] == '') {
          board[x] = minimaxBot;
          int score = _minimax(board, depth + 1, player);
          board[x] = '';
          if (score > bestScore) {
            bestScore = score;
          }
        }
      }
      return bestScore;
    } else {
      int bestScore = 1000;
      for (int x = 0; x < 9; x++) {
        if (board[x] == '') {
          board[x] = user;
          int score = _minimax(board, depth + 1, player);
          board[x] = '';
          if (score > bestScore) {
            bestScore = score;
          }
        }
      }
      return bestScore;
    }
  }

  void botMove() {
    int move = -1;
    int bestScore = -1000;
    List<String> tBoard = originalBoard;
    for (int x = 0; x < 9; x++) {
      if (tBoard[x] == '') {
        tBoard[x] = minimaxBot;
        int score = _minimax(tBoard, 0, minimaxBot);
        tBoard[x] = '';
        if (score > bestScore) {
          bestScore = score;
          move = x;
        }
      }
    }

    originalBoard[move] = minimaxBot;
  }

  userMove(int index) {
    originalBoard[index] = user;
    botMove();
  }
}
