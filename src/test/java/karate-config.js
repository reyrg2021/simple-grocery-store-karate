function fn() {
  var env = karate.env;
  karate.log('karate.env system property was:', env);
  
  if (!env) {
    env = 'test';
  }
  
  var config = {
    baseUrl: 'https://simple-grocery-store-api.glitch.me',
    timeout: 10000,
    clientName: 'Karate API Tester',
    customerName: 'Karate Test Customer',
    testComment: 'Automated test order via Karate'
  };
  
  if (env === 'dev') {
    config.baseUrl = 'https://simple-grocery-store-api.glitch.me';
  } else if (env === 'test') {
    config.baseUrl = 'https://simple-grocery-store-api.glitch.me';
  }
  
  karate.log('Using baseUrl:', config.baseUrl);
  karate.configure('connectTimeout', config.timeout);
  karate.configure('readTimeout', config.timeout);
  
  return config;
}