var server = new RealHTTPServer();

function getRandomValue(min, max) {
  return Math.random() * (max - min) + min;
}

// Temperature route
server.route("/temperature", "GET", function (url, response) {
  response.setContentType("application/json");
  response.send(JSON.stringify({ value: getRandomValue(10, 100) }));
});

// Sound sensor route
server.route("/sound", "GET", function (url, response) {
  response.setContentType("application/json");
  response.send(JSON.stringify({ value: getRandomValue(30, 130) })); // Assuming sound in decibels (dB)
});

// Wind sensor route
server.route("/wind", "GET", function (url, response) {
  response.setContentType("application/json");
  response.send(JSON.stringify({ value: getRandomValue(0, 150) })); // Assuming wind speed in km/h
});

// Water sensor route
server.route("/water", "GET", function (url, response) {
  response.setContentType("application/json");
  response.send(JSON.stringify({ value: getRandomValue(0, 100) })); // Assuming water level or flow in percentage or liters
});

// Humidity sensor route
server.route("/humidity", "GET", function (url, response) {
  response.setContentType("application/json");
  response.send(JSON.stringify({ value: getRandomValue(0, 100) })); // Assuming humidity in percentage (%)
});

server.start(8080);
