Feature: Negative Case 2 - Add Nonexistent Item to Cart
  Validar que productos inexistentes son rechazados

  Background:
    * url baseUrl
    * def nonexistentProductId = 999999
    * def quantity = 1

  Scenario: Should reject adding nonexistent product to cart
    * print 'Negative Case 2: Testing add nonexistent item...'
    
    # Crear carrito
    Given path 'carts'
    When method POST
    Then status 201
    * def cartId = response.cartId
    * print 'Cart created:', cartId
    
    # Intentar agregar producto inexistente
    * print 'Attempting to add nonexistent product ID:', nonexistentProductId
    * print 'Expected: Should get error for invalid product'
    
    Given path 'carts', cartId, 'items'
    And request { productId: '#(nonexistentProductId)', quantity: '#(quantity)' }
    When method POST
    Then match [400, 404, 422] contains responseStatus
    And match response.error == '#string'
    
    * print '✅ Expected behavior: Invalid product properly rejected'
    * print 'Status code:', responseStatus
    * print 'Error message:', response.error
    
    # Validaciones adicionales
    And match response !contains { itemId: '#number' }
    And match response.error == '#? _.toLowerCase().includes("product") || _.toLowerCase().includes("invalid") || _.toLowerCase().includes("not found")'
    
    * print '✅ System correctly validates product existence'