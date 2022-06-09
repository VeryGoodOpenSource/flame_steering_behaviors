import 'package:flame/extensions.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:steering_behaviors/steering_behaviors.dart';

// https://github.com/sturdyspoon/unity-movement-ai/blob/master/Assets/UnityMovementAI/Scripts/Units/Movement/Flee.cs
/// {@template flee}
/// Flee steering algorithm.
/// {@endtemplate}
class Flee extends SteeringCore {
  /// {@macro flee}
  const Flee(
    this.target, {
    required this.panicDist,
    required this.decelerateOnStop,
    required this.maxAcceleration,
    required this.timeToTarget,
  });

  /// The target to flee from.
  final Entity target;

  /// The distance at which the entity will panic.
  final double panicDist;

  /// Whether the entity should decelerate when it is stopped.
  final bool decelerateOnStop;

  /// The maximum acceleration of the entity.
  final double maxAcceleration;

  /// The time it takes to reach the target.
  final double timeToTarget;

  @override
  Vector2 getSteering(Steerable parent) {
    final acceleration = parent.position - target.position;
    final dist = acceleration.length;
    // If the target is far away, then don't flee.
    if (dist > panicDist) {
      // Slow down if we should decelerate on stop.
      if (decelerateOnStop && parent.velocity.length > 2) {
        // Decelerate to zero velocity in time to target amount of time.
        acceleration.setFrom(-parent.velocity / timeToTarget);

        if (dist > maxAcceleration) {
          acceleration
            ..normalize()
            ..scale(maxAcceleration);
        }
        return acceleration;
      } else {
        parent.velocity.setZero();
        return Vector2.zero();
      }
    }

    return acceleration
      ..normalize()
      ..scale(maxAcceleration);
  }
}
