import 'dart:math';

class Minimax {
  List<String> originalBoard = List.filled(9, '');
  final String user = 'X';
  final String minimaxBot = 'O';
  String currentPlayer = 'X';

  List<int> _emptyBoardList(List<String> board) {
    List<int> emptyIndexies = [];
    board.asMap().forEach((i, e) {
      if (e == '') emptyIndexies.add(i);
    });
    return emptyIndexies;
  }

  bool winning(List<String> board, String player) {
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

  String? gameResult() {
    if (winning(originalBoard, 'X')) {
      return 'X';
    } else if (winning(originalBoard, 'O')) {
      return 'O';
    } else if (_emptyBoardList(originalBoard).isEmpty) {
      return 'DrawGame';
    } else {
      return null;
    }
  }

  int _minimax(List<String> board, int depth, bool isMaximizing) {
    String player = isMaximizing ? minimaxBot : user;
    if (winning(board, minimaxBot)) {
      return 10 - depth;
    } else if (winning(board, user)) {
      return depth - 10;
    } else if (_emptyBoardList(board).isEmpty) {
      return 0;
    }

    var bestScore = isMaximizing ? -1000 : 1000;
    final availableSpots = _emptyBoardList(board);
    for (final index in availableSpots) {
      board[index] = player;
      final score = _minimax(board, depth + 1, !isMaximizing);
      board[index] = '';
      bestScore = isMaximizing ? max(bestScore, score) : min(bestScore, score);
    }

    return bestScore;
  }

  void _botMove() {
    int bestScore = -1000;
    int bestMove = -1;
    for (int i = 0; i < originalBoard.length; i++) {
      if (originalBoard[i] == '') {
        originalBoard[i] = minimaxBot;
        int score = _minimax(originalBoard, 0, false);
        originalBoard[i] = '';
        if (score > bestScore) {
          bestScore = score;
          bestMove = i;
        }
      }
    }

    originalBoard[bestMove] = minimaxBot;
    currentPlayer = 'X';
  }

  userMove(int index) {
    if (originalBoard[index] == '') {
      originalBoard[index] = user;
      if (_emptyBoardList(originalBoard).isNotEmpty) {
        currentPlayer = 'O';
        _botMove();
      }
    }
  }

  clear() {
    originalBoard = List.filled(9, '');
    currentPlayer = 'X';
  }
}
