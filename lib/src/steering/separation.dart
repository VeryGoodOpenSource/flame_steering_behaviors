import 'package:flame/extensions.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:steering_behaviors/steering_behaviors.dart';

/// {@template separation}
/// Separation steering algorithm.
/// {@endtemplate}
class Separation extends SteeringCore {
  /// {@macro separation}
  const Separation(
    this.entities, {
    required this.maxSepDist,
    required this.sepMaxAcceleration,
  });

  /// The maximum distance at which the entity will separate.
  final double maxSepDist;

  /// The maximum acceleration the entity can apply to enable separation.
  final double sepMaxAcceleration;

  /// The entities to separate from.
  final Iterable<Entity> entities;

  @override
  Vector2 getSteering(Steerable parent) {
    final acceleration = Vector2.zero();
    for (final entity in entities) {
      if (entity == parent) {
        continue;
      }
      final direction = entity.position - parent.position;
      final dist = direction.length;
      if (dist < maxSepDist) {
        final strength = sepMaxAcceleration *
            (maxSepDist - dist) /
            (maxSepDist - entity.size.x - parent.size.x);

        direction.normalize();
        acceleration.add(direction * strength);
      }
    }
    return acceleration;
  }
}
