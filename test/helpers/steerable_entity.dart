import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:steering_behaviors/steering_behaviors.dart';

class SteerableEntity extends Entity with Steerable {
  SteerableEntity({
    super.position,
    super.behaviors,
    super.size,
  });

  @override
  double get maxVelocity => 100;
}
