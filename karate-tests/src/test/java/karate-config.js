/**
 * karate-config.js — global configuration bootstrapped before every scenario.
 */
function fn() {
  var config = {
    baseUrl: 'https://automationintesting.online/api',

    // Shared reusable matchers – use in feature files: * match field == emailMatcher
    emailMatcher: '#regex ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$',
    phoneMatcher: '#regex^[+]?[(]?[0-9]{3}[)]?[-\\s.]?[0-9]{3}[-\\s.]?[0-9]{4,6}$'
  };

  karate.configure('connectTimeout', 10000);
  karate.configure('readTimeout',    10000);
  karate.configure('logPrettyResponse', true);

  return config;
}
