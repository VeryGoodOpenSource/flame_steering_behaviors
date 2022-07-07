import 'package:flame/extensions.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_steering_behaviors/flame_steering_behaviors.dart';

/// {@template flee}
/// Flee steering algorithm.
/// {@endtemplate}
class Flee extends SteeringCore {
  /// {@macro flee}
  const Flee(
    this.target, {
    required this.maxAcceleration,
  });

  /// The target to flee from.
  final Entity target;

  /// The maximum acceleration of the entity.
  final double maxAcceleration;

  @override
  Vector2 getSteering(Steerable parent) {
    final desiredVelocity = (parent.position - target.position)
      ..normalize()
      ..scale(parent.maxVelocity);

    final steering = desiredVelocity - parent.velocity;
    if (steering.length > maxAcceleration) {
      steering.setFrom(steering.normalized() * maxAcceleration);
    }

    return steering;
  }
}
