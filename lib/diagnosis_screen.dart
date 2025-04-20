// diagnosis_screen.dart
/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'diagnosis_logic.dart';

class DiagnosisScreen extends StatefulWidget {
  const DiagnosisScreen({super.key});

  @override
  State<DiagnosisScreen> createState() => _DiagnosisScreenState();
}

class _DiagnosisScreenState extends State<DiagnosisScreen> {
  final CarDiagnosis _diagnosisSystem = CarDiagnosis();
  String _diagnosisMessage = '';
  bool _showDiagnosis = false;
  bool _showQuestion = true;

  void _handleAnswer(String answer) {
    setState(() {
      _showQuestion = false;
      final result = _diagnosisSystem.updateDiagnosis(answer);
      
      if (result.isEmpty) {
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            _showQuestion = true;
          });
        });
      } else {
        _diagnosisMessage = result;
        _showDiagnosis = true;
      }
    });
  }

  Widget _buildQuestion() {
    return AnimatedOpacity(
      opacity: _showQuestion ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _diagnosisSystem.getCurrentQuestion(),
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
              fontSize: 26,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: _diagnosisSystem.getCurrentOptions().map((option) {
              return ElevatedButton(
                onPressed: () => _handleAnswer(option),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC0A062),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32, vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  elevation: 4,
                ),
                child: Text(
                  option,
                  style: GoogleFonts.raleway(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.1,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDiagnosis() {
    return AnimatedOpacity(
      opacity: _showDiagnosis ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFC0A062).withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFC0A062).withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Diagnosis Complete',
              style: GoogleFonts.playfairDisplay(
                fontSize: 24,
                color: const Color(0xFFC0A062),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _diagnosisMessage,
              textAlign: TextAlign.center,
              style: GoogleFonts.raleway(
                fontSize: 18,
                color: Colors.white.withOpacity(0.9),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _diagnosisSystem.reset();
                  _showDiagnosis = false;
                  _showQuestion = true;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E003E),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: Text(
                'Start New Diagnosis',
                style: GoogleFonts.raleway(
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0D0D0D),
              Color(0xFF1A1A1A),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: _showDiagnosis ? _buildDiagnosis() : _buildQuestion(),
              ),
              const SizedBox(height: 40),
              if (!_showDiagnosis)
                AnimatedOpacity(
                  opacity: _showQuestion ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    'Tap your response',
                    style: GoogleFonts.raleway(
                      color: Colors.white54,
                      fontSize: 14,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}*/import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'diagnosis_logic.dart';

class DiagnosisScreen extends StatefulWidget {
  const DiagnosisScreen({super.key});

  @override
  State<DiagnosisScreen> createState() => _DiagnosisScreenState();
}

class _DiagnosisScreenState extends State<DiagnosisScreen> {
  final CarDiagnosis _diagnosisSystem = CarDiagnosis();
  String _diagnosisMessage = '';
  bool _showDiagnosis = false;
  bool _showQuestion = true;

  Widget _buildBackgroundImage() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/rolls.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.4),
            BlendMode.darken,
          ),
        ),
      ),
      
    );
  }

  void _handleAnswer(String answer) {
    setState(() {
      _showQuestion = false;
      final result = _diagnosisSystem.updateDiagnosis(answer);
      
      if (result.isEmpty) {
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() => _showQuestion = true);
        });
      } else {
        _diagnosisMessage = result;
        _showDiagnosis = true;
      }
    });
  }
 PreferredSizeWidget _buildPremiumAppBar() {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 4,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => Navigator.pop(context),
          child: CircleAvatar(
          
            radius: 20,
            child: ClipOval(
              child: Image.asset(
                'assets/spirit2.jpg', // your logo asset
                fit: BoxFit.cover,
                width: 36,
                height: 36,
              ),
            ),
          ),
        ),
      ),
    ),
    title: Text(
      'Ghost Diagnostics',
      style: GoogleFonts.playfairDisplay(
        fontSize: 22,
        color: const Color(0xFFC0A062),
        letterSpacing: 1.5,
      ),
    ),
    centerTitle: true,
  );
}

  Widget _buildDiagnosis() {
    return AnimatedOpacity(
      opacity: _showDiagnosis ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFC0A062).withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFC0A062).withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Diagnosis Complete',
              style: GoogleFonts.playfairDisplay(
                fontSize: 24,
                color: const Color(0xFFC0A062),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _diagnosisMessage,
              textAlign: TextAlign.center,
              style: GoogleFonts.raleway(
                fontSize: 18,
                color: Colors.white.withOpacity(0.9),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _diagnosisSystem.reset();
                  _showDiagnosis = false;
                  _showQuestion = true;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E003E),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: Text(
                'Start New Diagnosis',
                style: GoogleFonts.raleway(
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }Widget _buildQuestion() {
  return AnimatedOpacity(
    opacity: _showQuestion ? 1.0 : 0.0,
    duration: const Duration(milliseconds: 500),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _diagnosisSystem.getCurrentQuestion(),
          textAlign: TextAlign.center,
          style: GoogleFonts.playfairDisplay(
            fontSize: 26,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 40),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          alignment: WrapAlignment.center,
          children: _diagnosisSystem.getCurrentOptions().map((option) {
            return ElevatedButton(
              onPressed: () => _handleAnswer(option),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC0A062),
                foregroundColor: Colors.black, // Explicit text color
                padding: const EdgeInsets.symmetric(
                  horizontal: 32, vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                elevation: 4,
              ),
              child: Text(
                option,
                style: GoogleFonts.raleway(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.1,
                  color: Colors.black, // Double ensure text color
                ),
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}
  // Keep the rest of your existing code (buildQuestion, buildDiagnosis, etc.)
  // ... [Rest of your existing UI code remains unchanged]
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      appBar: _buildPremiumAppBar(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D0D0D), Color(0xFF1A1A1A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: _buildBackgroundImage(),
              ),
              Expanded(
                flex: 1,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: _showDiagnosis ? _buildDiagnosis() : _buildQuestion(),
                ),
              ),
              if (!_showDiagnosis)
                AnimatedOpacity(
                  opacity: _showQuestion ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      'Tap your response',
                      style: GoogleFonts.raleway(
                        color: Colors.white54,
                        fontSize: 14,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}