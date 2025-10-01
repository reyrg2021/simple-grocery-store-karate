Feature: Edge Case 2 - Maximum Stock Boundary
  Probar exactamente en el límite máximo permitido

  Background:
    * url baseUrl
    * def productId = 4643
    * def boundaryQuantity = 14

  Scenario: Should accept maximum allowed quantity at boundary
    * print 'Edge Case 2: Testing maximum stock boundary...'
    
    # Crear carrito
    Given path 'carts'
    When method POST
    Then status 201
    * def cartId = response.cartId
    * print 'Cart created:', cartId
    * print 'Testing maximum allowed quantity:', boundaryQuantity
    * print 'Expected: Should succeed at boundary limit'
    
    # Agregar exactamente 14 unidades (límite máximo)
    Given path 'carts', cartId, 'items'
    And request { productId: '#(productId)', quantity: '#(boundaryQuantity)' }
    When method POST
    Then status 201
    And match response.itemId == '#number'
    * print '✅ Boundary test successful!'
    * print 'Item ID:', response.itemId
    * print 'Maximum quantity accepted:', boundaryQuantity
    * print 'System correctly handles boundary limit'
    
    # Verificar que no hay error
    And match response !contains { error: '#string' }