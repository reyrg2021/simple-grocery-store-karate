Feature: Happy Path 2 - Cart Management Success
  Operaciones básicas de carrito funcionando correctamente

  Background:
    * url baseUrl
    * def productId = 4643
    * def quantity = 2

  Scenario: Complete cart management workflow
    * print 'Happy Path 2: Testing successful cart management...'
    
    # Paso 1: Crear carrito vacío
    Given path 'carts'
    When method POST
    Then status 201
    And match response.created == true
    * def cartId = response.cartId
    * print '✅ Cart created with ID:', cartId
    
    # Paso 2: Verificar carrito vacío
    Given path 'carts', cartId
    When method GET
    Then status 200
    And match response.items == '#[0]'
    * print '✅ Cart verified empty'
    
    # Paso 3: Agregar item al carrito
    Given path 'carts', cartId, 'items'
    And request { productId: '#(productId)', quantity: '#(quantity)' }
    When method POST
    Then status 201
    * def itemId = response.itemId
    * print '✅ Item added with ID:', itemId
    
    # Paso 4: Verificar item agregado
    Given path 'carts', cartId
    When method GET
    Then status 200
    And match response.items == '#[1]'
    And match response.items[0].productId == productId
    And match response.items[0].quantity == quantity
    * print '✅ Cart contains added item correctly'
    
    # Paso 5: Agregar segundo producto
    Given path 'carts', cartId, 'items'
    And request { productId: 8739, quantity: 3 }
    When method POST
    Then status 201
    * def itemId2 = response.itemId
    * print '✅ Second item added'
    
    # Paso 6: Verificar carrito con 2 items
    Given path 'carts', cartId
    When method GET
    Then status 200
    And match response.items == '#[2]'
    And match response.items[*].productId contains [4643, 8739]
    * print '✅ Cart contains 2 items'
    
    # Paso 7: Eliminar primer item
    Given path 'carts', cartId, 'items', itemId
    When method DELETE
    Then status 204
    * print '✅ First item deleted'
    
    # Paso 8: Verificar que solo queda 1 item
    Given path 'carts', cartId
    When method GET
    Then status 200
    And match response.items == '#[1]'
    And match response.items[0].productId == 8739
    * print '✅ Cart final verified with 1 item'
    * print '✅ Happy Path 2 completed successfully!'