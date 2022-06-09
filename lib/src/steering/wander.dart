import 'dart:math';

import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:steering_behaviors/steering_behaviors.dart';

/// {@template wander}
/// Wander steering algorithm.
///
/// The [onNewAngle] should be used to get the [angle] value for the next
/// [Wander] creation.
/// {@endtemplate}
class Wander extends SteeringCore {
  /// {@macro wander}
  Wander({
    required this.circleDistance,
    required this.maximumAngle,
    required this.angle,
    required this.onNewAngle,
  });

  /// The distance to the circle center of the next target.
  final double circleDistance;

  /// The maximum angle used to calculate the next wander [angle].
  ///
  /// Value is represented in radians.
  final double maximumAngle;

  /// The current wander angle in radians.
  final double angle;

  /// Called when the next [angle] value is calculated.
  ///
  /// The next call to [Wander] expects the angle to be this value.
  final ValueChanged<double> onNewAngle;

  /// Used in tests to allow for testing the angle.
  @visibleForTesting
  Random? testRandom;
  Random get _random => testRandom ?? Random();

  @override
  Vector2 getSteering(Steerable parent) {
    // Calculate the circle center for the next target that is right in front
    // of the parent.
    final circleCenter = parent.velocity.normalized()..scale(circleDistance);

    // Calculate the displacement needed for displacing the circle center.
    final displacement = Vector2(0, -1)
      ..scale(circleDistance)
      ..setAngle(angle);

    // Randomly pick a new angle based on the maximum angle and expose it.
    onNewAngle(
      angle + _random.nextDouble() * maximumAngle - maximumAngle * 0.5,
    );

    // Calculate the next target position by displacing the circle center.
    return circleCenter.clone()..add(displacement);
  }
}

extension on Vector2 {
  void setAngle(double radians) {
    final len = length;
    x = cos(radians) * len;
    y = sin(radians) * len;
  }
}