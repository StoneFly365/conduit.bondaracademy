function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://conduit-api.bondaracademy.com/api/',
    proxy: 'http://localhost:8081'  // Línea añadida
  }
  karate.log('Proxy configurado en:', config.proxy); // Línea de registro añadida
  if (env == 'dev') {
    config.userEmail = 'karateRaul@test.com'
    config.userPassword = 'karate123'
  } else if (env == 'qa') {
    config.userEmail = 'karate2@test.com'
    config.userPassword = 'karate567'
  }

  karate.configure('logPrettyRequest', true);
  karate.configure('logPrettyResponse', true);

  var accessToken = karate.callSingle('classpath:examples/conduitApp/helpers/createToken.feature', config).authToken;
  karate.configure('headers', {Authorization: 'Token ' + accessToken});

  return config;
}