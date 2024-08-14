import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_live_score/entities/football.dart';
import 'package:firebase_live_score/ui/widgets/live_score_card.dart';
import 'package:flutter/material.dart';

class MatchListScreen extends StatefulWidget {
  const MatchListScreen({super.key});

  @override
  State<MatchListScreen> createState() => _MatchListScreenState();
}

class _MatchListScreenState extends State<MatchListScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<Football> matchList = [];

  Future<void> _getFootballMatches() async {
    matchList.clear();
    final QuerySnapshot result =
        await firebaseFirestore.collection('Football').get();

    for (QueryDocumentSnapshot doc in result.docs) {
      matchList.add(
        Football(
          matchName: doc.id,
          team1Score: doc.get('team1Score'),
          team2Score: doc.get('team2Score'),
          team1Name: doc.get('team1Name'),
          team2Name: doc.get('team2Name'),
        ),
      );
    }
    setState(() {});
  }

  @override
  void initState() {
    _getFootballMatches();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Football Live Score',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder(
        stream: firebaseFirestore.collection('Football').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {

          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if(snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if(snapshot.hasData == false) {
            return const Center(
              child: Text('Empty List'),
            );
          }

          matchList.clear();
          for (QueryDocumentSnapshot doc in snapshot.data?.docs ?? []) {
            matchList.add(
              Football(
                matchName: doc.id,
                team1Score: doc.get('team1Score'),
                team2Score: doc.get('team2Score'),
                team1Name: doc.get('team1Name'),
                team2Name: doc.get('team2Name'),
              ),
            );
          }

          return ListView.builder(
              itemCount: matchList.length,
              itemBuilder: (context, index) {
                return LiveScoreCard(football: matchList[index],);
              });
        }
      ),
    );
  }
}
