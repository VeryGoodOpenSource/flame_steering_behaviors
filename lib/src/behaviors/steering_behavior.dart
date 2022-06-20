import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:steering_behaviors/steering_behaviors.dart';

/// {@template steering_behavior}
/// Abstract base class for steering behaviors.
/// {@endtemplate}
abstract class SteeringBehavior<Parent extends Steerable>
    extends Behavior<Parent> with Steering {}
