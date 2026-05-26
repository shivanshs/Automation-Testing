@booking
Feature: POST /booking – Create a New Booking
  """
  Validates that the POST /booking endpoint successfully creates a booking.
  A valid roomid is resolved dynamically from GET /room before any scenario
  runs.

  Payload requirements: roomid, firstname, lastname, depositpaid (boolean),
  bookingdates { checkin, checkout }.
  """

  Background:
    * url baseUrl

    # ── Resolve a valid roomid once for the entire feature ─────────────────
    * def roomId =
      """
      (function(){
        var res = karate.http(karate.get('baseUrl')).path('/room').get();
        var rooms = res.body.rooms;
        if (!rooms || rooms.length === 0) karate.fail('No rooms returned by GET /room');
        return rooms[0].roomid;
      })()
      """

    # ── Generate future dates so bookings never clash with today ───────────
    * def checkin  = java.time.LocalDate.now().plusDays(21).toString()
    * def checkout = java.time.LocalDate.now().plusDays(24).toString()

    # ── Reusable valid payload ─────────────────────────────────────────────
    * def bookingPayload =
      """
      {
        "roomid":      #(roomId),
        "firstname":   "James",
        "lastname":    "Dean",
        "depositpaid": true,
        "bookingdates": {
          "checkin":  "#(checkin)",
          "checkout": "#(checkout)"
        },
        "email": "james.dean@example.com",
        "phone": "01234567890"
      }
      """

  Scenario: Booking is successful
    Given path '/booking/'
    And   header Content-Type = 'application/json'
    And   request bookingPayload
    When  method POST
    Then  status 201
    And   match response.bookingid == '#number'
    And   assert response.bookingid > 0
    

 
