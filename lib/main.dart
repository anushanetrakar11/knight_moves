import 'package:flutter/material.dart';

void main() {
  runApp(ChessApp());
}

class ChessApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chess Game',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/game': (context) => ChessGameScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Knight Moves')),
      body: Center(
        child: ElevatedButton(
          child: Text("Start Game"),
          onPressed: () => Navigator.pushNamed(context, '/game'),
        ),
      ),
    );
  }
}

class ChessGameScreen extends StatefulWidget {
  @override
  _ChessGame_toggle createState() => _ChessGame_toggle();
}

class _ChessGame_toggle extends State<ChessGameScreen> {
  List<List<String>> board = [
    ['r','n','b','q','k','b','n','r'],
    ['p','p','p','p','p','p','p','p'],
    ['','','','','','','',''],
    ['','','','','','','',''],
    ['','','','','','','',''],
    ['','','','','','','',''],
    ['P','P','P','P','P','P','P','P'],
    ['R','N','B','Q','K','B','N','R'],
  ];

  int? selectedRow;
  int? selectedCol;

  void movePiece(int r,int c){
    setState(() {
      if(selectedRow==null){
        selectedRow=r;
        selectedCol=c;
      }else{
        board[r][c]=board[selectedRow!][selectedCol!];
        board[selectedRow!][selectedCol!]='';
        selectedRow=null;
        selectedCol=null;
      }
    });
  }

  Widget square(int r,int c){
    bool white=(r+c)%2==0;
    String piece=board[r][c];

    return GestureDetector(
      onTap: ()=>movePiece(r,c),
      child: Container(
        color:white?Colors.white:Colors.brown,
        child: Center(
          child: Text(
            symbols[piece]??"",
            style: TextStyle(fontSize:32),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chess Board")),
      body: GridView.builder(
        itemCount:64,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:8),
        itemBuilder:(c,i){
          int r=i~/8;
          int col=i%8;
          return square(r,col);
        },
      ),
    );
  }
}

Map<String,String> symbols={
  'r':'♜','n':'♞','b':'♝','q':'♛','k':'♚','p':'♟',
  'R':'♖','N':'♘','B':'♗','Q':'♕','K':'♔','P':'♙',
};
