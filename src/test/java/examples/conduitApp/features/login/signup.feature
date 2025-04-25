@wip
  Feature: Registro como usuario en la aplicación

    Background:
      Given url apiUrl, 'users'

    Scenario: Estoy en la página de registro
      * def json =
          """
            {
              "user": {
                "username": "costa",
                "email": "costa@karate.com",
                "password": "123123"
              }
            }
            """
      * request json
      When method POST
      Then status 201
      And response.user.username == 'username'
      * def token = response.user.token
      * print token
      * print response.user
