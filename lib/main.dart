import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'diagnosis_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rolls-Royce Diagnosis',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0D0D0D), // Dark background
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFC0A062), // Rolls-Royce gold accent
          secondary: Color(0xFF2E003E), // Rolls-Royce purple
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  late final Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _colorAnimation = ColorTween(
      begin: const Color(0xFFC0A062).withOpacity(0.7),
      end: const Color(0xFFC0A062),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToNextScreen() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const DiagnosisScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 1000),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.transparent,
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Breathing image animation with gold border
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Container(
                    padding: const EdgeInsets.all(4), // Border width
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          _colorAnimation.value!,
                          _colorAnimation.value!.withOpacity(0.1),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: _colorAnimation.value!.withOpacity(0.5),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ScaleTransition(
                      scale: _animation,
                      child: Material(
                        elevation: 20,
                        shape: const CircleBorder(),
                        clipBehavior: Clip.antiAlias,
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _navigateToNextScreen,
                          child: Ink.image(
                            image: const AssetImage('assets/spirit2.jpg'),
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),

              // Rolls-Royce inspired title
              Text(
                'SPIRIT OF ECSTASY',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFC0A062), // Rolls-Royce gold
                  letterSpacing: 4.0,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 8),
              
              // Thin divider line
              Container(
                width: 100,
                height: 1,
                color: const Color(0xFFC0A062).withOpacity(0.5),
                margin: const EdgeInsets.symmetric(vertical: 10),
              ),
              const SizedBox(height: 20),

              // Animated Subtitle with improved styling
              SizedBox(
                height: 60,
                child: DefaultTextStyle(
                  style: GoogleFonts.raleway(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w300,
                    color: Colors.white.withOpacity(0.9),
                    letterSpacing: 1.5,
                    height: 1.5,
                  ),
                  child: AnimatedTextKit(
                    repeatForever: true,
                    pause: const Duration(milliseconds: 1000),
                    animatedTexts: [
                      FadeAnimatedText(
                        "Your automotive companion",
                        textAlign: TextAlign.center,
                        duration: const Duration(milliseconds: 1500),
                      ),
                      FadeAnimatedText(
                        "Diagnosing with precision",
                        textAlign: TextAlign.center,
                        duration: const Duration(milliseconds: 1500),
                      ),
                      FadeAnimatedText(
                        "Elevating your driving experience",
                        textAlign: TextAlign.center,
                        duration: const Duration(milliseconds: 1500),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Subtle "Tap to continue" hint
              AnimatedOpacity(
                opacity: 0.7,
                duration: const Duration(seconds: 2),
                child: Text(
                  'Tap the Spirit to begin',
                  style: GoogleFonts.raleway(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w300,
                    color: Colors.white.withOpacity(0.7),
                    letterSpacing: 1.0,
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