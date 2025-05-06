import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'diagnosis_logic.dart';
import 'main.dart';
import 'package:audioplayers/audioplayers.dart';
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
  bool _hasStartedDiagnosis = false;
  final FlutterTts flutterTts = FlutterTts();
  final AudioPlayer _audioPlayer = AudioPlayer(); // AudioPlayer instance

  late int cameraPositionDeg = 0;

  @override
  void initState() {
    super.initState();
    _startCameraMovement();
    _playTune();
  }
@override
  void dispose() {
    _audioPlayer.dispose(); // Dispose of the audio player
    super.dispose();
  }

  void _playTune() async {
    await _audioPlayer.setReleaseMode(ReleaseMode.loop); // Loop the tune
   await _audioPlayer.play(AssetSource('Cheri, Cheri Lady (Instrumental).mp3'));
   print("Trying to play tune");

 // Play the tune
  }

  void _stopTune() async {
    await _audioPlayer.stop(); // Stop the tune
  }
  void _speakQuestion() async {
    String question = _diagnosisSystem.getCurrentQuestion();
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(question);
  }

  // Method to control camera movement between different positions
  void _startCameraMovement() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        cameraPositionDeg = 90;
      });
    });

    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        cameraPositionDeg = 50;
      });
    });
  }

  void _updateCameraAngle(String question) {
    setState(() {
      if (question.contains('tyre') || question.contains('tire')) {
        cameraPositionDeg = 30; // Adjust angle for tire-related questions
      } else if (question.contains('engine')) {
        cameraPositionDeg = 90; // Adjust angle for engine-related questions
      } else if (question.contains('lights') || question.contains('headlights')) {
        cameraPositionDeg = 60; // Adjust angle for light-related questions
      } else if (question.contains('brake')) {
        cameraPositionDeg = 45; // Adjust angle for brake-related questions
      } else {
        cameraPositionDeg = 50; // Default angle for other questions
      }
    });
  }

  Widget _build3DModel() {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.85, // Increased size for a larger model
          child: ModelViewer(
            src: 'https://cdn.tinyglb.com/models/8e1bd5248a3740a3a3825caf58e837f1.glb', // URL of the GLB model
            alt: "A 3D model of a Rolls-Royce Ghost",
            ar: true,
            autoRotate: true,
            cameraControls: true,
            cameraOrbit: '5deg $cameraPositionDeg deg 0.5m', // Dynamic camera position based on variable
            cameraTarget: '0m 0m 0m',
            backgroundColor: Colors.transparent,
            // Removed the onLoading parameter as it is not defined
          ),
        ),
       
      ],
    );
  }

  void _handleAnswer(String answer) {
    setState(() {
      _showQuestion = false;
      final result = _diagnosisSystem.updateDiagnosis(answer);

      if (result.isEmpty) {
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() => _showQuestion = true);
          String nextQuestion = _diagnosisSystem.getCurrentQuestion();
          _updateCameraAngle(nextQuestion); // Update camera angle based on the next question
          _speakQuestion();
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
            onTap: () {
              // Navigate to the SplashScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SplashScreen()),
              );
            },
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

  Widget _buildStartButton() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Tap to Start Your Diagnosis",
            style: GoogleFonts.playfairDisplay(
              fontSize: 26,
              color: const Color(0xFFC0A062),
              fontWeight: FontWeight.w500,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _hasStartedDiagnosis = true;
                _stopTune(); // Stop the tune when the button is tapped
                _speakQuestion(); // Speak the question only after tapping the button
                _startCameraMovement();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC0A062),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              elevation: 6,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.play_arrow, color: Colors.black),
                const SizedBox(width: 10),
                Text(
                  'Start Diagnosis',
                  style: GoogleFonts.raleway(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
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
                  foregroundColor: Colors.black, // Explicit text color
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
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
                child: _build3DModel(),
              ),
              Expanded(
                flex: 1,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: _showDiagnosis
                      ? _buildDiagnosis()
                      : _hasStartedDiagnosis
                          ? _buildQuestion()
                          : _buildStartButton(),
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
