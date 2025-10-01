Feature: Negative Case 1 - Order Without Authentication
  Validar que órdenes sin autenticación son rechazadas

  Background:
    * url baseUrl

  Scenario: Should reject order creation without authentication token
    * print 'Negative Case 1: Testing order without authentication...'
    
    # Crear carrito con items
    Given path 'carts'
    When method POST
    Then status 201
    * def cartId = response.cartId
    * print 'Cart created:', cartId
    
    # Agregar item al carrito
    Given path 'carts', cartId, 'items'
    And request { productId: 4643, quantity: 2 }
    When method POST
    Then status 201
    * print 'Item added to cart'
    
    # Intentar crear orden SIN token de autenticación (removiendo header)
    * print 'Attempting to create order WITHOUT authentication'
    * print 'Expected: Should get 401/403 error'
    
    Given path 'orders'
    And request { cartId: '#(cartId)', customerName: 'Test Customer Without Auth' }
    And header Authorization = null
    When method POST
    Then match [401, 403] contains responseStatus
    And match response.error == '#string'
    
    * print '✅ Expected behavior: Unauthorized access properly rejected'
    * print 'Error message:', response.error
    
    # Validaciones adicionales
    And match response !contains { orderId: '#string' }
    And match response.error == '#? _.toLowerCase().includes("auth") || _.toLowerCase().includes("unauthorized") || _.toLowerCase().includes("token") || _.toLowerCase().includes("missing")'
    
    * print '✅ System correctly requires authentication for orders'