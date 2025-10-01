package grocery;

import com.intuit.karate.junit5.Karate;

/**
 * Test Runner Principal
 * Ejecuta todos los tests de Karate organizados por categorías
 */
public class TestRunner {
    
    @Karate.Test
    Karate testSetup() {
        return Karate.run("classpath:grocery/features/00-setup")
                .relativeTo(getClass());
    }
    
    @Karate.Test
    Karate testHappyPaths() {
        return Karate.run("classpath:grocery/features/01-happy-paths")
                .tags("~@ignore")
                .relativeTo(getClass());
    }
     
    @Karate.Test
    Karate testEdgeCases() {
        return Karate.run("classpath:grocery/features/02-edge-cases")
                .relativeTo(getClass());
    }
    
    @Karate.Test
    Karate testNegativeCases() {
        return Karate.run("classpath:grocery/features/03-negative-cases")
                .relativeTo(getClass());
    }
    
    @Karate.Test
    Karate testAutomatedFlow() {
        return Karate.run("classpath:grocery/features/04-automated-flow")
                .relativeTo(getClass());
    }
    
  
    
}