Feature: Automated E2E Purchase Flow
  Flujo completo automatizado: Autenticación → Carrito → Items → Orden

  Background:
    * url baseUrl
    * def customerName = 'Karate Test Customer'
    * def testComment = 'Automated test order via Karate'

  Scenario: Complete end-to-end purchase workflow
    * print '========================================='
    * print 'STARTING AUTOMATED E2E PURCHASE FLOW'
    * print '========================================='
    
    # PASO 0: Generar Token de Autenticación
    * print 'Step 0: Generating authentication token...'
    * def timestamp = function(){ return java.lang.System.currentTimeMillis() }
    * def flowEmail = 'karate-e2e-' + timestamp() + '@test.com'
    
    Given path 'api-clients'
    And request { clientName: 'Karate E2E Flow', clientEmail: '#(flowEmail)' }
    When method POST
    Then status 201
    * def authToken = response.accessToken
    * print '✅ Token generated for flow'
    
    # PASO 1: Crear Carrito Vacío
    * print ''
    * print 'Step 1: Creating new cart...'
    Given path 'carts'
    When method POST
    Then status 201
    * def cartId = response.cartId
    * print '✅ Cart created with ID:', cartId
    
    # PASO 2: Verificar Carrito Vacío
    * print ''
    * print 'Step 2: Verifying cart is empty...'
    Given path 'carts', cartId
    When method GET
    Then status 200
    And match response.items == '#[0]'
    * print '✅ Cart verified empty'
    
    # PASO 3: Obtener Productos Disponibles
    * print ''
    * print 'Step 3: Getting available products...'
    Given path 'products'
    And param available = true
    When method GET
    Then status 200
    * def availableProducts = response
    * def randomIndex = Math.floor(Math.random() * availableProducts.length)
    * def selectedProduct = availableProducts[randomIndex]
    * def productId1 = selectedProduct.id
    * print '✅ Random product selected:', selectedProduct.name
    * print '   Product ID:', productId1
    
    # PASO 4: Agregar Primer Item al Carrito
    * print ''
    * print 'Step 4: Adding first item to cart...'
    Given path 'carts', cartId, 'items'
    And request { productId: '#(productId1)', quantity: 2 }
    When method POST
    Then status 201
    * def itemId1 = response.itemId
    * print '✅ First item added with ID:', itemId1
    
    # PASO 5: Agregar Segundo Item (producto fijo conocido)
    * print ''
    * print 'Step 5: Adding second item to cart...'
    Given path 'carts', cartId, 'items'
    And request { productId: 4643, quantity: 3 }
    When method POST
    Then status 201
    * def itemId2 = response.itemId
    * print '✅ Second item added with ID:', itemId2
    
    # PASO 6: Verificar Items en el Carrito
    * print ''
    * print 'Step 6: Verifying cart contents...'
    Given path 'carts', cartId
    When method GET
    Then status 200
    And match response.items == '#[2]'
    * print '✅ Cart contains 2 items correctly'
    * karate.forEach(response.items, function(item, i){ karate.log((i+1) + '. Product ID: ' + item.productId + ', Quantity: ' + item.quantity) })
    
    # PASO 7: Obtener Detalles de Items
    * print ''
    * print 'Step 7: Getting cart items details...'
    Given path 'carts', cartId, 'items'
    When method GET
    Then status 200
    And match response == '#[2]'
    * print '✅ Cart items retrieved successfully'
    
    # PASO 8: Crear Orden con Autenticación
    * print ''
    * print 'Step 8: Creating order with authentication...'
    * print 'Token available:', authToken ? 'Yes' : 'No'
    
    Given path 'orders'
    And header Authorization = 'Bearer ' + authToken
    And request { cartId: '#(cartId)', customerName: '#(customerName)', comment: '#(testComment)' }
    When method POST
    Then status 201
    * def orderId = response.orderId
    * print '✅ Order created successfully!'
    * print '   Order ID:', orderId
    * print '   Created at:', response.created
    
    # PASO 9: Verificar Asociación Orden-Carrito
    * print ''
    * print 'Step 9: Verifying order-cart association...'
    Given path 'orders', orderId
    And header Authorization = 'Bearer ' + authToken
    When method GET
    Then status 200
    And match response.id == orderId
    And match response.items == '#[2]'
    And match response.customerName == customerName
    * print '✅ Order verification successful!'
    * print '   Customer:', response.customerName
    * print '   Items in order:', response.items.length
    
    * print ''
    * print 'Order contains the following items:'
    * karate.forEach(response.items, function(item, i){ karate.log((i+1) + '. Product ID: ' + item.productId + ', Quantity: ' + item.quantity) })
    
    # VALIDACIONES FINALES
    And match response contains
      """
      {
        id: '#(orderId)',
        customerName: '#(customerName)',
        items: '#[2]',
        created: '#string'
      }
      """
    
    * print ''
    * print '========================================='
    * print '✅ E2E FLOW COMPLETED SUCCESSFULLY!'
    * print 'Cart → Items → Order → Verification'
    * print '========================================='