package runner;

import com.intuit.karate.junit5.Karate;

/**
 * Single runner for all API test suites.
 *
 * Run everything:       mvn test -Dtest=TestRunner#testAll
 * Run branding only:    mvn test -Dtest=TestRunner#testBranding
 * Run room only:        mvn test -Dtest=TestRunner#testRoom
 * Run booking only:     mvn test -Dtest=TestRunner#testBooking
 */
class TestRunner {

    @Karate.Test
    Karate testAll() {
        return Karate.run("classpath:features");
    }

    @Karate.Test
    Karate testBranding() {
        return Karate.run("classpath:features/branding/branding.feature");
    }

    @Karate.Test
    Karate testRoom() {
        return Karate.run("classpath:features/room/room.feature");
    }

    @Karate.Test
    Karate testBooking() {
        return Karate.run("classpath:features/booking/booking.feature");
    }
}
