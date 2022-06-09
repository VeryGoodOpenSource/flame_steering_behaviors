import 'package:flame/extensions.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:steering_behaviors/steering_behaviors.dart';

/// {@template flee_behavior}
/// Flee steering behavior.
/// {@endtemplate}
class FleeBehavior<Parent extends Steerable> extends SteeringBehavior<Parent> {
  /// {@macro flee_behavior}
  FleeBehavior(
    this.target, {
    required this.panicDist,
    required this.maxAcceleration,
    this.timeToTarget = 0.1,
    this.decelerateOnStop = true,
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
  void update(double dt) {
    steer(
      Flee(
        target,
        panicDist: panicDist,
        maxAcceleration: maxAcceleration,
        timeToTarget: timeToTarget,
        decelerateOnStop: decelerateOnStop,
      ),
      dt,
    );
  }

  @override
  void renderDebugMode(Canvas canvas) {
    canvas.drawCircle((parent.size / 2).toOffset(), panicDist, debugPaint);
    super.renderDebugMode(canvas);
  }
}
