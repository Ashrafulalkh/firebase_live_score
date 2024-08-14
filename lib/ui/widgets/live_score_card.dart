import 'package:firebase_live_score/entities/football.dart';
import 'package:flutter/material.dart';

class LiveScoreCard extends StatelessWidget {
  const LiveScoreCard({
    super.key,
    required this.football,
  });

  final Football football;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildTeam(football.team1Score, football.team1Name),
            const Text(
              'Vs',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
            _buildTeam(football.team2Score, football.team2Name),
          ],
        ),
      ),
    );
  }

  Column _buildTeam(int score, String teamName) {
    return Column(
      children: [
        Text(
          score.toString(),
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        Text(
          teamName,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
