class CarDiagnosis {
  String _diagnosisResult = '';
  final List<String> _answers = [];
  int _state = 0;
  int _questionCount = 0;

  int _accessoryIssueCount = 0;

  /// Returns the next question based on current state
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
      case 15: return 'Does the brake pedal feel soft or spongy?';
      case 16: return 'Are the brakes responding late?';
      case 17: return 'Is the steering wheel hard to turn?';
      case 18: return 'Do you hear clicking sounds while turning?';
      case 19: return 'Is there any fluid leakage under the car?';
      default: return 'Diagnosis complete!';
    }
  }

  /// Returns options for current question
  List<String> getCurrentOptions() => ['Yes', 'No'];

  /// Updates state and determines diagnosis if possible
  String updateDiagnosis(String answer) {
    _answers.add(answer);
    _questionCount++;

    // Auto-stop after 8 questions
    if (_questionCount > 8) {
      _diagnosisResult = 'Diagnosis inconclusive. Please consult a mechanic for further checks.';
      _state = 999;
      return _diagnosisResult;
    }

    switch (_state) {
      case 0:
        if (answer == 'No') {
          _state = 1; // Start electrical/accessory checks
        } else {
          _state = 6; // Jump to mechanical path
        }
        break;

      case 1:
        if (answer == 'No') _accessoryIssueCount++;
        _state = 2;
        break;

      case 2:
        if (answer == 'No') _accessoryIssueCount++;
        _state = 3;
        break;

      case 3:
        if (answer == 'No') _accessoryIssueCount++;
        _state = 4;
        break;

      case 4:
        if (answer == 'No') _accessoryIssueCount++;
        _state = 5;
        break;

      case 5:
        if (_accessoryIssueCount >= 3) {
          _diagnosisResult = 'Battery or hardware issue detected. Please try jump starting the car or check battery terminals.';
        } else {
          _diagnosisResult = 'Minor accessory glitch. Battery seems okay.';
        }
        _state = 999;
        break;

      case 6:
        if (answer == 'Yes') {
          _state = 7;
        } else {
          _state = 10;
        }
        break;

      case 7:
        if (answer == 'Yes') {
          _state = 9;
        } else {
          _state = 8;
        }
        break;

      case 8:
        if (answer == 'Yes') {
          _diagnosisResult = 'Possible axle or suspension issue. Please inspect the axle.';
        } else {
          _diagnosisResult = 'No serious mechanical issue detected.';
        }
        _state = 999;
        break;

      case 9:
        if (answer == 'Yes') {
          _diagnosisResult = 'Tyre puncture or misalignment detected. Please inspect tyres.';
        } else {
          _diagnosisResult = 'Wobbling may be due to suspension imbalance.';
        }
        _state = 999;
        break;

      case 10:
        if (answer == 'Yes') {
          _state = 11;
        } else {
          _diagnosisResult = 'No light issues detected.';
          _state = 999;
        }
        break;

      case 11:
        if (answer == 'No') {
          _diagnosisResult = 'Adjust the brightness of the headlights.';
        } else {
          _state = 12;
        }
        break;

      case 12:
        if (answer == 'No') {
          _diagnosisResult = 'AC failure. Might be a fuse or compressor issue.';
        } else {
          _state = 13;
        }
        break;

      case 13:
        if (answer == 'Yes') {
          _diagnosisResult = 'Fuel/exhaust issue. May need immediate inspection.';
        } else {
          _state = 14;
        }
        break;

      case 14:
        if (answer == 'Yes') {
          _diagnosisResult = 'High fuel usage. Possibly due to clogged injectors or air filters.';
        } else {
          _state = 15;
        }
        break;

      case 15:
        if (answer == 'Yes') {
          _diagnosisResult = 'Brake fluid leak or worn brake pads.';
        } else {
          _state = 16;
        }
        break;

      case 16:
        if (answer == 'Yes') {
          _diagnosisResult = 'Brakes responding late. Could be a hydraulic issue.';
        } else {
          _state = 17;
        }
        break;

      case 17:
        if (answer == 'Yes') {
          _diagnosisResult = 'Steering pump failure. Needs checking.';
        } else {
          _state = 18;
        }
        break;

      case 18:
        if (answer == 'Yes') {
          _diagnosisResult = 'CV joint failure. Needs servicing.';
        } else {
          _state = 19;
        }
        break;

      case 19:
        if (answer == 'Yes') {
          _diagnosisResult = 'Oil/coolant leak detected. Get it checked soon.';
        } else {
          _diagnosisResult = 'No major issue found.';
        }
        _state = 999;
        break;
    }

    return _diagnosisResult;
  }

  /// Whether the diagnosis is done
  bool isDiagnosisComplete() => _state == 999;

  /// Reset the diagnosis session
  void reset() {
    _answers.clear();
    _diagnosisResult = '';
    _state = 0;
    _questionCount = 0;
    _accessoryIssueCount = 0;
  }
}
