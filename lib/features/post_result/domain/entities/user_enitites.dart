class UserEntities {
  final String? name;
  final int? score;
  final String? uid;
  final List<Answers>? answers;

  const UserEntities({
    this.name,
    this.score,
    this.uid,
    this.answers,
  });

  factory UserEntities.fromDocument(Map<String, dynamic> data) {
    List<dynamic>? answersData = data['answers'];
    List<Answers>? answers = answersData?.map((item) {
      return Answers(item['question'], item['answer'], item['isTrue']);
    }).toList();

    return UserEntities(
      name: data['name'],
      score: data['score'],
      uid: data['uid'],
      answers: answers,
    );
  }

  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> answersData = answers!.map((ans) {
      return {
        'question': ans.question,
        'answer': ans.answer,
      };
    }).toList();

    return {
      'name': name,
      'score': score,
      'uid': uid,
      'answers': answersData,
    };
  }
}

class Answers {
  final String question;
  final String answer;
  final bool isTrue;
  Answers(this.question, this.answer, this.isTrue);
}
