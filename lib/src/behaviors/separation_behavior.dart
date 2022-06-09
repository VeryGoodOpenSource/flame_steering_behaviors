import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:steering_behaviors/steering_behaviors.dart';

/// {@template separation_behavior}
/// Separation steering behavior.
/// {@endtemplate}
class SeparationBehavior<Parent extends Steerable>
    extends SteeringBehavior<Parent> {
  /// {@macro separation_behavior}
  SeparationBehavior(
    this.entities, {
    required this.maxSepDist,
    required this.sepMaxAcceleration,
  });

  /// The maximum distance at which the entity will separate.
  final double maxSepDist;

  /// The entities to separate from.
  final double sepMaxAcceleration;

  /// The entities to separate from.
  final List<Entity> entities;

  @override
  void update(double dt) {
    steer(
      Separation(
        entities,
        maxSepDist: maxSepDist,
        sepMaxAcceleration: sepMaxAcceleration,
      ),
      dt,
    );
  }
}
