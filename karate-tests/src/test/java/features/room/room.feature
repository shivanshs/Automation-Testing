@room
Feature: GET /room – Room Listing Validation
  """
  Validates that the /room endpoint returns a list of available rooms,
  that the list is a non-empty array, and that atleast one room has a price
  greater than zero.
  """

  Background:
    * url baseUrl

  Scenario: Response contains a rooms array
    Given path '/room'
    When  method GET
    Then  status 200
    And   match response.rooms == '#array'

  Scenario: At least one room is returned
    Given path '/room'
    When  method GET
    Then  status 200
    And   assert response.rooms.length > 0

  Scenario: Every room has a price greater than zero
    Given path '/room'
    When  method GET
    Then  status 200
    # each() iterates over the array
    And   match each response.rooms contains { roomPrice: '#? _ > 0' }
 
