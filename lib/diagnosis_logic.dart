class CarDiagnosis {
  String _diagnosisResult = '';
  final List<String> _answers = [];
  int _state = 0;
  int _questionCount = 0;
  int _accessoryIssueCount = 0;

  int getCurrentState() => _state;

  String getCurrentQuestion() {
    switch (_state) {
      case 0: return 'Is the car starting when you turn the key?';
      case 1: return 'Are the headlights or tail lights turning on?';
      case 2: return 'Is the infotainment system working?';
      case 3: return 'Is the massage function on the seat working?';
      case 4: return 'Is the seat elevation responding?';
      case 5: return 'Are there any warning lights on the dashboard?';
      case 6: return 'Is the car wobbling while driving?';
      case 7: return 'Is there any shape change in the tyre?';
      case 8: return 'Is there any sound coming from under the car?';
      case 9: return 'Is the car pulling to one side?';
      case 10: return 'Are the lights very dim?';
      case 11: return 'Is the brightness level full?';
      case 12: return 'Is the AC working?';
      case 13: return 'Is there any smell near the exhaust?';
      case 14: return 'Is the fuel consumption very high?';
      case 15: return 'Does the brake pedal feel soft or spongy/unable to feel the brake tension ?';
      case 16: return 'Are the brakes responding late?';
      case 17: return 'Is the steering wheel hard to turn?';
      case 18: return 'Do you hear clicking sounds while turning?';
      case 19: return 'Is there any fluid leakage under the car?';
      case 20: return 'Is the engine overheating after short drives?';
      case 21: return 'Does the engine crank slowly or not at all?';
      case 22: return 'Does the car shake while idling?';
      case 23: return 'Is there a delay in gear shifting?';
      case 24: return 'Does the check engine light stay on?';
      case 25: return 'Do you smell fuel inside the car?';
      case 26: return 'Is the car stalling unexpectedly?';
      case 27: return 'Does the car vibrate when braking?';
      case 28: return 'Do the windows roll up/down smoothly?';
      case 29: return 'Is there rust around the door or underbody?';
      default: return 'Diagnosis complete!';
    }
  }

  List<String> getCurrentOptions() => ['Yes', 'No'];

  String updateDiagnosis(String answer) {
    _answers.add(answer);
    _questionCount++;

    if (_questionCount >= 30) {
      _diagnosisResult = 'Diagnosis inconclusive after multiple checks. Please consult a mechanic.';
      _state = 999;
      return _diagnosisResult;
    }

    switch (_state) {
      case 0:
        _state = (answer == 'No') ? 1 : 6;
        break;

      case 1:
      case 2:
      case 3:
      case 4:
        if (answer == 'No') _accessoryIssueCount++;
        _state++;
        break;

      case 5:
        if (_accessoryIssueCount >= 3) {
          _finalizeDiagnosis('Battery or major electrical issue. Try jump-starting or check terminals.');
        } else {
          _finalizeDiagnosis('Minor accessory issue. Battery seems okay.');
        }
        break;

      case 6:
        _state = answer == 'Yes' ? 7 : 10;
        break;

      case 7:
        _state = answer == 'Yes' ? 9 : 8;
        break;

      case 8:
        _finalizeDiagnosis(answer == 'Yes'
            ? 'Possible axle or suspension problem. Inspect suspension or underbody.'
            : 'No critical issue under the car detected.');
        break;

      case 9:
        _finalizeDiagnosis(answer == 'Yes'
            ? 'Tyre alignment or suspension issue.'
            : 'Mild wobble may be due to imbalance.');
        break;

      case 10:
        _state = answer == 'Yes' ? 11 : 12;
        break;

      case 11:
        if (answer == 'No') {
          _finalizeDiagnosis('Check headlight brightness settings.');
        } else {
          _state = 12;
        }
        break;

      case 12:
        if (answer == 'No') {
          _finalizeDiagnosis('AC issue. Could be fuse or compressor failure.');
        } else {
          _state = 13;
        }
        break;

      case 13:
        if (answer == 'Yes') {
          _finalizeDiagnosis('Unusual exhaust smell. Check for leaks or fuel system issues.');
        } else {
          _state = 14;
        }
        break;

      case 14:
        if (answer == 'Yes') {
          _finalizeDiagnosis('High fuel consumption. Likely clogged air filter or injector issues.');
        } else {
          _state = 15;
        }
        break;

      case 15:
        if (answer == 'Yes') {
          _finalizeDiagnosis('Brake fluid leakage or pad wear.');
        } else {
          _state = 16;
        }
        break;

      case 16:
        if (answer == 'Yes') {
          _finalizeDiagnosis('Brakes responding late. Check hydraulic system.');
        } else {
          _state = 17;
        }
        break;

      case 17:
        if (answer == 'Yes') {
          _finalizeDiagnosis('Steering issue. Possible pump or fluid problem.');
        } else {
          _state = 18;
        }
        break;

      case 18:
        if (answer == 'Yes') {
          _finalizeDiagnosis('Clicking while turning: CV joint problem.');
        } else {
          _state = 19;
        }
        break;

      case 19:
        if (answer == 'Yes') {
          _finalizeDiagnosis('Leak detected. Check coolant, oil or brake fluid.');
        } else {
          _state = 20;
        }
        break;

      case 20:
        if (answer == 'Yes') {
          _finalizeDiagnosis('Overheating engine. Inspect coolant, fan, or thermostat.');
        } else {
          _state = 21;
        }
        break;

      case 21:
        if (answer == 'Yes') {
          _finalizeDiagnosis('Battery or starter motor problem.');
        } else {
          _state = 22;
        }
        break;

      case 22:
        if (answer == 'Yes') {
          _finalizeDiagnosis('Shaking when idling. Possible misfire or engine mount issue.');
        } else {
          _state = 23;
        }
        break;

      case 23:
        if (answer == 'Yes') {
          _finalizeDiagnosis('Delayed gear shift. Check transmission fluid.');
        } else {
          _state = 24;
        }
        break;

      case 24:
        if (answer == 'Yes') {
          _finalizeDiagnosis('Check engine light on. Use an OBD-II scanner.');
        } else {
          _state = 25;
        }
        break;

      case 25:
        if (answer == 'Yes') {
          _finalizeDiagnosis('Fuel smell detected. Possible fuel leak. Dangerous!');
        } else {
          _state = 26;
        }
        break;

      case 26:
        if (answer == 'Yes') {
          _finalizeDiagnosis('Stalling issue. May be due to fuel pump or idle control valve.');
        } else {
          _state = 27;
        }
        break;

      case 27:
        if (answer == 'Yes') {
          _finalizeDiagnosis('Vibrating while braking: rotor or pad issue.');
        } else {
          _state = 28;
        }
        break;

      case 28:
        if (answer == 'No') {
          _finalizeDiagnosis('Power window issue. Likely motor or regulator fault.');
        } else {
          _state = 29;
        }
        break;

      case 29:
        _finalizeDiagnosis(answer == 'Yes'
            ? 'Rust detected. Treat to prevent further damage.'
            : 'No major issues found. Car seems to be in good condition.');
        break;
    }

    return _diagnosisResult;
  }

  void _finalizeDiagnosis(String result) {
    _diagnosisResult = result;
    _state = 999;
  }

  bool isDiagnosisComplete() => _state == 999;

  void reset() {
    _answers.clear();
    _diagnosisResult = '';
    _state = 0;
    _questionCount = 0;
    _accessoryIssueCount = 0;
  }
}
