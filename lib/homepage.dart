import 'package:flutter/material.dart';
import 'package:quiz/answer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List <Icon> _scoreTracker = [];
  int _questionIndex = 0;
  int _totalScore = 0;
  bool answerWasSelected = false;
  bool endOfQuiz =false;

 void _questionAnswered(bool answerScore) {
   setState((){
     answerWasSelected = true;
     if(answerScore) {
       _totalScore++;
     }
     _scoreTracker.add(
         answerScore ?const  Icon(
       Icons.check_circle,
       color: Colors.green,
     ): const  Icon(Icons.cancel,
     color: Colors.red,
         ),);
     if(_questionIndex + 1 == _questions.length){
       endOfQuiz = true;
     }
   });
 }

 void _nextQuestion(){
   setState(() {
     _questionIndex++;
     answerWasSelected = false;
   });
   if (_questionIndex >= _questions.length) {
     _resetQuiz();
   }
 }

 void _resetQuiz(){
   setState((){
     _questionIndex = 0;
     _totalScore = 0;
     _scoreTracker = [];
     endOfQuiz = false;

   });
 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App',),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
             children:  [
               if(_scoreTracker.length == 0)
                 SizedBox(
                   height: 25,
                 ),
               if (_scoreTracker.length > 0) ..._scoreTracker,
             ],
          ),
          Container(
            height: 150,
            width: double.infinity,
            padding: const EdgeInsets.symmetric( horizontal: 30),
            margin: const   EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 20),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(20),
            ),
            child:  Center(
                child: Text(
                    _questions[_questionIndex]['question'].toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                )),
          ),

          ...(_questions[_questionIndex]['answer']
          as List<Map<String, dynamic>>).map((answer) => Answer(answerText: answer['answerText'],
          answerColor: answerWasSelected? answer['score'] ? Colors.green : Colors.redAccent : Colors.white,
            answerTap: () {
            if(answerWasSelected){
              return;
            }

            _questionAnswered(answer['score']);
            },
          ),),

          Container(
            width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if(!answerWasSelected){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select answer before getting to the next question')));
                    return;
                  }
                  _nextQuestion();
                },
                child: Text(endOfQuiz ? 'Restart Quiz' : 'Next Question',),),),

          const SizedBox(
            height: 20,
          ),

          Center(
           child: Text('${_totalScore.toString()}/ ${_questions.length}',
             style: TextStyle(
                 fontSize: 40,
                 fontWeight: FontWeight.bold),),),


        ],
      ),
    );
  }
}

final _questions = const [
  {
    'question' : 'How long is New Zealand Ninety Mile Beach?',
    'answer': [
      {'answerText': ' 88km, so 55 miles long', 'score': true},
      {'answerText': ' 55km, so 34 miles long', 'score': false},
      {'answerText': ' 98km, so 73 miles long', 'score': false},
    ],
  },

  {
    'question' : 'In which month does the German festival of Oktoberfest mostly take place?',
  'answer':[
    {'answerText': ' January', 'score': false},
    {'answerText': ' October', 'score': false},
    {'answerText': ' September', 'score': true},
  ],
  },

  {
    'question' : 'In which country are panama hat made?',
    'answer': [
      {'answerText': ' Ecuador', 'score': true},
      {'answerText': ' Panama', 'score': false},
      {'answerText': 'Portugal', 'score': false},
    ],
  },

  {
    'question' : 'Who is the highest goal scorer in the Champions League?',
    'answer':[
      {'answerText': ' Messi', 'score': false},
      {'answerText': ' Ronaldo', 'score': true},
      {'answerText': ' Mbappe', 'score': false},
    ],
  },

  {
    'question' : 'From which country do French Fries originate?',
    'answer': [
      {'answerText': ' Belgium', 'score': true},
      {'answerText': ' France', 'score': false},
      {'answerText': ' Switzerland', 'score': false},
    ],
  },

  {
    'question' : 'who sang the song- Essence?',
    'answer':[
      {'answerText': ' Wizkid ft Tems', 'score': true},
      {'answerText': ' Naira marley ft Tiwa savage', 'score': false},
      {'answerText': ' Davido ft Arya Starr', 'score': false},
    ],
  },

  {
    'question' : 'Which country is Drake from?',
    'answer': [
      {'answerText': ' Mexico', 'score': false},
      {'answerText': ' Canada', 'score': true},
      {'answerText': 'USA', 'score': false},
    ],
  },

  {
    'question' : 'what is the capital of Lagos?',
    'answer':[
      {'answerText': ' Asaba', 'score': false},
      {'answerText': ' Alausa', 'score': false},
      {'answerText': ' Ikeja', 'score': true},
    ],
  },

  {
    'question' : 'Who is the first black President of the United State of America?',
    'answer':[
      {'answerText': ' Barrack Obama', 'score': true},
      {'answerText': ' Olusegun Obasanjo', 'score': false},
      {'answerText': 'Idris Elba', 'score': false},
    ],
  },
];
