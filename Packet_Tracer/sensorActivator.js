function setup() {
  var windSensorPin = 2;
  var soundSensorPin = 4;
  var temperatureSensorPin = 0;
  var waterSensorPin = 1;
  var humiditySensorPin = 3;

  digitalWrite(windSensorPin, HIGH);
  digitalWrite(soundSensorPin, HIGH);
  digitalWrite(temperatureSensorPin, HIGH);
  digitalWrite(waterSensorPin, HIGH);
  digitalWrite(humiditySensorPin, HIGH);
}
