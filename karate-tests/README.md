# Karate API Tests – Shady Meadows B&B

API test suite built with [Karate DSL](https://karatelabs.github.io/karate/) and JUnit 5.

## Folder Structure

```
karate-tests/
├── pom.xml                                         Maven build + Karate dependency
└── src/
    └── test/
        └── java/
            ├── karate-config.js                    Global config (base URL, shared matchers)
            ├── runner/
            │   └── TestRunner.java                 Single runner for all suites
            └── features/
                ├── branding/
                │   └── branding.feature            GET /branding scenarios
                ├── room/
                │   └── room.feature                GET /room scenarios
                └── booking/
                    └── booking.feature             POST /booking scenarios
```

---

## Prerequisites

| Tool  | Minimum version |
|-------|-----------------|
| Java  | 11              |
| Maven | 3.8             |

---

## Running the tests

### Run the full suite
```bash
cd karate-tests
mvn test
```

### Run a specific suite
```bash
mvn test -Dtest=TestRunner#testBranding
mvn test -Dtest=TestRunner#testRoom
mvn test -Dtest=TestRunner#testBooking
```

---

## Base URL

Fixed to `https://automationintesting.online`. Change it in `src/test/java/karate-config.js`.

---

## Feature Suites

| Suite | Endpoint | Runner method | Scenarios |
|-------|----------|---------------|-----------|
| Branding | `GET /branding` | `testBranding` | Name exact match, email regex, contact details, description, map coordinates, full schema, idempotency, negative POST |
| Room | `GET /room` | `testRoom` | Array check, min one room, every price > 0, full schema per room, idempotency |
| Booking | `POST /booking/` | `testBooking` | Creates booking with dynamic roomid, echoes name/dates/depositpaid, full schema, negative missing fields |

---

## Test Report

After a run, an HTML report is written to:
```
target/karate-reports/karate-summary.html
```

---

## Karate Matchers Reference

| Matcher                 | Meaning                                      |
|-------------------------|----------------------------------------------|
| `'Exact Value'`         | Strict equality                              |
| `'#string'`             | Must be a non-null string                    |
| `'#number'`             | Must be a number (int or float)              |
| `'#boolean'`            | Must be `true` or `false`                    |
| `'#notnull'`            | Must not be `null`                           |
| `'#null'`               | Must be `null`                               |
| `'#array'`              | Must be a JSON array                         |
| `'#object'`             | Must be a JSON object                        |
| `'#regex <pattern>'`    | Must match the regular expression            |

---

## Adding New Microservice Tests

1. Create a new folder under `src/test/java/features/<service-name>/`.
2. Add a `<service>.feature` file following the same conventions.
3. Add a `@Karate.Test` method to `TestRunner.java`.
4. `testAll()` will also pick it up automatically.
