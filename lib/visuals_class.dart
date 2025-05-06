// Add this class to manage visual states
class CarVisualState {
  final String cameraTarget;
  final String cameraOrbit;
  final String? highlightPart;
  final bool interiorView;

  const CarVisualState({
    required this.cameraTarget,
    required this.cameraOrbit,
    this.highlightPart,
    this.interiorView = false,
  });
}

// Map questions to visual states
final Map<int, CarVisualState> _stateVisuals = {
  0: const CarVisualState( // Starting question
    cameraTarget: '0m 0m 0m',
    cameraOrbit: '0deg 75deg 2.5m',
  ),
  1: const CarVisualState( // Headlights
    cameraTarget: '0m 0.5m 1.5m',
    cameraOrbit: '0deg 65deg 1.8m',
    highlightPart: 'headlights',
  ),
  5: const CarVisualState( // Dashboard
    cameraTarget: '0m 0.5m -0.5m',
    cameraOrbit: '0deg 15deg 1m',
    interiorView: true,
  ),
  6: const CarVisualState( // Wheels general
    cameraTarget: '0m 0m 0m',
    cameraOrbit: '90deg 75deg 2m',
  ),
  7: const CarVisualState( // Tyres
    cameraTarget: '1m 0.3m 0m',
    cameraOrbit: '90deg 75deg 1.5m',
    highlightPart: 'tyres',
  ),
  19: const CarVisualState( // Undercarriage
    cameraTarget: '0m -0.5m 0m',
    cameraOrbit: '180deg 90deg 1.5m',
  ),
  // Add mappings for all other states
};