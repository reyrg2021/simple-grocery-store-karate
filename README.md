# Simple Grocery Store - Karate API Testing

Proyecto completo de automatización de pruebas API utilizando **Karate Framework**, implementando metodologías profesionales de testing para la Simple Grocery Store API.

Migrado desde Bruno CLI con mejoras en legibilidad, paralelización y reportes.

---

## 🎯 Características

- **Framework Moderno**: Karate Framework con sintaxis BDD Gherkin
- **Cobertura Exhaustiva**: Happy paths, edge cases y negative cases
- **CI/CD Integrado**: Pipeline automatizado con GitHub Actions
- **Flujo End-to-End**: Proceso completo de compra automatizado
- **Variables Dinámicas**: Configuración flexible por ambiente
- **Reportes HTML**: Reportes interactivos automáticos
- **Paralelización**: Ejecución multi-thread para reducir tiempos

---

## 📋 Prerequisitos

- **Java 11+** (recomendado Java 17)
- **Maven 3.6+**
- **Git**

---

## 🚀 Instalación
```
git clone https://github.com/reyrg2021/simple-grocery-store-karate.git
cd simple-grocery-store-karate
java -version
mvn -version
mvn clean compile
```
---
```
## 📁 Estructura del Proyecto

simple-grocery-store-karate/
├── src/test/java/
│   ├── karate-config.js                    # Configuración global
│   ├── grocery/
│   │   ├── TestRunner.java                 # Runner principal JUnit5
│   │   └── features/
│   │       ├── 00-setup/
│   │       │   ├── status.feature          # Health check API
│   │       │   └── authentication.feature  # Generación de token
│   │       ├── 01-happy-paths/
│   │       │   ├── hp1-product-search.feature
│   │       │   └── hp2-cart-management.feature
│   │       ├── 02-edge-cases/
│   │       │   ├── ec1-cart-capacity-limit.feature
│   │       │   ├── ec2-maximum-stock-boundary.feature
│   │       │   └── ec3-different-product-stock.feature
│   │       ├── 03-negative-cases/
│   │       │   ├── nc1-order-without-auth.feature
│   │       │   └── nc2-nonexistent-item.feature
│   │       └── 04-automated-flow/
│   │           └── e2e-purchase-flow.feature
├── pom.xml
├── README.md
└── .github/workflows/
    └── karate-tests.yml
```
---

## 🧪 Casos de Prueba

### Setup & Authentication
| Test | Objetivo | Endpoint |
|------|----------|----------|
| Status Check | Verificar disponibilidad de API | GET /status |
| Authentication | Generar token de acceso | POST /api-clients |

### Happy Paths
| Test | Validaciones |
|------|--------------|
| HP1: Product Search | Filtros múltiples, categorías, disponibilidad |
| HP2: Cart Management | Crear, agregar, verificar, eliminar items |

### Edge Cases
| Test | Descubrimiento Clave |
|------|---------------------|
| EC1: Cart Capacity | Rechazo de cantidades excesivas |
| EC2: Boundary Test | Aceptación en límite exacto (14 unidades) |
| EC3: Different Products | Límites variables por producto |

### Negative Cases
| Test | Validación de Error |
|------|-------------------|
| NC1: No Authentication | 401/403 al crear orden sin token |
| NC2: Nonexistent Item | 400/404 al agregar producto inválido |

### E2E Flow
Flujo completo automatizado:

Autenticación → Crear Carrito → Agregar Items → Crear Orden → Verificar Asociación

---

## ▶️ Ejecución

### Ejecutar todos los tests
mvn test

### Ejecutar suite específica

# Solo Setup
mvn test -Dtest=TestRunner#testSetup

# Solo Happy Paths
mvn test -Dtest=TestRunner#testHappyPaths

# Solo Edge Cases
mvn test -Dtest=TestRunner#testEdgeCases

# Solo Negative Cases
mvn test -Dtest=TestRunner#testNegativeCases

# Solo E2E Flow
mvn test -Dtest=TestRunner#testAutomatedFlow

### Ver reportes HTML
Después de ejecutar los tests:

# El reporte se genera automáticamente en:
target/karate-reports/karate-summary.html

# Abrir en Windows
start target/karate-reports/karate-summary.html

# Abrir en Mac/Linux
open target/karate-reports/karate-summary.html

---

## 🔧 Configuración

### Variables de Ambiente
Editar src/test/java/karate-config.js:

var config = {
  baseUrl: 'https://simple-grocery-store-api.glitch.me',
  timeout: 10000,
  clientName: 'Karate API Tester'
};

### Ambientes

# Test (default)
mvn test

# Desarrollo
mvn test -Dkarate.env=dev

# Producción
mvn test -Dkarate.env=prod

---

## 📊 Resultados

### Cobertura de Tests
- ✅ 10 escenarios ejecutados
- ✅ 100% de endpoints críticos cubiertos
- ✅ Validaciones exhaustivas en cada caso
- ✅ Edge cases documentados (límite de 14 unidades)

### Métricas
- Status Codes: 200, 201, 400, 401, 403, 404
- HTTP Methods: GET, POST, PUT, PATCH, DELETE
- Tiempo promedio: < 10 segundos (suite completa)
---

## 🔄 CI/CD Pipeline

El proyecto incluye GitHub Actions configurado para ejecutar tests automáticamente:

- ✅ Push a main y develop
- ✅ Pull Requests
- ✅ Ejecución manual (workflow_dispatch)

Ver: .github/workflows/karate-tests.yml

---

## 🤝 Contribución

1. Fork del proyecto
2. Crear feature branch (git checkout -b feature/nueva-funcionalidad)
3. Commit cambios (git commit -m 'Agregar nueva funcionalidad')
4. Push al branch (git push origin feature/nueva-funcionalidad)
5. Crear Pull Request

---

## 🔗 API Utilizada

Simple Grocery Store API: https://github.com/vdespa/Postman-Complete-Guide-API-Testing/blob/main/simple-grocery-store-api.md

---

## 📝 Licencia

Este proyecto está bajo la Licencia MIT.

---

## 👤 Autor

Reinier Rodriguez-Guillen
- GitHub: @reyrg2021
- Proyecto: simple-grocery-store-karate

Desarrollado como parte del programa Desafío Latam + Globant

---

## 🆚 Comparación: Bruno vs Karate

| Aspecto | Bruno | Karate |
|---------|-------|--------|
| Sintaxis | JSON propietario | Gherkin BDD estándar |
| Legibilidad | Técnica | Business-friendly |
| Paralelización | Limitada | Nativa multi-thread |
| Reportes | CLI básico | HTML interactivo |
| Scripts | JavaScript async | JavaScript + Java |
| Debugging | Console logs | IDE integrado |
