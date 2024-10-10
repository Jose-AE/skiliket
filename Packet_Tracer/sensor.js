function setup() {
  var server = new RealHTTPServer();

  var windSensorPin = 0;
  var soundSensorPin = A0;
  var temperatureSensorPin = A1;
  var waterSensorPin = A2;
  var humiditySensorPin = A3;

  pinMode(windSensorPin, INPUT);
  pinMode(soundSensorPin, INPUT);
  pinMode(temperatureSensorPin, INPUT);
  pinMode(waterSensorPin, INPUT);
  pinMode(humiditySensorPin, INPUT);

  // Temperature route
  server.route("/temperature", "GET", function (url, response) {
    response.setContentType("application/json");
    response.send(
      JSON.stringify({
        value: (analogRead(temperatureSensorPin) / 1023) * 200 - 100,
      })
    );
  });

  // Sound sensor route
  server.route("/sound", "GET", function (url, response) {
    response.setContentType("application/json");
    response.send(JSON.stringify({ value: analogRead(soundSensorPin) }));
  });

  // Wind sensor route
  server.route("/wind", "GET", function (url, response) {
    response.setContentType("application/json");
    response.send(JSON.stringify({ value: digitalRead(windSensorPin) }));
  });

  // Water sensor route
  server.route("/water", "GET", function (url, response) {
    response.setContentType("application/json");
    response.send(
      JSON.stringify({ value: (analogRead(waterSensorPin) / 255) * 100 })
    );
  });

  // Humidity sensor route
  server.route("/humidity", "GET", function (url, response) {
    response.setContentType("application/json");
    response.send(
      JSON.stringify({ value: (analogRead(humiditySensorPin) / 255) * 100 })
    );
  });

  server.start(8000);
}

function loop() {}
