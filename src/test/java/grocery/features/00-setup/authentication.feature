Feature: Setup - Generate Authentication Token
  Obtener token de autenticación para endpoints protegidos

  Background:
    * url baseUrl

  Scenario: Generate authentication token successfully
    * def timestamp = function(){ return java.lang.System.currentTimeMillis() }
    * def randomEmail = 'bruno-test-' + timestamp() + '@example.com'
    
    Given path 'api-clients'
    And request 
      """
      {
        "clientName": "#(clientName)",
        "clientEmail": "#(randomEmail)"
      }
      """
    When method POST
    Then status 201
    And match response.accessToken == '#string'
    And match response.accessToken == '#? _.length > 10'
    
    * def authToken = response.accessToken
    * karate.set('token', authToken)
    
    * print '✅ Authentication successful!'
    * print '✅ Token generated and saved:', authToken
    * print '✅ Email usado:', randomEmail
    * print '✅ Ready to proceed with API testing'