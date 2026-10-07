import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/user_profile.dart';
import '../services/auth_service.dart';
import '../theme/mythos_theme.dart';
import '../widgets/greek_ornaments.dart';
import '../widgets/interactive_3d_card.dart';

class TrialsScreen extends StatefulWidget {
  const TrialsScreen({super.key});

  @override
  State<TrialsScreen> createState() => _TrialsScreenState();
}

class _TrialsScreenState extends State<TrialsScreen> {
  int _activeQuestionIndex = 0;
  int? _selectedAnswerIndex;
  bool _isAnswerSubmitted = false;
  int _sessionScore = 0;

  final List<_TrialQuestion> _questions = const [
    _TrialQuestion(
      question:
          'Which Titan was condemned to hold up the celestial heavens for eternity after the Titanomachy?',
      options: ['Prometheus', 'Atlas', 'Epimetheus', 'Cronus'],
      correctIndex: 1,
      explanation:
          'Atlas led the Titans against the Olympians and was sentenced by Zeus to stand at the western edge of Gaia, bearing the celestial sphere upon his shoulders.',
      greekTopic: 'ΤΙΤΑΝΟΜΑΧΙΑ',
      xpReward: 50,
    ),
    _TrialQuestion(
      question:
          'What sacred plant was granted to Athens by Athena during her contest with Poseidon?',
      options: [
        'The Golden Apple of Hesperides',
        'The First Olive Tree',
        'The Sacred Laurel of Daphne',
        'The Cypress of Hades',
      ],
      correctIndex: 1,
      explanation:
          'Poseidon struck the rock producing a saltwater spring, but Athena planted the first olive tree, providing food, oil, and timber, securing the patronage of the polis.',
      greekTopic: 'ἈΘΗΝΑ ΚΑΙ ΠΟΣΕΙΔΩΝ',
      xpReward: 50,
    ),
    _TrialQuestion(
      question:
          'Who among the Argonauts could charm savage beasts, rocks, and trees with the music of his lyre?',
      options: ['Orpheus', 'Theseus', 'Castor', 'Heracles'],
      correctIndex: 0,
      explanation:
          'Orpheus of Thrace used his divine lyre to silence the enchanting song of the Sirens, ensuring safe passage for the Argo.',
      greekTopic: 'ΑΡΓΟΝΑΥΤΕΣ',
      xpReward: 50,
    ),
  ];

  Future<void> _submitAnswer() async {
    if (_selectedAnswerIndex == null) return;

    final currentQ = _questions[_activeQuestionIndex];
    final isCorrect = _selectedAnswerIndex == currentQ.correctIndex;

    setState(() {
      _isAnswerSubmitted = true;
      if (isCorrect) {
        _sessionScore += currentQ.xpReward;
      }
    });

    if (isCorrect) {
      await AuthService.instance.awardExperience(currentQ.xpReward);
    }
  }

  void _nextQuestion() {
    setState(() {
      _activeQuestionIndex = (_activeQuestionIndex + 1) % _questions.length;
      _selectedAnswerIndex = null;
      _isAnswerSubmitted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQ = _questions[_activeQuestionIndex];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
          children: [
            // Header
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ΔΕΛΦΙΚΟΙ ΑΓΩΝΕΣ • ARENA OF WISDOM',
                  style: GoogleFonts.cinzel(
                    fontSize: 11,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w700,
                    color: MythosColors.goldPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'TRIALS OF DELPHI',
                  style: GoogleFonts.cinzel(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                    color: MythosColors.marbleWhite,
                  ),
                ),
                Text(
                  'Test your mastery of classical lore, epics & philosophy',
                  style: MythosTypography.bodyMedium,
                ),
              ],
            ),

            const SizedBox(height: 14),
            const GreekMeanderBanner(height: 5, color: Color(0x33D4AF37)),
            const SizedBox(height: 18),

            // Live XP & Streak Header Card
            ValueListenableBuilder<UserProfile?>(
              valueListenable: AuthService.instance.currentUser,
              builder: (context, user, _) {
                final xp = user?.experiencePoints ?? (100 + _sessionScore);
                final streak = user?.streakDays ?? 1;

                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: MythosColors.cardSurface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: MythosColors.borderGoldMuted),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.bolt,
                              color: MythosColors.goldPrimary,
                              size: 20,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '$xp XP',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: MythosColors.marbleWhite,
                                      fontSize: 14,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Classical Lore',
                                    style: MythosTypography.bodyMedium.copyWith(
                                      fontSize: 10,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 28,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        color: MythosColors.borderGoldMuted,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.local_fire_department,
                              color: Color(0xFFF97316),
                              size: 20,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '$streak Day Streak',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: MythosColors.marbleWhite,
                                      fontSize: 14,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Prometheus Spark',
                                    style: MythosTypography.bodyMedium.copyWith(
                                      fontSize: 10,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // Question 3D Card
            Interactive3DCard(
              borderRadius: 22,
              glowColor: MythosColors.goldPrimary,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      MythosColors.cardSurfaceHighlight,
                      MythosColors.cardSurface,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          currentQ.greekTopic,
                          style: GoogleFonts.ebGaramond(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            color: MythosColors.goldPrimary,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: MythosColors.goldPrimary.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: MythosColors.goldPrimary.withValues(alpha: 0.4),
                            ),
                          ),
                          child: Text(
                            '+${currentQ.xpReward} XP',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: MythosColors.goldLight,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Trial ${_activeQuestionIndex + 1} of ${_questions.length}',
                      style: GoogleFonts.cinzel(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                        color: MythosColors.parchmentMuted,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      currentQ.question,
                      style: GoogleFonts.ebGaramond(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: MythosColors.marbleWhite,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Options
                    ...List.generate(currentQ.options.length, (idx) {
                      final opt = currentQ.options[idx];
                      final isSelected = _selectedAnswerIndex == idx;
                      final isCorrect = idx == currentQ.correctIndex;

                      Color bg = MythosColors.cardSurface;
                      Color border = MythosColors.borderGoldMuted;

                      if (_isAnswerSubmitted) {
                        if (isCorrect) {
                          bg = MythosColors.laurelGreen.withValues(alpha: 0.3);
                          border = MythosColors.laurelGlow;
                        } else if (isSelected) {
                          bg = Colors.red.withValues(alpha: 0.25);
                          border = Colors.redAccent;
                        }
                      } else if (isSelected) {
                        bg = MythosColors.goldPrimary.withValues(alpha: 0.2);
                        border = MythosColors.goldPrimary;
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: InkWell(
                          onTap: _isAnswerSubmitted
                              ? null
                              : () {
                                  setState(() {
                                    _selectedAnswerIndex = idx;
                                  });
                                },
                          borderRadius: BorderRadius.circular(14),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: bg,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: border, width: 1.4),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  '${String.fromCharCode(65 + idx)}. ',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: MythosColors.goldPrimary,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    opt,
                                    style: const TextStyle(
                                      color: MythosColors.marbleWhite,
                                      fontSize: 13.5,
                                    ),
                                  ),
                                ),
                                if (_isAnswerSubmitted && isCorrect)
                                  const Icon(
                                    Icons.check_circle_rounded,
                                    color: MythosColors.laurelGlow,
                                    size: 18,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 12),

                    // Actions
                    if (!_isAnswerSubmitted)
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MythosColors.goldPrimary,
                            foregroundColor: MythosColors.background,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                          ),
                          onPressed:
                              _selectedAnswerIndex != null ? _submitAnswer : null,
                          child: Text(
                            'Verify Oracle Answer',
                            style: GoogleFonts.cinzel(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      )
                    else ...[
                      // Explanation box
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _selectedAnswerIndex == currentQ.correctIndex
                              ? MythosColors.laurelGreen.withValues(alpha: 0.2)
                              : MythosColors.terracotta.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          currentQ.explanation,
                          style: MythosTypography.bodyMedium.copyWith(
                            color: MythosColors.parchmentText,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MythosColors.goldPrimary,
                            foregroundColor: MythosColors.background,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: _nextQuestion,
                          child: Text(
                            'Next Classical Trial',
                            style: GoogleFonts.cinzel(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
            const GreekColumnDivider(title: 'Hellas Leaderboard'),
            const SizedBox(height: 14),

            // Leaderboard list
            _buildLeaderboardTile('1', 'Odysseus of Ithaca', '4,850 XP', 'Athena'),
            _buildLeaderboardTile('2', 'Atalanta of Arcadia', '4,200 XP', 'Artemis'),
            _buildLeaderboardTile('3', 'Perseus of Mycenae', '3,950 XP', 'Zeus'),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaderboardTile(
    String rank,
    String name,
    String xp,
    String deity,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: MythosColors.cardSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MythosColors.borderGoldMuted),
      ),
      child: Row(
        children: [
          Container(
            width: 26,
            height: 26,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: MythosColors.goldPrimary.withValues(alpha: 0.2),
            ),
            child: Text(
              rank,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: MythosColors.goldLight,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: MythosColors.marbleWhite,
                    fontSize: 13,
                  ),
                ),
                Text(
                  'Patron: $deity',
                  style: MythosTypography.bodyMedium.copyWith(fontSize: 10.5),
                ),
              ],
            ),
          ),
          Text(
            xp,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: MythosColors.goldLight,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _TrialQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;
  final String greekTopic;
  final int xpReward;

  const _TrialQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
    required this.greekTopic,
    required this.xpReward,
  });
}
