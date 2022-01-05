import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Game {
  List<List<dynamic>> data;
  String name;
  String group;
  String sex;
  int id;
  int round;
  // Statistics
  bool isWin = false;
  bool isBlock = false;
  bool isFork = false;
  bool isForkBlock = false;
  bool isBlockPossible = false;
  bool isWinPossible = false;

  bool isFilled = false;
  bool isDraw = false;

  bool blockWasPossible = false;
  bool winWasPossible = false;

  var board =
  List.generate(3, (i) => List.filled(3, 0, growable: false), growable: false);
  var statesBoard =
  List.generate(3, (i) => List.filled(3, _GameFieldState(), growable: false), growable: false);

  final roundTimer = Stopwatch();
  final moveTimer = Stopwatch();

  bool training;
  int turn;
  // who starts 1 == computer, 2 == user
  Game(this.turn, this.training, this.data, this.name, this.sex, this.group, this.id, this.round);

  void start() {
   blockWasPossible = false;
   winWasPossible = false;

   roundTimer.start();
   moveTimer.start();
  }

  bool end() {
    return isWin || isFilled;
  }

  bool computerMove() {
    if (!isWin) {
      List<int> optimalMove = nextMove(board);
      int i = optimalMove[0];
      int j = optimalMove[1];
      bool r = gameMove(i, j, this, 1);

      statesBoard[i][j].setState(() {});

      return r;
    }
    return false;
  }
}

class GameView extends StatelessWidget{
  Game game;
  GameView(this.game);

  Widget blackLine = Container(
      decoration: const BoxDecoration(
          color: Colors.black
      ),
      height: 10,
      width: 310
  );

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: [
            BoardRow(0, game),
            blackLine,
            BoardRow(1, game),
            blackLine,
            BoardRow(2, game)
          ],
        )
    );
  }

}

class BoardRow extends StatelessWidget{
  int row;
  Game game;
  BoardRow(this.row, this.game);

  Widget blackLine = Container(
      decoration: const BoxDecoration(
          color: Colors.black
      ),
      height: 105,
      width: 10
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child:Row (
        children: [
          GameField(row, 0, game),
          blackLine,
          GameField(row, 1, game),
          blackLine,
          GameField(row, 2, game)
        ],
      )
    );
  }
}

class GameField extends StatefulWidget{
  bool blinking = false;
  int i; // row
  int j; // column
  Game game;
  GameField(this.i, this.j, this.game) {
    blinking = false;
  }

  @override
  State<StatefulWidget> createState() => _GameFieldState();
}

class _GameFieldState extends State<GameField> {
  void startBlinking() {
    setState(() {
      widget.blinking = true;
    });
  }

  // Returns proper image of cross or circle or empty (blinking or not).
  Widget image(BuildContext context) {
    if (widget.blinking) {
      return BlinkingIcon(circleCrossIcon(context));
    }
    else {
      return circleCrossIcon(context);
    }
  }

  // Returns circle or cross or empty depending on whose move was last.
  Widget circleCrossIcon(BuildContext context) {
    int imageId = widget.game.board[widget.i][widget.j];
    if (imageId == 1) {
      return const Icon(
        Icons.panorama_fish_eye,
        color: Colors.blue,
        size: 100
      );
    }
    else if (imageId == 2) {
      return const Icon(
          Icons.clear_outlined,
          color: Colors.red,
          size: 100
      );
    }
    else {
      return const Icon(
          Icons.crop_square_sharp,
          color: Colors.white,
          size: 100
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.game.statesBoard[widget.i][widget.j] = this;

    return GestureDetector(
      child: image(context),
      onTap: () => {
        gameMove(widget.i, widget.j, widget.game, 2),
        setState((){}),
      },
    );
  }
}

// player == 1 if it was a computer's move
// player == 2 if it was user's move
bool gameMove(int i, int j, Game game, int player) {
  if (game.turn == player && game.board[i][j] == 0 && !game.end()) {

    game.board[i][j] = player;
    generateStats(i, j, game, player);

    debugPrint(game.board.toString());
    game.turn = 3 - game.turn; // Turn of other player

    game.moveTimer.reset();
    return true;
  }
  else {
    return false;
  }
}


List<List<int>>? isWinCheck(List<List<int>> board) {
  for (int i = 0; i < lines.length; i++) {
    if (board[lines[i][0][0]][lines[i][0][1]] == board[lines[i][1][0]][lines[i][1][1]] &&
        board[lines[i][2][0]][lines[i][2][1]] == board[lines[i][1][0]][lines[i][1][1]] &&
        board[lines[i][2][0]][lines[i][2][1]] != 0) {
      return lines[i];
    }
  }
  return null;
}

List<int>? isWinPossibleCheck(List<List<int>> board, int player) {
  int counter = 0;
  List<int> rval = [];

  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (board[i][j] == 0) {
        board[i][j] = player; //Assume this field was set
        if (isWinCheck(board) != null) {
          board[i][j] = 0; // Real value
          rval = [i,j];
          counter++;
        }
        board[i][j] = 0; // Real value
      }
    }
  }

  if (counter == 0) {
    return null;
  }
  else {
    rval.add(counter);
    return rval;
  }
}


// Check if on [i,j] there is sign of other player than is on rest
// of some row/column/diagonal containing [i,j]
List<List<int>>? isBlockCheck(int i, int j, List<List<int>> board) {
  for (int l = 0; l <lines.length; l++) {
    for (int k = 0; k < 3; k++) {
      if (i == lines[l][k][0] && j == lines[l][k][1]) {
        int i1 = lines[l][(k+1)%3][0];
        int j1 = lines[l][(k+1)%3][1];
        int i2 = lines[l][(k+2)%3][0];
        int j2 = lines[l][(k+2)%3][1];
        // Check if in this row/column/diagonal there was a block
        if (board[i1][j1] == 3 - board[i][j] &&
            board[i2][j2] == 3 - board[i][j]) {
          return lines[l];
        }
      }
    }
  }
  return null;
}

List<int>? isBlockPossibleCheck(List<List<int>> board, int player) {
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (board[i][j] == 0) {
        board[i][j] = player; // Assume player choose this field
        if (isBlockCheck(i,j,board) != null) {
          board[i][j] = 0; // Real value
          return [i, j];
        }
        board[i][j] = 0; // Real value
      }
    }
  }
  return null;
}

// Check if sign on [i,j] was a fork.
List<List<int>>? isForkCheck(int i, int j, List<List<int>> board) {
  for (int l = 0; l <lines.length; l++) {
    for (int k = 0; k < 3; k++) {
      if (i == lines[l][k][0] && j == lines[l][k][1]) {
        int i1 = lines[l][(k+1)%3][0];
        int j1 = lines[l][(k+1)%3][1];
        int i2 = lines[l][(k+2)%3][0];
        int j2 = lines[l][(k+2)%3][1];
        // Check if in this row/column/diagonal there was a block
        if (board[i1][j1] == board[i][j] ||
            board[i2][j2] == board[i][j]) {
          return lines[l];
        }
      }
    }
  }
  return null;
}

List<List<int>>? isForkBlockCheck(int i, int j, List<List<int>> board) {
  for (int l = 0; l <lines.length; l++) {
    for (int k = 0; k < 3; k++) {
      if (i == lines[l][k][0] && j == lines[l][k][1]) {
        int i1 = lines[l][(k+1)%3][0];
        int j1 = lines[l][(k+1)%3][1];
        int i2 = lines[l][(k+2)%3][0];
        int j2 = lines[l][(k+2)%3][1];
        // Check if in this row/column/diagonal there was a block
        if (board[i1][j1] == 3-board[i][j] ||
            board[i2][j2] == 3-board[i][j]) {
          return lines[l];
        }
      }
    }
  }
  return null;
}

bool isFilledCheck(List<List<int>> board) {
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (board[i][j] == 0) {
        return false;
      }
    }
  }
  return true;
}

bool isEmptyCheck(List<List<int>> board) {
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (board[i][j] != 0) {
        return false;
      }
    }
  }
  return true;
}



void generateStats(int i, int j, Game game, int player) {
  List<List<int>> board = game.board;

  List<List<int>>? winningFields = isWinCheck(board);
  game.isWin = (winningFields != null);
  game.isBlock = (isBlockCheck(i, j, board) != null);
  game.isFork = (isForkCheck(i, j, board) != null);
  game.isForkBlock = (isForkBlockCheck(i, j, board) != null);
  game.isBlockPossible = !game.isBlock && (isBlockPossibleCheck(board,player) != null);
  board[i][j] = 0; // Undo move
  game.isWinPossible = !game.isWin && (isWinPossibleCheck(board, player) != null);
  board[i][j] = player; //Redo move


  game.isFilled = isFilledCheck(board);
  game.isDraw = game.isFilled && !game.isWin;

  var otherPlayerCheck = isWinPossibleCheck(board, 2-player);
  bool wontLoseIfBlock = (otherPlayerCheck != null && otherPlayerCheck[2] == 1) && !game.isBlock;


  if (game.isWin) {
    winning(game, winningFields, player);
  }

  game.data.add([
    game.id,
    player == 1 ? "komputer" : game.name,
    game.round == 0 ? "treningowa" : "testowa",
    player == 1 ? game.sex : "0",
    game.group,
    game.round,
    game.round % 2 == 0 ? game.name : "komputer",
    board.toString().replaceAll("1", "O").replaceAll("2", "X").replaceAll("0", "-"),
    [i, j].toString(),
    game.isWin,
    game.isBlock,
    game.isFork,
    game.isForkBlock,
    game.isBlockPossible,
    game.isWinPossible,
    !game.blockWasPossible && game.isBlock,
    !game.winWasPossible && game.isWin,
    game.isDraw,
    wontLoseIfBlock,
    game.isFilled,
    game.moveTimer.elapsed.toString(),
    game.roundTimer.elapsed.toString()
  ]);

  game.blockWasPossible = game.blockWasPossible || game.isBlockPossible;
  game.winWasPossible = game.winWasPossible || game.isWinPossible;

}

// Next optiamal move
List<int> nextMove(List<List<int>> board, {int player = 1}) {
  if (isEmptyCheck(board)) {
    return vertices[Random.secure().nextInt(4)];
  }

  var win = isWinPossibleCheck(board, player);
  if (win != null) {
    return [win[0], win[1]];
  }
  var block = isBlockPossibleCheck(board, player);
  if (block != null) {
    return block;
  }
  int x,y;
  do {
    x = Random.secure().nextInt(3);
    y = Random.secure().nextInt(3);
  } while(board[x][y] != 0);
  return [x,y];
}

void winning(Game game, List<List<int>>? fields, int player) async {
  if (fields == null) {
    return;
  }

  // Make winning fields blink.
  for (int i = 0; i < 3; i++) {
    game.statesBoard[fields[i][0]][fields[i][1]].startBlinking();
  }
  
  // Playing winning sound.
  SystemSound.play(SystemSoundType.alert);
}

class BlinkingIcon extends StatefulWidget {
  late Widget crossCircleIcon;

  BlinkingIcon(this.crossCircleIcon);

  @override
  _BlinkingIconState createState() => _BlinkingIconState();
}

class _BlinkingIconState extends State<BlinkingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController =
    AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _animationController.repeat(reverse: true);

    Future.delayed(const Duration(seconds: 1), () {
      _animationController.stop();
    });
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: widget.crossCircleIcon
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

final lines = [
  [[0, 0], [0, 1], [0, 2]],
  [[1, 0], [1, 1], [1, 2]],
  [[2, 0], [2, 1], [2, 2]],
  [[0, 0], [1, 0], [2, 0]],
  [[0, 1], [1, 1], [2, 1]],
  [[0, 2], [1, 2], [2, 2]],
  [[0, 0], [1, 1], [2, 2]],
  [[0, 2], [1, 1], [2, 0]],
];

final vertices = [
  [0,0], [2,2], [0,2], [2,0]
];

