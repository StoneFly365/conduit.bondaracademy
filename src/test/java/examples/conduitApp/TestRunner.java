package examples.conduitApp;

import com.intuit.karate.junit5.Karate;

class TestRunner {
    
    @Karate.Test
    Karate testRunner() {
        return Karate.run().relativeTo(getClass());
    }    

}
