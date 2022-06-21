import 'package:example/entities/entities.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

const relativeValue = 16.0;

class ExampleGame extends FlameGame with HasCollisionDetection {
  @override
  Future<void> onLoad() async {
    await add(FpsTextComponent(position: Vector2.zero()));
    await add(ScreenHitbox());

    await addAll([
      for (var i = 0; i < 100; i++)
        Dot(position: Vector2.random()..multiply(size)),
    ]);
  }
}

void main() {
  runApp(GameWidget(game: ExampleGame()));
}
