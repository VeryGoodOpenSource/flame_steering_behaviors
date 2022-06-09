import 'package:steering_behaviors/steering_behaviors.dart';

/// {@template wander_behavior}
/// Wander steering behavior.
/// {@endtemplate}
class WanderBehavior<Parent extends Steerable>
    extends SteeringBehavior<Parent> {
  /// {@macro wander_behavior}
  WanderBehavior({
    required this.circleDistance,
    required this.maximumAngle,
    required double startingAngle,
  }) : _angle = startingAngle;

  /// The distance to the circle center of the next target.
  final double circleDistance;

  /// The rate at which the wander angle can change in radians.
  final double maximumAngle;

  /// The current wander angle in radians.
  double get angle => _angle;
  double _angle;

  @override
  void update(double dt) {
    steer(
      Wander(
        circleDistance: circleDistance,
        maximumAngle: maximumAngle,
        angle: _angle,
        onNewAngle: (angle) => _angle = angle,
      ),
      dt,
    );
  }
}
