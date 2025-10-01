Feature: Setup - API Status Check
  Verificar que la API está disponible y funcionando correctamente

  Background:
    * url baseUrl

  @smoke
  Scenario: API is available and returns correct status
    Given path 'status'
    When method GET
    Then status 200
    And match response.status == 'UP'
    * print '✅ API Status:', response