import 'dart:io';

void main() {
  List<String> board = List.filled(9, ' ');
  String currentPlayer = 'X';
  bool gameOver = false;

  print('Welcome to Tic Tac Toe!');
  printInstructions();

  while (!gameOver) {

    displayBoard(board);

  
    print('Player $currentPlayer\'s turn. Enter a number (1-9):');
    String? input = stdin.readLineSync();

   
    if (input == null || !isValidMove(input, board)) {
      print('Invalid move. Try again.');
      continue;
    }

    int move = int.parse(input) - 1;
    board[move] = currentPlayer;

   
    if (checkWinner(board, currentPlayer)) {
      displayBoard(board);
      print('Player $currentPlayer wins!');
      gameOver = true;
    }

    else if (!board.contains(' ')) {
      displayBoard(board);
      print('It\'s a draw!');
      gameOver = true;
    }
   
    else {
      currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
    }
  }


  print('Do you want to play again? (y/n):');
  String? playAgain = stdin.readLineSync();
  if (playAgain?.toLowerCase() == 'y') {
    main();
  } else {
    print('Thanks for playing!');
  }
}


void printInstructions() {
  print('Enter a number from 1 to 9 to make your move:');
  print(' 1 | 2 | 3 ');
  print('---+---+---');
  print(' 4 | 5 | 6 ');
  print('---+---+---');
  print(' 7 | 8 | 9 ');
  print('');
}


void displayBoard(List<String> board) {
  print(' ${board[0]} | ${board[1]} | ${board[2]} ');
  print('---+---+---');
  print(' ${board[3]} | ${board[4]} | ${board[5]} ');
  print('---+---+---');
  print(' ${board[6]} | ${board[7]} | ${board[8]} ');
  print('');
}


bool isValidMove(String input, List<String> board) {
  try {
    int move = int.parse(input);
    if (move < 1 || move > 9) return false;
    return board[move - 1] == ' ';
  } catch (e) {
    return false;
  }
}


bool checkWinner(List<String> board, String player) {
  const winPatterns = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], 
    [0, 3, 6], [1, 4, 7], [2, 5, 8], 
    [0, 4, 8], [2, 4, 6], 
  ];

  for (var pattern in winPatterns) {
    if (board[pattern[0]] == player &&
        board[pattern[1]] == player &&
        board[pattern[2]] == player) {
      return true;
    }
  }
  return false;
}