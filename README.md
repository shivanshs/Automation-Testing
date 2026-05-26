# Automation Testing — Shady Meadows B&B

End-to-end test suite for [automationintesting.online](https://automationintesting.online), built with [Playwright](https://playwright.dev/).

---

## Approach

Tests are written as black-box end-to-end tests that exercise the application through a real browser, the same way a user would. No mocking — all requests hit the live site.

### Principles

- **Role-based locators first** — `getByRole`, `getByText`, `getByTestId` are preferred over CSS selectors to make tests resilient to styling changes and meaningful to read.
- **CSS class selectors where semantic locators don't exist** — for example, `.room-card` is used to scope room-level assertions when there is no ARIA role for a card container.
- **One concern per test** — each test covers a single feature or user journey so failures are easy to diagnose.
- **No hardcoded counts** — room counts and similar totals are derived at runtime so tests stay valid when data changes.

### Test files

| File | What it covers |
|---|---|
| `tests/homepage.spec.js` | Contact form fields are visible; every listed room has a **Book now** link |
| `tests/adminpage.spec.js` | Admin login flow; dashboard and Logout button are present after login |

### Browsers

Tests run against **Chromium**, **Firefox**, and **WebKit** (Safari engine). All three are configured in `playwright.config.js` and run in parallel by default.

---

## Prerequisites

- [Node.js](https://nodejs.org/) 18 or later
- Browser binaries (installed once, see below)

```bash
npm install
npx playwright install
```

---

## Running the tests

### All tests, all browsers

```bash
npx playwright test
```

### All tests, one browser

```bash
npx playwright test --project=chromium
npx playwright test --project=firefox
npx playwright test --project=webkit
```

### A single test file

```bash
npx playwright test tests/homepage.spec.js
```

### A single test by name

```bash
npx playwright test --grep "Book now"
```

### Headed mode (watch the browser)

```bash
npx playwright test --headed
```

### Debug mode (step through with Playwright Inspector)

```bash
npx playwright test --debug
```

---

## Viewing the test report

After every test run Playwright writes an HTML report to `playwright-report/`.

### Open automatically after a run

```bash
npx playwright test && npx playwright show-report
```

### Open a previously generated report

```bash
npx playwright show-report
```

The report shows pass/fail status per test and browser, error messages with stack traces, screenshots on failure, and trace files (recorded on first retry) that can be opened in the [Playwright Trace Viewer](https://playwright.dev/docs/trace-viewer).

---

## CI/CD integration

### How it fits in a pipeline

```
┌──────────────┐    ┌───────────────────┐    ┌────────────────────┐
│  Code push   │───▶│  Build / deploy   │───▶│  Playwright tests  │
│  (PR / main) │    │  (if applicable)  │    │  (all browsers)    │
└──────────────┘    └───────────────────┘    └────────────────────┘
                                                        │
                                          ┌─────────────┴─────────────┐
                                          │  Pass → merge / release   │
                                          │  Fail → block + report    │
                                          └───────────────────────────┘
```



### Key CI behaviours (configured in `playwright.config.js`)

| Setting | Local | CI (`CI=true`) |
|---|---|---|
| Retries | 0 | 2 |
| Workers | 1 (serial) |
| `test.only` left in code | Allowed | Fails the build |
| Trace recording | On first retry | On first retry |

Set `CI=true` in your pipeline environment variables (GitHub Actions sets this automatically).

---

## Known Bugs

Issues identified during exploratory and automated testing of [automationintesting.online](https://automationintesting.online).

| # | Area | Description |
|---|------|-------------|
| 1 | Amenities | Nothing happens when the **Amenities** section is pressed |
| 2 | Booking flow | Booking does not show a proper view — only the **Check Availability** button is visible; users do not get a chance to select or view dates |
| 3 | Admin panel | **Logout** button is displayed on the admin panel even when the user is already logged out |
| 4 | Room management | No button available to edit an existing room |
| 5 | Front page | No more than 3 rooms are visible on the front page even when additional rooms have been added |
| 6 | Booking page | Booking defaults to 1 day and dates are not selectable on the booking page |
| 7 | Navigation | All **Quick Links** on the page route back to the home page instead of their respective destinations |
| 8 | Booking availability | A booked room is shown as available; attempting to book it returns an error and the page keeps spinning indefinitely |
| 9 | Booking availability | Even when a room is booked for a particular date range, it continues to be displayed on the website as available to book |

