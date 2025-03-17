# Más ejemplos sobre pruebas basadas en datos: https://github.com/karatelabs/karate?tab=readme-ov-file#data-driven-tests

Feature: Sign Up new user

    Background: Preconditions
        * def dataGenerator = Java.type('examples.conduitApp.helpers.DataGenerator')
        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUsername()
        * url apiUrl

    # El motivo de ignorar este escenario es, por cada ejecución se crean nuevos usuarios en la base de datos. Por lo tanto, lo usaremos solo para pruebas locales.
    @ignore
    Scenario: New user Sign Up
        # Given def userData = {"email":"karateRaul4@test.com", "username":"karateRaul4"}
        Given path '/users'
        # Definición de la solicitud en una sola línea
        # And request {"user":{"email":#('Test'+userData.email),"password":"karate1234","username":#('User'+userData.username)}}
        # Definición de la solicitud en varias líneas
        And request
        """
        {
            "user": {
                "email": #(randomEmail),
                "password": "karate1234",
                "username": #(randomUsername)
            }
        }
        """
        # """
        # {
        #     "user": {
        #         "email": #(userData.email),
        #         "password": "karate1234",
        #         "username": #(userData.username)
        #     }
        # }
        # """
        When method Post
        Then status 201
        And match response ==
        """
            {
                "user": {
                    "id": "#number",
                    "email": #(randomEmail),
                    "username": #(randomUsername),
                    "bio": null,
                    "image": "#string",
                    "token": "#string"
                }
            }
        """

    @smokeTest
    Scenario Outline: Validate Sign Up error messages
        Given path '/users'
        And request
        """
        {
            "user": {
                "email": "<email>",
                "password": "<password>",
                "username": "<username>"
            }
        }
        """
        When method Post
        Then status 422
        And match response == <errorResponse>

        Examples:
            | email                 | password   | username          | errorResponse                                      |
            | #(randomEmail)        | karate1234 | karateRaul25      | {"errors":{"username":["has already been taken"]}} |
            | karateRaul25@test.com | karate1234 | #(randomUsername) | {"errors":{"email":["has already been taken"]}}    |
            | #(randomEmail)        | karate1234 |                   | {"errors":{"username":["can't be blank"]}}         |
            |                       | karate1234 | #(randomUsername) | {"errors":{"email":["can't be blank"]}}            |
            | #(randomEmail)        |            | #(randomUsername) | {"errors":{"password":["can't be blank"]}}         |