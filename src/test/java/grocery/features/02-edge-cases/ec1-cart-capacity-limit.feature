Feature: Edge Case 1 - Cart Capacity Limit
  Probar límites de cantidad por producto

  Background:
    * url baseUrl
    * def productId = 4643
    * def excessiveQuantity = 15

  Scenario: Should reject quantity above stock limit
    * print 'Edge Case 1: Testing cart capacity limits...'
    
    # Crear carrito
    Given path 'carts'
    When method POST
    Then status 201
    * def cartId = response.cartId
    * print 'Cart created:', cartId
    * print 'Testing quantity above stock limit:', excessiveQuantity
    
    # Intentar agregar cantidad excesiva (15 unidades del producto 4643)
    Given path 'carts', cartId, 'items'
    And request { productId: '#(productId)', quantity: '#(excessiveQuantity)' }
    When method POST
    Then status 400
    And match response.error == '#string'
    And match response.error contains 'stock'
    * print '✅ System properly rejected excessive quantity'
    * print 'Error message:', response.error
    
    # Validar mensaje descriptivo
    And match response.error == '#? _.length > 10'
    * print '✅ Error message is descriptive'