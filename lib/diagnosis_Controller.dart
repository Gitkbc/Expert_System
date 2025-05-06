
class DiagnosisState {
  final int state;
  final bool isComplete;
  final String diagnosisMessage;
  final String cameraTarget;
  final String cameraOrbit;

  DiagnosisState({
    required this.state,
    required this.isComplete,
    required this.diagnosisMessage,
    required this.cameraTarget,
    required this.cameraOrbit,
  });

  DiagnosisState copyWith({
    int? state,
    bool? isComplete,
    String? diagnosisMessage,
    String? cameraTarget,
    String? cameraOrbit,
  }) {
    return DiagnosisState(
      state: state ?? this.state,
      isComplete: isComplete ?? this.isComplete,
      diagnosisMessage: diagnosisMessage ?? this.diagnosisMessage,
      cameraTarget: cameraTarget ?? this.cameraTarget,
      cameraOrbit: cameraOrbit ?? this.cameraOrbit,
    );
  }
}
