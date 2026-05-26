@branding
Feature: GET /branding – Branding Information Validation
  """
  Validates that the /branding endpoint returns the correct hotel identity
  information for Shady Meadows B&B, including name

  Dynamic / environment-specific fields (IDs, timestamps) are validated
  with Karate type-matchers rather than literal values.

  Base URL and shared matchers come from karate-config.js.
  """

  Background:
    * url baseUrl
    # Re-use the shared matchers defined in karate-config.js
    * def email = emailMatcher
    * def phone = phoneMatcher

  Scenario: GET /branding returns HTTP 200 and a JSON body
    Given path '/branding'
    When  method GET
    Then  status 200
    And   match header Content-Type contains 'application/json'
    And   match response == '#object'

  Scenario: Hotel name is exactly "Shady Meadows B&B"
    Given path '/branding'
    When  method GET
    Then  status 200
    And   match response.name == 'Shady Meadows B&B'

  Scenario: Contact email is present and matches a valid email format
    Given path '/branding'
    When  method GET
    Then  status 200
    # '#regex …' matcher – value must satisfy the regular expression
    And   match response.contact.email == email

  Scenario: Contact phone is present and matches a valid phone format
    Given path '/branding'
    When  method GET
    Then  status 200
    And   match response.contact.phone == phone