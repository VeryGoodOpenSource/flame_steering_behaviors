import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:steering_behaviors/steering_behaviors.dart';

/// {@template pursue_behavior}
/// Pursue steering behavior.
/// {@endtemplate}
class PursueBehavior<Parent extends Steerable>
    extends SteeringBehavior<Parent> {
  /// {@macro pursue_behavior}
  PursueBehavior(
    this.target, {
    required this.minimumPursueRange,
    required this.maximumPursueRange,
    this.maxPrediction = 1,
  });

  /// The target to pursue.
  final Entity target;

  /// The maximum prediction time.
  final double maxPrediction;

  /// The maximum range in which the goblin will pursue the player.
  final double maximumPursueRange;

  /// The minimum range in which the goblin will pursue the player.
  final double minimumPursueRange;

  @override
  void update(double dt) {
    final distanceToTarget = target.distance(parent);

    if (distanceToTarget > minimumPursueRange &&
        distanceToTarget < maximumPursueRange) {
      steer(Pursue(target, maxPrediction: maxPrediction), dt);
    }
  }

  @override
  void renderDebugMode(Canvas canvas) {
    canvas.drawCircle(
      (parent.size / 2).toOffset(),
      maximumPursueRange,
      debugPaint,
    );
    super.renderDebugMode(canvas);
  }
}
