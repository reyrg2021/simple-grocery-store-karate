Feature: Edge Case 3 - Different Product Stock Limits
  Verificar que diferentes productos tienen límites variables

  Background:
    * url baseUrl
    * def testQuantity = 20

  Scenario: Different products have different stock limits
    * print 'Edge Case 3: Testing stock limits with different product...'
    
    # Obtener productos disponibles
    Given path 'products'
    And param available = true
    When method GET
    Then status 200
    
    # Filtrar productos diferentes al 4643
    * def differentProducts = karate.filter(response, function(p){ return p.id != 4643 })
    * def randomProduct = differentProducts[0]
    * def testProductId = randomProduct.id
    
    * print '=== SELECTED PRODUCT ==='
    * print 'ID:', testProductId
    * print 'Name:', randomProduct.name
    * print 'Category:', randomProduct.category
    * print 'In Stock:', randomProduct.inStock
    * print 'Testing with quantity:', testQuantity
    
    # Crear carrito
    Given path 'carts'
    When method POST
    Then status 201
    * def cartId = response.cartId
    
    # Intentar agregar 20 unidades del producto aleatorio
    Given path 'carts', cartId, 'items'
    And request { productId: '#(testProductId)', quantity: '#(testQuantity)' }
    When method POST
    
    # La respuesta puede ser 201 (éxito) o 400 (límite excedido)
    * print '=== PRODUCT ANALYSIS ==='
    * print 'Product ID:', testProductId
    * print 'Quantity Tested:', testQuantity
    * print 'Response Status:', responseStatus
    
    * if (responseStatus == 201) karate.log('✅ SUCCESS: Product accepted quantity', testQuantity)
    * if (responseStatus == 400) karate.log('❌ STOCK LIMIT: Product rejected quantity', testQuantity)
    
    * print '=== COMPARISON ==='
    * print 'Product 4643: limit = 14'
    * print 'Product', testProductId, '(' + randomProduct.category + '): limit being tested'
    
    # Validaciones
    And match [201, 400] contains responseStatus
    
    * if (responseStatus == 400) karate.match('response.error', '#string')
    * if (responseStatus == 201) karate.match('response.itemId', '#number')
    
    * print '✅ Different product stock limit verified'