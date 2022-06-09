import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:steering_behaviors/steering_behaviors.dart';

abstract class SteeringBehavior<Parent extends Steerable>
    extends Behavior<Parent> with Steering {}
