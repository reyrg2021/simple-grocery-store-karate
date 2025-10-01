Feature: Happy Path 1 - Product Search Success
  Búsqueda exitosa de productos con múltiples filtros

  Background:
    * url baseUrl
    * def searchCategory = 'coffee'
    * def availableOnly = true
    * def maxResults = 5

  Scenario: Successful product search with filters
    * print 'Happy Path 1: Testing successful product search...'
    * print 'Search category:', searchCategory
    * print 'Available only:', availableOnly
    * print 'Max results:', maxResults
    
    Given path 'products'
    And param category = searchCategory
    And param available = availableOnly
    And param results = maxResults
    When method GET
    Then status 200
    And match response == '#array'
    
    * print '✅ Product search successful!'
    * print '✅ Products found:', response.length
    
    # Validar que todos los productos son de la categoría correcta
    And match each response[*].category == searchCategory
    * print '✅ All products match expected category'
    
    # Validar que todos están disponibles
    And match each response[*].inStock == true
    * print '✅ All products are available'
    
    # Validar límite de resultados
    And assert response.length <= maxResults
    * print '✅ Results within limit:', response.length, '/', maxResults
    
    # Validar estructura de cada producto
    And match each response contains
      """
      {
        id: '#number',
        name: '#string',
        category: '#string',
        inStock: '#boolean'
      }
      """
    * print '✅ All products have required properties'
    
    # Mostrar productos de ejemplo
    * def sampleProducts = response.length > 3 ? response.slice(0, 3) : response
    * print 'Sample products:'
    * karate.forEach(sampleProducts, function(p, i){ karate.log((i+1) + '. ' + p.name + ' - ID: ' + p.id + ' - Category: ' + p.category) })
    
    * print '✅ Happy Path 1 completed successfully!'