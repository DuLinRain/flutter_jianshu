import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class HomeScrollDirectionEvent {
  String scrollDirection;

  HomeScrollDirectionEvent(String scrollDirection) {
    this.scrollDirection = scrollDirection;
  }
}